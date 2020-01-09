function plot_interpolate_lines(X,Z,XX,ZZ,II,fname,OUTPUTDIR,DAT)
        plot(   X,Z,'-o','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH, ...
                XX,ZZ,'-','linewidth',DAT.LINEWIDTH);
        xlabel('X','fontsize',DAT.FONTSIZE);
        ylabel('Z','fontsize',DAT.FONTSIZE);
        hl=legend('Z','Interpolate Z');
        set(hl,'fontsize',DAT.FONTSIZE);
        set(gca,'linewidth',DAT.LINEWIDTH,'fontsize',DAT.FONTSIZE);
        print(gcf,[OUTPUTDIR,filesep,'Interpolate',filesep,fname{II},'_interpolate.png'],'-dpng','-tight',['-F:' num2str(DAT.FONTSIZE)])
endfunction
