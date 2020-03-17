function C=func_get_plane(POINTS)
    X=POINTS(:,1);
    Y=POINTS(:,2);
    Z=POINTS(:,3);

    A=[ones(size(X)) X Y];
    ATA=A'*A;
    [INVATA RCOND]=inv(ATA);

    if (RCOND<1e-8)
        W=INVATA*A'*Z;
        if ( (min(isfinite(W))==0)||(max(abs(W))>1e+4) )
            W=rand(3,1)/max(max(A));
        endif

        ALPHA=0.01;
        for II=1:6
            [INVATA RCOND]=inv(ATA+ALPHA*eye(3));
            while (RCOND<1e-8)
                ALPHA=ALPHA*2
                [INVATA RCOND]=inv(ATA+ALPHA*eye(3));
                %error(sprintf('RCOND IS CLOSE TO ZERO:%e',RCOND));
            endwhile
            W=INVATA*(A'*Z+ALPHA*W);
            if min(isfinite(W))==0
                W=rand(3,1)/max(max(A));
            endif
        endfor
        %plot_points(POINTS,mean(POINTS),[W;-1]'); refresh();
        %input('***********************************************');
    else
        W=INVATA*A'*Z;
    endif
    
    C=[W;-1]';
endfunction
