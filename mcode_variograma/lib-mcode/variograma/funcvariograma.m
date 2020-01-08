function [V,DIFF]=funcvariograma(X)
    N=length(X);
    V=zeros(size(X));
    V=V(1:(end-1));
    DIFF=zeros(size(V));


    for II=1:length(V)
        D=func_difference(X,II);

        DIFF(II)=II;
        V(II)=mean(D.^2);
    endfor
   
endfunction


