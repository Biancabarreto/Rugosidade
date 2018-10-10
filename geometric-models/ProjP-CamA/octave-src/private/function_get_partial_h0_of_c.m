function ch0=function_get_partial_h0_of_c(c0,d0,h0,D,theta)
    ch0=D*tan(theta)*(-(cot(theta-atan(d0/h0))*csc(theta+atan(h0/(d0+c0)))^2)/((d0+c0)*(h0^2/(d0+c0)^2+1))-(d0*csc(theta-atan(d0/h0))^2*cot(theta+atan(h0/(d0+c0))))/((d0^2/h0^2+1)*h0^2));
end
