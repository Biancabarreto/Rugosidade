function POINTS=func_find_points_2(LINE,Lo,Co,D)
    NLINES=length(LINE);
    Po=LINE{Lo}(Co,:)

    dx=abs(LINE{1}(1,1)-LINE{1}(2,1));
    dy=abs(LINE{1}(1,2)-LINE{2}(1,2));

    POINTS=zeros(0,3);
    
    fprintf(stdout,"\n");
    [LIN1 LIN2]=func_get_lin1_lin2(Po,Lo,dy,D,NLINES)
    
    for II=LIN1:LIN2

        NCOLS=size(LINE{II},1)
        [COL1 COL2]=func_get_col1_col2(LINE{II}(1,1),Po,dx,D,NCOLS)

        for JJ=COL1:COL2
        if ((II==Lo)&&(JJ==Co))==false %% não escolho ele mesmo
            P=LINE{II}(JJ,:);

            R=norm(P-Po);
            if(R<=D)
                POINTS(end+1,:)=P;
            endif

        endif  
        endfor

    endfor

    NN=size(POINTS)


endfunction


function [LIN1 LIN2]=func_get_lin1_lin2(Po,Lo,dy,D,NLINES)
    L=floor(D/dy);
    LIN1=Lo-L;
    if LIN1 <1
        LIN1=1; 
    endif

    LIN2=Lo+L;
    if LIN2> NLINES
        LIN2=NLINES;
    endif
endfunction

function [COL1 COL2]=func_get_col1_col2(Ci,Po,dx,D,NCOLS)
    (Po(1)-D-Ci)/dx
    COL1=1+floor((Po(1)-D-Ci)/dx);
    (Po(1)+D-Ci)/dx
    COL2=1+ceil((Po(1)+D-Ci)/dx);

    if COL1 <1
        COL1=1; 
    endif

    if COL2 >NCOLS
        COL2=NCOLS; 
    endif
endfunction
