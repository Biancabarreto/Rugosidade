function plot_teste_multiple(DATA,OUTPUTDIR,FATORZ)
    graphics_toolkit gnuplot

    xi =[min(DATA(:,1)):max(DATA(:,1))];
    yi =[min(DATA(:,2)):max(DATA(:,2))];
    [xxi, yyi] = meshgrid ( xi,yi);
    zzi = griddata(DATA(:,1), DATA(:,2), DATA(:,3), xxi, yyi);

    hfig1=figure(1)
    %mesh(xxi,yyi,zzi*FATORZ)
    surf(xxi,yyi,zzi*FATORZ)
    colormap(jet)
    print(gcf,fullfile(OUTPUTDIR,['img_all_mesh.png']),'-dpng');
    hgsave (hfig1,fullfile(OUTPUTDIR,['img_all_mesh.txt']))


    hfig2=figure(2)
    scatter3(DATA(:,1), DATA(:,2), DATA(:,3)*FATORZ)
    print(gcf,fullfile(OUTPUTDIR,['img_all_scatter3.png']),'-dpng');
    hgsave (hfig2,fullfile(OUTPUTDIR,['img_all_scatter3.txt']))
endfunction
