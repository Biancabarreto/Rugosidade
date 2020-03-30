function POINTS=func_find_points(LINE,Lo,Co,D)
    NLINES=length(LINE);

    Po=LINE{Lo}(Co,:);

    POINTS=zeros(0,3);

    for II=1:NLINES
    Pl=LINE{II}(1,:);
    if abs(Po(2)-Pl(2))<=D %% Lineas dentro dos possiveis valores
        L=size(LINE{II},1);
        for JJ=1:L
        if ((II==Lo)&&(JJ==Co))==false %% não escolho ele mesmo
            P=LINE{II}(JJ,:);
            if abs(Po(1)-P(1))<=D %% colunas dentro dos possiveis valores
            R=norm(P(1:2)-Po(1:2));
            if(R<=D)
                %POINTS_CELL{end+1}=P;
                POINTS(end+1,:)=P;
            endif
            endif
            if Pl(1)>(Po(1)+D)
                break
            endif
        endif  
        endfor
    endif
    if Pl(2)>(Po(2)+D)
        break
    endif
    endfor

endfunction
