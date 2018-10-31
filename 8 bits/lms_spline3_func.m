function [P XINT]=lms_spline3_func(X,Y,NPARTS,varargin)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Retorna la pendiente al inicio e final
    [X Y W]=check_parameters(X,Y,NPARTS,varargin{:});

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Retorna Xs datos X por grupos, son NPARTS grupos    
    % Retorna Ys datos Y por grupos, son NPARTS grupos
    % Retorna XINT intervalos de X, son NPARTS grupos
    [Xs Ys XINT Ws]=generate_Xs_Ys_XINT(X,Y,NPARTS,W);

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Yz=Az*p

    [Yz Az Cz]=generate_values_z(Xs,Ys,Ws);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 0=A0*p
    Y0=zeros(NPARTS-1,1);
    A0=zeros(NPARTS-1,size(NPARTS*4,1));
    C0=zeros(NPARTS-1,1);

    KK=1;
    for II=1:(NPARTS-1)

        Y0(II)=0;
        C0(II)=sum(Ws{II})+sum(Ws{II+1});

        A0(II,4*(II-1)+1)=XINT(II,2)^3;
        A0(II,4*(II-1)+2)=XINT(II,2)^2;
        A0(II,4*(II-1)+3)=XINT(II,2);
        A0(II,4*(II-1)+4)=1;

        A0(II,4*(II-1)+5)=-XINT(II,2)^3;
        A0(II,4*(II-1)+6)=-XINT(II,2)^2;
        A0(II,4*(II-1)+7)=-XINT(II,2);
        A0(II,4*(II-1)+8)=-1;

    endfor

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 0=A1*p
    Y1=zeros(NPARTS-1,1);
    A1=zeros(NPARTS-1,size(NPARTS*4,1));
    C1=zeros(NPARTS-1,1);

    KK=1;
    for II=1:(NPARTS-1)

        Y1(II)=0;
        C1(II)=sum(Ws{II})+sum(Ws{II+1});

        A1(II,4*(II-1)+1)=3*XINT(II,2)^2;
        A1(II,4*(II-1)+2)=2*XINT(II,2);
        A1(II,4*(II-1)+3)=1;
        A1(II,4*(II-1)+4)=0;

        A1(II,4*(II-1)+5)=-3*XINT(II,2)^2;
        A1(II,4*(II-1)+6)=-2*XINT(II,2);
        A1(II,4*(II-1)+7)=-1;
        A1(II,4*(II-1)+8)=0;

    endfor

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 0=A2*p
    Y2=zeros(NPARTS-1,1);
    A2=zeros(NPARTS-1,size(NPARTS*4,1));
    C2=zeros(NPARTS-1,1);

    KK=1;
    for II=1:(NPARTS-1)

        Y2(II)=0;
        C2(II)=sum(Ws{II})+sum(Ws{II+1});

        A2(II,4*(II-1)+1)=6*XINT(II,2);
        A2(II,4*(II-1)+2)=2;
        A2(II,4*(II-1)+3)=0;
        A2(II,4*(II-1)+4)=0;

        A2(II,4*(II-1)+5)=-6*XINT(II,2);
        A2(II,4*(II-1)+6)=-2;
        A2(II,4*(II-1)+7)=0;
        A2(II,4*(II-1)+8)=0;

    endfor
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    At=[Az;A0;A1;A2];
    Yt=[Yz;Y0;Y1;Y2];
    C=diag([Cz;C0*9;C1*3;C2*1]);


    p=inv(At'*C*At)*At'*C*Yt;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Finalmente convertimos p em P
    P=zeros(NPARTS,4);
    for II=1:NPARTS
        P(II,:)=p( (4*(II-1)+1):(4*(II-1)+4) );
    endfor

endfunction

function [Yz Az Cz]=generate_values_z(Xs,Ys,Ws)

    NPARTS=size(Xs,1);
    N=0;
    for II=1:NPARTS
        N=N+length(Xs{II});
    endfor

    Yz=zeros(N,1);
    Az=zeros(N,size(NPARTS*4,1));
    Cz=zeros(N,1);
    
    KK=1;
    for II=1:NPARTS
        NN=length(Xs{II});
 
        for JJ=1:NN
            Yz(KK)=Ys{II}(JJ);
            Cz(KK)=Ws{II}(JJ);

            Az(KK,4*(II-1)+1)=Xs{II}(JJ)^3;
            Az(KK,4*(II-1)+2)=Xs{II}(JJ)^2;
            Az(KK,4*(II-1)+3)=Xs{II}(JJ);
            Az(KK,4*(II-1)+4)=1;

            KK=KK+1;
        endfor
    endfor

endfunction

function [Xs Ys XINT Ws]=generate_Xs_Ys_XINT(X,Y,NPARTS,W)


    XINT=zeros(NPARTS,2);
    MINX=min(X);
    MAXX=max(X);

    Xpart=linspace(MINX,MAXX,NPARTS+1);

    Xs  =cell(NPARTS,1);
    Ys  =cell(NPARTS,1);
    Ws  =cell(NPARTS,1);
    
    N=length(X);

    for II=1:NPARTS
        XINT(II,1)=Xpart(II);
        XINT(II,2)=Xpart(II+1);

        for JJ=1:N
            if( (X(JJ)>=XINT(II,1)) && (X(JJ)<=XINT(II,2)) )
                Xs{II}=[Xs{II} X(JJ)];
                Ys{II}=[Ys{II} Y(JJ)];
                Ws{II}=[Ws{II} W(JJ)];
            end
        end

    endfor
endfunction

function [X Y W]=check_parameters(X,Y,NPARTS,varargin)

    if(~isvector(X))
        error('X should be a vector');
    end
    if(~isvector(Y))
        error('Y should be a vector');
    end

    if(length(X)~=length(Y))
        error('The length of X and Y should be equals');
    end

    if( (size(X,1)==1)&&(size(X,2)~=1) )
        X=X';
    endif

    if( (size(Y,1)==1)&&(size(Y,2)~=1) )
        Y=Y';
    endif

    E=0;

    if(nargin>3)
        W=abs(varargin{1});
    else
        W=ones(size(X));
    end

    [X id]=sort(X);
    Y=Y(id);
    W=W(id);

endfunction
