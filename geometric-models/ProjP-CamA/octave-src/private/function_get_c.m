function C=function_get_c(c0, d0, h0, D, theta)
    C=D*tan(theta)*(  1+cot(theta-atan(d0/h0))*cot(theta+atan(h0/(d0+c0)))  );
end
