function [curves1, curves2, ID1, ID2]=func_kmeans2(VARS_MAT)

    N=size(VARS_MAT,1);
    M=size(VARS_MAT,2);

    [MAX IDMAX]=max(VARS_MAT(:,round(M/2)));
    [MIN IDMIN]=min(VARS_MAT(:,round(M/2)));

    c1=VARS_MAT(IDMIN,:);
    c2=VARS_MAT(IDMAX,:);

    for KK=1:20
        G1={};
        G2={};
        for II=1:N
            d1=dist_between_curves(c1,VARS_MAT(II,:));
            d2=dist_between_curves(c2,VARS_MAT(II,:));
            if(d1>d2)
                G1{end+1}=II;
            else
                G2{end+1}=II;
            endif    
        endfor

        nc1=get_new_mean_curve(VARS_MAT,G1);
        nc2=get_new_mean_curve(VARS_MAT,G2);
        
        dc1=dist_between_curves(c1,nc1);
        dc2=dist_between_curves(c2,nc2);
        fprintf(stdout,'dc1:%f dc2:%f    \n',dc1,dc2);
        
        c1=nc1;
        c2=nc2;
    endfor

    curves1=zeros(length(G1),M);
    ID1=zeros(length(G1),1);
    for II=1:length(G1);
        curves1(II,:)=VARS_MAT(G1{II},:);
        ID1(II)=G1{II};
    endfor

    curves2=zeros(length(G2),M);
    ID2=zeros(length(G2),1);
    for II=1:length(G2);
        curves2(II,:)=VARS_MAT(G2{II},:);
        ID2(II)=G2{II};
    endfor

endfunction


function d=dist_between_curves(c1,c2)
    d=mean(abs(c1-c2));
endfunction

function cc=get_new_mean_curve(VARS_MAT,G)
    N=length(G);
    cc=zeros(1,size(VARS_MAT,2));
    for II=1:N
        cc=cc+VARS_MAT(G{II},:);
    endfor
    cc=cc/N;
endfunction
