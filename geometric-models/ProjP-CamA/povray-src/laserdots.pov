#local DOTS_INTER_SPACE=0.3;
#local POSITION_DEEP=0.0;
#local RADIUS=0.5;
#local FALLOFF=0.75;
#local CUBO_LADO=0.6;

#declare laserdots=union
{


    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <-4*DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <-3*DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <-2*DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <-DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <0, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <+DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <+2*DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <+3*DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }

    light_source 
    {
        <0.0, 5*CUBO_LADO, POSITION_DEEP>   // Position
        color Green*3           // Color and intensity multiplicator
        spotlight
        point_at <+4*DOTS_INTER_SPACE, 0, POSITION_DEEP>      // direction of your laser
        // Size and properties of the gaussian beam profile
        radius RADIUS
        falloff FALLOFF
        tightness 0.0
    }
}

