C  = [0.5    ;0.5  ;  0.5];   %%metros
c0 = [75.75  ;96.00;  100.0]; %%pixels
d0 = [151.25 ;28.25; -279.00];%%pixels


[h0 D theta ERMS_C]=function_find_parameters(C,c0,d0)
