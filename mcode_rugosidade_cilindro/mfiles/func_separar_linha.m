function LINE=func_separar_linha(DATA)
    N=size(DATA,1);
    INIT=1;
    JJ=1;
    
    for II=2:N
        if ( DATA(II,1)<(DATA(II-1,1)/2) )
            LINE{JJ}=DATA(INIT:(II-1),:,:);
            INIT=II;
            JJ=JJ+1;
        endif        
    endfor

    LINE{JJ}=DATA(INIT:end,:,:);

endfunction
