function Ja=function_jacobian(K , X)

    const_c0=K(:,1);
    const_d0=K(:,2);

    h0=X(1);
    D =X(2);
    theta=X(3);

    N=length(const_c0);
    M=length(X);

    Ja=zeros(N,M);

    for II=1:N
        Ja(II,:)=[  function_get_partial_h0_of_c(const_c0(II), const_d0(II), h0, D, theta), ...
                    function_get_partial_d_of_c(const_c0(II), const_d0(II), h0, D, theta), ...
                    function_get_partial_theta_of_c(const_c0(II), const_d0(II), h0, D, theta)];
    end

end
