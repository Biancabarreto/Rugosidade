function [h0 D theta PERCENT_E]=function_find_parameters(const_C,const_c0,const_d0)

    h0=400*cot(37.5*pi/180); 
    D=1.5*cot(40*pi/180)+0.1; 
    theta=40*pi/180;

    K=[const_c0, const_d0]; % constants
    X=[ h0; D; theta];      % var


    Ca=function_system(K,X);
    Ja=function_jacobian(K,X);
    RMS_C=function_rms(const_C);
    ERMS_C=function_rms(const_C,Ca);
    PERCENT_E=100*ERMS_C/RMS_C

    II=1;
    alpha=0.1;

    while (PERCENT_E>2.0)&&(II<50)

        X=X+inv(Ja'*Ja+alpha*eye(3))*(Ja'*(const_C-Ca)+alpha*X);

        X=function_check_params(X);

        Ca=function_system(K,X);
        Ja=function_jacobian(K,X);

        RMS_C=function_rms(const_C);
        ERMS_C=function_rms(const_C,Ca);
        PERCENT_E=100*ERMS_C/RMS_C

        II=II+1;
    end

    h0=X(1);
    D=X(2);
    theta=X(3);
end


