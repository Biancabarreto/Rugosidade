function plot_teste_multiple(DATA,OUTPUTDIR)
    graphics_toolkit gnuplot


    LL=64;
    xi =linspace(min(DATA(:,1)),max(DATA(:,1)),LL);
    yi =linspace(min(DATA(:,2)),max(DATA(:,2)),LL);
    [xxi, yyi] = meshgrid ( xi,yi);
    zzi = griddata(DATA(:,1), DATA(:,2), DATA(:,3), xxi, yyi);

    hfig1=figure(1);
    %mesh(xxi,yyi,zzi)
    surf(xxi,yyi,zzi)
    colormap(jet)
    print(gcf,fullfile(OUTPUTDIR,['img_all_mesh.png']),'-dpng');
    hgsave (hfig1,fullfile(OUTPUTDIR,['img_all_mesh.txt']))


    hfig2=figure(2);
    scatter3(DATA(:,1), DATA(:,2), DATA(:,3))
    print(gcf,fullfile(OUTPUTDIR,['img_all_scatter3.png']),'-dpng');
    hgsave (hfig2,fullfile(OUTPUTDIR,['img_all_scatter3.txt']))

    [MINIMO IDMIN]=min(DATA(:,3));
    [MAXIMO IDMAX]=max(DATA(:,3));

    BLOCKDAT=[DATA(IDMIN,1), DATA(IDMIN,2), DATA(IDMIN,3); ...
              DATA(IDMAX,1), DATA(IDMAX,2), DATA(IDMAX,3)];

    save('-ascii',fullfile(OUTPUTDIR,['min_max.txt']),'BLOCKDAT');
endfunction
