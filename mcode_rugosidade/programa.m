%
clear all
addpath(genpath('mfiles'))

FILENAME='dataxyz.txt';
OUTPUTDIR='output';
FATOR=[1 1 1];
D=6.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mkdir(OUTPUTDIR);
DATARAW=load(FILENAME);
DATA=DATARAW.*FATOR;

[RR MEAN]=func_calc_rugosidade(DATA,D);

plot_teste_multiple([DATA(:,1) DATA(:,2) RR],OUTPUTDIR)

outdatafile=fullfile(OUTPUTDIR,'rugosidade.dat');
save('-ascii',outdatafile,'RR');

outdatafile=fullfile(OUTPUTDIR,'rugosidade-mean.dat');
save('-ascii',outdatafile,'MEAN');


