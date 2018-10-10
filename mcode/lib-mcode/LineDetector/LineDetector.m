%
classdef LineDetector  < handle
    properties
        IMG_BIN

        ORDER
        PARTS
    end


    methods (Access = public)
        %% PUBLIC
        %% Constructor carrega IMG e cria IMG_BIN desde IMG
        function obj = LineDetector(IMG_BIN)

            obj.IMG_BIN=IMG_BIN;

            %% gaussian blur para eliminar cumuls pequenhos
            obj.IMG_BIN = imsmooth(1.0*obj.IMG_BIN,'Gaussian',1.1);
            obj.IMG_BIN=(obj.IMG_BIN>0.75);

            %% Spline reconstruccin
            obj.ORDER=7;
            obj.PARTS=8;

        end


        %% Establee el rden del polinmio usado no spline
        function set_reconstruction_spline_order(obj,ORDER)
            obj.ORDER=ORDER;
        end

        %% Establee el numero de partes a analizar
        function set_reconstruction_parts(obj,PARTS)
            obj.PARTS=PARTS;
        end


        %% retorna el rden del polinmio usado no spline
        function ORDER=get_reconstruction_spline_order(obj)
            ORDER=obj.ORDER;
        end

        %% retorna el numero de partes a analizar
        function PARTS=get_reconstruction_parts(obj)
            PARTS=obj.PARTS;
        end


        %% Calcula la curva provocada por el objeto
        function [XOPT YOPT]=calculates_curve(obj)

            NCOL=size(obj.IMG_BIN,2);
            STEP=round(NCOL/obj.PARTS);

            
            [XOPT YOPT]=curve_lms_poly_spline(obj.IMG_BIN,obj.ORDER,STEP);

        end


        %% Intenta deduzir qual es la curva de referencia
        function [XREF YREF]=calculates_curve_ref(obj,X)

            image(obj.IMG_BIN*255)

            lin=0;col=0;
            while ( (lin<1)||(lin>size(obj.IMG_BIN,1))||(col<1)||(col>size(obj.IMG_BIN,2)) )
                msgbox ('1) Please select in the image the first point');
                [col lin]=ginput(1);P1=[col lin];
            endwhile
            hold on
            plot(col,lin,'-o', "linewidth", 4);
            hold off

            lin=0;col=0;
            while ( (lin<1)||(lin>size(obj.IMG_BIN,1))||(col<1)||(col>size(obj.IMG_BIN,2)) )
                msgbox ('2) Please select in the image the second point');
                [col lin]=ginput(1);P2=[col lin];
            endwhile
            hold on
            plot(col,lin,'-o', "linewidth", 4);
            hold off

            if norm(P2-P1)==0
                error('The points are the same.')
            end

            YY=[P1(2); P2(2)];
            AA=[P1(1) 1; P2(1) 1];
            K=inv(AA)*YY;

            XREF=X;
            YREF=polyval (K',XREF);           
        end

    end

end
