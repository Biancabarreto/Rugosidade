function CD=function_get_partial_d_of_c(c0,d0,h0,D,theta)
    CD=tan(theta)*(cot(theta-atan(d0/h0))*cot(theta+atan(h0/(d0+c0)))+1);
end
