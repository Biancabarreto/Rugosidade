function R=function_rms(X,varargin)
    if(nargin==1)
        R=sqrt(mean((X).*(X)));
    else
        R=sqrt(mean((X-varargin{1}).*(X-varargin{1})));
    end
end 
