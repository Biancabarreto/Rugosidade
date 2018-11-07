function Y = eval_splines(P,XINT,X)

    Y=zeros(size(X));
    N=length(X);
    NPARTS=size(P,1);

    for II=1:N
        for JJ=1:NPARTS
            if( (X(II)>=XINT(JJ,1))&&(X(II)<=XINT(JJ,2)) )
            Y(II)=polyval(P(JJ,:),X(II));
            end
        end
    endfor

endfunction
