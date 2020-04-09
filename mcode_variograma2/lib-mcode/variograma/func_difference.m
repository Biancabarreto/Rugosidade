function D=func_difference(X,ID)
    N=length(X);

    XID=zeros(size(X));
    XID((1+ID):N)=X(1:(N-ID));

    D=X-XID;
    D=D((1+ID):N);

endfunction
