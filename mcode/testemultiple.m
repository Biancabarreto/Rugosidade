%
pkg load image
clear all
close all
addpath(genpath('lib-mcode'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Só modifica aquí
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=21;


IMG_REF = imread('../images/placa1/0.jpg (green).bmp');
IMG_REF =function_check_binary_image(IMG_REF);

for II=(13+[1:N])
    IMG_OBJ{II}=imread(['../images/placa1/' num2str(II) '.jpg (green).bmp']);
    IMG_OBJ{II}=function_check_binary_image(IMG_OBJ{II});
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

