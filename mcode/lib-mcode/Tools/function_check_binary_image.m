function IMG_BIN=function_check_binary_image(IMG)

    if(length(size(IMG))==3)
        error('The image should be a binary image. The image has > 1 layers');
    endif

    MAXIMO=max(max(IMG)); 
    if(MAXIMO==0)
        error('The image do not have white pixels');
    endif

    IMG_BIN = IMG/MAXIMO;

    if(max(max(IMG_BIN))>1)
        MAX_VALUE=max(max(IMG))
        error('The image should be a binary image. max pixel value > 1');
    endif

    if(min(min(IMG_BIN))<0)
        error('The image should be a binary image. max pixel value <0');
    endif

    MEAN=mean(mean(IMG_BIN));
    if(MEAN>0.5)
    IMG_BIN=(IMG_BIN<0.5);
    else
    IMG_BIN=(IMG_BIN>=0.5);
    end
endfunction
