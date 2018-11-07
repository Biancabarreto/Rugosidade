%
close all
clear

N=500;
X=round(400*rand(N,1));

for II=1:N
Y(II)=(X(II)-100).*(X(II)-200).*(X(II)-300)/40000 +200+20*(rand(1)-0.5);
endfor
[X id]=sort(X);
X=X/400;
Y=Y(id);

Y(120:290)=Y(120:290)+80;

figure;
plot(X,Y,'.')


NPARTS=12;
[P XINT]=lms_spline3_func(X,Y,NPARTS);

M=20;
for II=1:NPARTS
    x(:,II)=linspace(XINT(II,1),XINT(II,2),M);
    y(:,II)=polyval(P(II,:),x(:,II));
endfor


figure;
plot(X,Y,'.',x,y,'-s');


