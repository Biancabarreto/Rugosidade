function plot_teste_multiple_cd(DATA,OUTPUTDIR,FATOR,ZLIM)

    FATORX=FATOR(1);
    FATORY=FATOR(2);
    FATORZ=FATOR(3);

    XX=DATA(:,1)*FATORX;
    YY=DATA(:,2)*FATORY;
    ZZ=(max(DATA(:,3))-DATA(:,3))*FATORZ;

    %%%%%%%%%%%%%%%%%%%%%%%%%%    
    A=[XX,YY,ones(size(XX))];
    C=inv(A'*A)*A'*ZZ;
    %%%%%%%%%%%%%%%%%%%%%%%%%%

    xi =[min(XX):max(XX)];
    yi =[min(YY):max(YY)];
    
    [xxi, yyi] = meshgrid ( xi,yi);
    zzi = C(1)*xxi+C(2)*yyi+C(3);



    hfig1=figure(1);
    scatter3(XX, YY, ZZ)
    hold on 
    surf(xxi,yyi,zzi)
    hold off
    
    print(gcf,fullfile(OUTPUTDIR,['img_all_scatter3.png']),'-dpng');
    hgsave (hfig1,fullfile(OUTPUTDIR,['img_all_scatter3.txt']))

    
    hfig2=figure(2);
    OFFSETZ=evalua(XX,YY,C);
    COLOR=color_lado(XX,YY,ZZ,C);
    scatter3(XX, YY, ZZ-OFFSETZ,20*ones(size(XX)),COLOR);
    zlim(ZLIM)
    view([-25.1 22])
    daspect([1 1 0.2])
    
    print(gcf,fullfile(OUTPUTDIR,['img_all_scatter3_color.png']),'-dpng');
    hgsave (hfig2,fullfile(OUTPUTDIR,['img_all_scatter3_color.txt']))

endfunction

function R=evalua(X,Y,C)
    R = C(1)*X+C(2)*Y+C(3);
endfunction


function R=color_lado(X,Y,Z,C)
    T = ((C(1)*X+C(2)*Y+C(3)-Z)>=0);
    R=zeros(numel(T),3);
    
    for II=1:numel(T)
        if(T(II)==0)
            R(II,:)=[1,0,0];
        else
            R(II,:)=[0,0,1];
        endif
    endfor
endfunction


