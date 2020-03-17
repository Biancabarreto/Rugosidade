%% PLANE: 0=C(1)*1 + C(2)*X + C(3)*Y + C(4)*Z
%% PONTO: Pa
function D=func_dist_with_plane(P,C)
  

    NORMCA=sqrt(C(2)^2+C(3)^2+C(4)^2);

    D=abs( C(1)+ C(2)*P(1)+C(3)*P(2)+C(4)*P(3) )/NORMCA;
endfunction
