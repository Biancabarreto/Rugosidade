function plot_teste_rugosidade(fpath,fname,IDG,OUTPUTDIR,FATOR)
    graphics_toolkit gnuplot
    FATORX=FATOR(1);
    FATORY=FATOR(2);
    FATORZ=FATOR(3);

    N=length(fname);

    for II=1:N
	BLOCK=load(fullfile(fpath,fname{II}));
	NB=size(BLOCK,1);
	if(IDG(II)==1)
		BLOCK_GROUP=[ones(NB,1) zeros(NB,1) zeros(NB,1)];
	else
		BLOCK_GROUP=[zeros(NB,1) zeros(NB,1) ones(NB,1)];
	endif
        if(II==1)
            DATA=BLOCK;
	    GRUPO=BLOCK_GROUP;
        else
            DATA=[DATA;BLOCK];
            GRUPO=[GRUPO;BLOCK_GROUP];
        endif
    endfor

    scatter3(DATA(:,1)*FATORX, DATA(:,2)*FATORY, DATA(:,3)*FATORZ,[],GRUPO);
    print(gcf,fullfile(OUTPUTDIR,['img_rugosidade_scatter3.png']),'-dpng');
    hgsave (gcf,fullfile(OUTPUTDIR,['img_rugosidade_scatter3.txt']))

endfunction
