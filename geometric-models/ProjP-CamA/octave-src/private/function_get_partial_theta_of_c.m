function ctheta=function_get_partial_theta_of_c(c0,d0,h0,D,theta)
    ctheta=D*tan(theta)*(-cot(theta-atan(d0/h0))*csc(theta+atan(h0/(d0+c0)))^2-csc(theta-atan(d0/h0))^2*cot(theta+atan(h0/(d0+c0))))+D*sec(theta)^2*(cot(theta-atan(d0/h0))*cot(theta+atan(h0/(d0+c0)))+1);
end
