init(){ //Made by DoktorSAS
	level thread Floaters(); //Remeber to add this line\
}
//Floater
Floaters(){
	level waittill("game_ended");
	foreach(player in level.players){
               if(isAlive(player) && !player isOnGround() && player.fon){
                	player thread FloatDown();
                }
        }
}
FloatDown(){
    z = 0;
    startingOrigin = self getOrigin();
    floaterPlatform = spawn("script_model", startingOrigin - (0, 0, 20));
    playerAngles = self getPlayerAngles();
    floaterPlatform.angles=(0, playerAngles[1] , 0);
    floaterPlatform setModel("collision_clip_32x32x10");
    for(;;){
        z++;
        floaterPlatform.origin=(startingOrigin - (0, 0, z*1 ));
        wait .01;
    }
}
//Floater ON/OFF
floateronoff(){
	if(self.fon == true){
		self iprintln("Floater ^1OFF");
		self.fon = false;
	}else if(self.regenEquipment == false){
		self iprintln("Floaters ^2ON");
		self.fon = true;
	}
}