%
clear all
close all

DAT.LINEWIDTH=2;
DAT.MARKERSIZE=8;
DAT.FONTSIZE=20;

OUTPUTDIR='output'

ENABLE_PLOT_INTERPOLATE=false

addpath(genpath('lib-mcode/variograma'))

[fname, fpath, fltidx] = uigetfile ({'*.dat','Select *.dat files with curves'},'MultiSelect','on');

N=length(fname);
VARS=cell(N,1);
LEN_VARS=zeros(N,1);

mkdir(OUTPUTDIR);
mkdir([OUTPUTDIR,filesep,'Interpolate']);

for II=1:N
    DATOS=load(fullfile(fpath,fname{II}));
    X=DATOS(:,1);
    Z=DATOS(:,3);


    XX=[min(X):1:max(X)];
    ZZ = interp1 (X,Z,XX);

    if(ENABLE_PLOT_INTERPOLATE)
        figure(1)
        plot(   X,Z,'-o','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH, ...
                XX,ZZ,'-','linewidth',DAT.LINEWIDTH);
        xlabel('X','fontsize',DAT.FONTSIZE);
        ylabel('Z','fontsize',DAT.FONTSIZE);
        hl=legend('Z','Interpolate Z');
        set(hl,'fontsize',DAT.FONTSIZE);
        set(gca,'linewidth',DAT.LINEWIDTH,'fontsize',DAT.FONTSIZE);
        print(figure(1),[OUTPUTDIR,filesep,'Interpolate',filesep,fname{II},'_interpolate.png'],'-dpng','-tight',['-F:' num2str(DAT.FONTSIZE)])
    endif

    [V DIFF]=funcvariograma(ZZ);
    VARS{II}=V;
    
    LEN_VARS(II)=length(V);

    fprintf(stdout,"Working sample:%4d\r",II);
end
disp('');


MALL=min(LEN_VARS);
M=round(MALL/2);
VARS_MAT=zeros(N,M);
for II=1:N
    VARS_MAT(II,:)=VARS{II}(1:M);
endfor





figure(1)
plot([1:M],VARS_MAT','-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH);
xlabel('Difference','fontsize',DAT.FONTSIZE);
ylabel('Variograma','fontsize',DAT.FONTSIZE);
set(gca,'linewidth',DAT.LINEWIDTH,'fontsize',DAT.FONTSIZE);
print(figure(1),[OUTPUTDIR,filesep,'variograma_all.png'],'-dpng','-tight',['-F:' num2str(DAT.FONTSIZE)])

%figure(1)
%plot([1:M],mean(VARS_MAT),'-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH);
%xlabel('Difference','fontsize',DAT.FONTSIZE);
%ylabel('Variograma','fontsize',DAT.FONTSIZE);
%set(gca,'linewidth',DAT.LINEWIDTH,'fontsize',DAT.FONTSIZE);
%print(figure(1),[OUTPUTDIR,filesep,'variograma_mean.png'],'-dpng','-tight',['-F:' num2str(DAT.FONTSIZE)])


[curves1, curves2,ID1,ID2]=func_kmeans2(VARS_MAT);

figure(1)
plot(   [1:M],curves1','r-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH, ...
        [1:M],curves2','b-','markersize',DAT.MARKERSIZE,'linewidth',DAT.LINEWIDTH);
xlabel('Difference','fontsize',DAT.FONTSIZE);
ylabel('Variograma','fontsize',DAT.FONTSIZE);

set(gca,'linewidth',DAT.LINEWIDTH,'fontsize',DAT.FONTSIZE);
print(figure(1),[OUTPUTDIR,filesep,'variograma_kmeans.png'],'-dpng','-tight',['-F:' num2str(DAT.FONTSIZE)])

FACTOR=size(curves1,1)/size(curves2,1)




