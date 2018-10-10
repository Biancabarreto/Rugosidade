#include "colors.inc"
#include "textures.inc"
#include "shapes.inc" 
#include "glass.inc" 
#include "metals.inc" 
#include "woods.inc" 
#include "stones.inc"    // pre-defined scene elements 

#include "laserdots.pov"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

    // CAMERA POSITION
    #declare CAMARA_ALT=1.5;	// Camera altura.
    #declare CAMERA_POS_DEEP=2.0;	// Que tao longue esta o CUBO: 2.0m
    #declare CAMARA_THETA=40.0;

    #declare CAMARA_ANG_APERTURE=75;

    camera {
       location  <0, CAMARA_ALT, -CAMERA_POS_DEEP>
       look_at   <0, 0, -(CAMERA_POS_DEEP-CAMARA_ALT/tan(CAMARA_THETA*pi/180))>
       angle CAMARA_ANG_APERTURE
    }


    light_source 
    {
        <0, CAMARA_ALT, -CAMERA_POS_DEEP>   // Position
        color Red*3           // Color and intensity multiplicator
        spotlight
        point_at <0, 0, -(CAMERA_POS_DEEP-CAMARA_ALT/tan(CAMARA_THETA*pi/180))>     // direction of your laser
        // Size and properties of the gaussian beam profile
        radius 0.5
        falloff 0.75
        tightness 0.0
    }

////////////////////////////////////////////////////////////////////////////////
#declare ROW_DEEP=1.4;	
#declare CAJA_LADO=0.25;	
#declare CAJA_DEEP=0.2;	
#include "caja.pov"

object{    caja    translate<0,0,+ROW_DEEP>    }

#declare ROW_DEEP=1.4;	
#declare CAJA_LADO=0.5;	
#declare CAJA_DEEP=0.2;	
#include "caja.pov"
object{    caja    translate<0,0,0>    }

#declare ROW_DEEP=1.4;	
#declare CAJA_LADO=0.75;	
#declare CAJA_DEEP=0.2;	
#include "caja.pov"
object{    caja    translate<0,0,-ROW_DEEP>    }


////////////////////////////////////////////////////////////////////////////////

object{    laserdots    translate<0,0,+ROW_DEEP> }
object{    laserdots    translate<0,0,0>    }
object{    laserdots    translate<0,0,-ROW_DEEP> }

////////////////////////////////////////////////////////////////////////////////
// Piso
plane {//normal=<0, 1, 0>	y=0
	<0, 1, 0>, 0
	texture { T_Stone25 scale 4 }
}

// Pared
#declare PARED_DEEP=10;
plane {//normal=<0, 1, 0>	y=0
	<0, 0, 1>, PARED_DEEP
	texture { DMFLightOak }
}

