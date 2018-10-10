function Y=function_check_params(X)
    Y=abs(X);
    if (Y(1)<1)
        Y(1)=1;
    end
    while(Y(3)>(pi/2))
        Y(3)=pi-Y(3);
    end
end
