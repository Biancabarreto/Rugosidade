function plot_2_curve_blocks(curves1,curves2,c1,c2,OUTPUTDIR,DAT)

	M=size(curves1,2);

	plot(   [1:M],curves1','r-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH, ...
		[1:M],curves2','b-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH, ...
		[1:M],c1,'ko-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH, ...
		[1:M],c2,'ks-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH);
	xlabel('Difference','fontsize',DAT.FONTSIZE);
	ylabel('Variograma','fontsize',DAT.FONTSIZE);
	set(gca,'linewidth',DAT.LINEWIDTH,'fontsize',DAT.FONTSIZE);
	print(gcf,[OUTPUTDIR,filesep,'variograma_kmeans.png'],'-dpng','-tight',['-F:' num2str(DAT.FONTSIZE)])
endfunction
