%
clear all
close all

DAT.LINEWIDTH=2;
DAT.MARKERSIZE=8;
DAT.FONTSIZE=20;

OUTPUTDIR='output'

ENABLE_PLOT_INTERPOLATE=false;

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

    if(ENABLE_PLOT_INTERPOLATE==true)
        figure(1)
	plot_interpolate_lines(X,Z,XX,ZZ,II,fname,OUTPUTDIR,DAT);
    endif

    [V DIFF]=funcvariograma(ZZ);
    VARS{II}=V;
    
    LEN_VARS(II)=length(V);

    fprintf(stdout,"Working sample:%4d\r",II);
end
disp('');


MALL=min(LEN_VARS);
M=round(MALL/3); %%% quanto vou a variacionar 1/3 del ancho de la foto
VARS_MAT=zeros(N,M);
for II=1:N
    VARS_MAT(II,:)=VARS{II}(1:M);
endfor


figure
plot_variogram_curves(VARS_MAT,OUTPUTDIR,DAT);


[curves1, curves2, IDG,G1,G2]=func_kmeans2(VARS_MAT);

figure
plot_2_curve_blocks(curves1,curves2,OUTPUTDIR,DAT);

RATIO=size(curves1,1)/size(curves2,1)

figure
plot_teste_rugosidade(fpath,fname,IDG,OUTPUTDIR,[1 1 1]);



