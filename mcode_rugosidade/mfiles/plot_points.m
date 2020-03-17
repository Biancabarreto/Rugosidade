function plot_points(POINTS, Pa, C)

    scatter3(POINTS(:,1),POINTS(:,2),POINTS(:,3),'linewidth',3);
    daspect([1 1 1])
    colormap(jet)
    hold on
    scatter3(Pa(1),Pa(2),Pa(3),30,[0 0 0],'linewidth',6);
    colormap(jet)
    hold off

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    MIN=min(POINTS);
    MAX=max(POINTS);
    
    if(MIN(1)==MAX(1))
        MIN(1)=MIN(1)-0.5;
        MAX(1)=MAX(1)+0.5;
    endif

    if(MIN(2)==MAX(2))
        MIN(2)=MIN(2)-0.5;
        MAX(2)=MAX(2)+0.5;
    endif
    
    L=16;
    X=linspace(MIN(1),MAX(1),L);
    Y=linspace(MIN(2),MAX(2),L);
    [XX, YY]=meshgrid(X,Y);
    ZZ=-C(1)/C(4)-C(2)*XX/C(4)-C(3)*YY/C(4);
    hold on
    surf(XX,YY,ZZ);
    colormap(jet)
    hold off
endfunction


