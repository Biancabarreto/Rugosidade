//#local CAJA_LADO=0.5;	
//#local CAJA_DEEP=0.2;	

#declare caja=union
{
    box {
	    <-CAJA_LADO*20, 0, 0>, < CAJA_LADO*20, CAJA_LADO, CAJA_DEEP>
	    texture {
		    pigment {
			    color rgb<0.8, 0.8, 0.6>
		    }
	    }
    }

}
