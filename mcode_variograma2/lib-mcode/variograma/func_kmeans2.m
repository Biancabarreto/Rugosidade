function [curves1, curves2, IDG, c1, c2]=func_kmeans2(VARS_MAT)

    N=size(VARS_MAT,1);
    M=size(VARS_MAT,2);

    PLOT_ITERATION=false;

    [MAX IDMAX]=max(VARS_MAT(:,round(M/2)));
    [MIN IDMIN]=min(VARS_MAT(:,round(M/2)));

    c1=zeros(size(VARS_MAT(1,:)));
    c2=VARS_MAT(IDMAX,:);

    format long

    for KK=1:50

	if PLOT_ITERATION==true
		figure
		plot(	[1:M],c1,'-ro','markersize',12,'linewidth',4, ...
			[1:M],c2,'-bs','markersize',12,'linewidth',4, ...
			[1:M],VARS_MAT,'k-', ...
			[1:M],c1,'-ro','markersize',12,'linewidth',4, ...
			[1:M],c2,'-bs','markersize',12,'linewidth',4);
		legend('c1','c2')
	endif

        G1={};
        G2={};
        for II=1:N
            d1=dist_between_curves(c1,VARS_MAT(II,:));
            d2=dist_between_curves(c2,VARS_MAT(II,:));
            if(d1<d2)
                G1{end+1}=II;
            else
                G2{end+1}=II;
            endif    
        endfor

        %nc1=get_new_mean_curve(VARS_MAT,G1);
        nc1=c1;
        nc2=get_new_mean_curve(VARS_MAT,G2);
        
        dc1=dist_between_curves(c1,nc1);
        dc2=dist_between_curves(c2,nc2);
        %fprintf(stdout,'ITER:%d\tdc1:%f\tdc2:%f    \n',KK,dc1,dc2);
        
        c1=nc1;
        c2=nc2;


	if((dc1==0)&&(dc2==0))
	break;
	endif
    endfor

    IDG=zeros(N,1);

    curves1=zeros(length(G1),M);
    for II=1:length(G1);
        curves1(II,:)=VARS_MAT(G1{II},:);
        IDG(G1{II})=1;
    endfor

    curves2=zeros(length(G2),M);
    for II=1:length(G2);
        curves2(II,:)=VARS_MAT(G2{II},:);
        IDG(G2{II})=2;
    endfor

endfunction


function d=dist_between_curves(c1,c2)
    d= mean(abs(c1-c2)); % norm(c1-c2);%
endfunction

function cc=get_new_mean_curve(VARS_MAT,G)
    N=length(G);
    cc=zeros(1,size(VARS_MAT,2));
    for II=1:N
        cc=cc+VARS_MAT(G{II},:);
    endfor
    cc=cc/N;
endfunction
