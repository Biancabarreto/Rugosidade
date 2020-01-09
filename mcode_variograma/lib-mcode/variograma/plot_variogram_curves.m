function plot_variogram_curves(VARS_MAT,OUTPUTDIR,DAT)

	M=size(VARS_MAT,2);

	plot([1:M],VARS_MAT','k-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH);
	xlabel('Difference','fontsize',DAT.FONTSIZE);
	ylabel('Variograma','fontsize',DAT.FONTSIZE);
	set(gca,'linewidth',DAT.LINEWIDTH,'fontsize',DAT.FONTSIZE);
	print(figure(1),[OUTPUTDIR,filesep,'variograma_all.png'],'-dpng','-tight',['-F:' num2str(DAT.FONTSIZE)])
endfunction
