%
clear all
addpath(genpath('mfiles'))

FILENAME='dataxyz.txt';
OUTPUTDIR='output';
FATOR=[5.0/150 1 0.1];
D=1.5;
ENABLE_PLOT=false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mkdir(OUTPUTDIR);
DATARAW=load(FILENAME);
DATA=DATARAW.*FATOR;

[RR MEAN]=func_calc_rugosidade(DATA,D,ENABLE_PLOT);

plot_teste_multiple([DATA(:,1) DATA(:,2) RR],OUTPUTDIR)

outdatafile=fullfile(OUTPUTDIR,'rugosidade.dat');
save('-ascii',outdatafile,'RR');

outdatafile=fullfile(OUTPUTDIR,'rugosidade-mean.dat');
save('-ascii',outdatafile,'MEAN');


