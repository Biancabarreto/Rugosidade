function C=function_system(K , X)

    const_c0=K(:,1);
    const_d0=K(:,2);

    h0=X(1);
    D =X(2);
    theta=X(3);

    C=zeros(size(const_c0));
    N=length(const_c0);

    for II=1:N
        C(II)=function_get_c(const_c0(II), const_d0(II), h0, D, theta);
    end
end
