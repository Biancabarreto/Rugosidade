#local DOTS_INTER_SPACE=0.3;
#local POSITION_DEEP=0.0;
#local RADIUS=0.5;
#local FALLOFF=0.75;
#local CUBO_LADO=0.6;

#declare laserdots=union
{

//#for (Identifier, Start, End [, Step])
 #for (Cntr, -20, 20, 1)

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        #if (Cntr/2=int(Cntr/2))
        color Red*3           // Color and intensity multiplicator

        #else
        color Green*3           // Color and intensity multiplicator
        #end
        spotlight
        point_at <Cntr*DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

 #end // ----------- end of #for loop


}

