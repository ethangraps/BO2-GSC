#include common_scripts\utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\_utility;
#include common_scripts\utility;
/*
	Mod: Zombies Simple MOD
	Author: DoktorSAS
*/
init(){
	level.clientid = 0;
	level.perk_purchase_limit = 9;
	level thread onplayerconnect();
	drawZombiesCounter(); //Thanks to CabConModding
}
onplayerconnect(){ 
	for (;;){
		level waittill( "connecting", player );
		player.clientid = level.clientid;
		player thread onplayerspawned();
		level.clientid++;
	}
}
onplayerspawned(){
	level endon( "game_ended" );
    self endon( "disconnect" );
	self thread AnimatedTextCUSTOMPOS("Welcome to ^1Zombies \n^7Thanks to ^5DoktorSAS", 0,-200); //Welcome Messages
	for(;;){
		self waittill( "spawned_player" );
	}
}

AnimatedTextCUSTOMPOS(text, x, y){ //Made by DoktorSAS
	textSubStr = getSubStr(text,0,text.size);
	result = "";
	welcome = self createFontString("hudsmall",1.9);
	welcome setPoint("CENTER","CENTER",x, y);
	welcome setText("");	
	for(i=0;i<textSubStr.size;i++){
		color = textSubStr[i]+textSubStr[i+1];
		if(color == "^1" || color == "^2" || color == "^3" || color == "^4" || color == "^5" || color == "^6" || color == "^7" || color == "^8" || color == "^0" || color == "\n"){
			result = result + color;
			i++;
		}else
			result = result + textSubStr[i];
		if(i == textSubStr.size){
			welcome setText(text);
		}else{
			welcome setText(result);
			wait 0.15;
			welcome setText(result + "^7_");
		}
		wait 0.15;
	}
	wait 2;
	welcome setText("");
	self iprintln("Whats Inside: \n # ^1NO ^2Perk ^7Limit \n # ^1Zombies ^7Counter");
}

drawZombiesCounter(){ //Thanks to CabConModding
    level.zombiesCountDisplay = createServerFontString("hudsmall" , 1.9);
    level.zombiesCountDisplay setPoint("CENTER", "CENTER", "CENTER", 200);
    thread updateZombiesCounter();
}
updateZombiesCounter(){ //Thanks to CabConModding
    level endon("stopUpdatingZombiesCounter");
    while(true){
        zombiesCount = get_current_zombie_count();
        if(zombiesCount >= 0){
        	level.zombiesCountDisplay setText("Zombies: ^1" + zombiesCount);
        }else
        	level.zombiesCountDisplay setText("Zombies: ^2" + zombiesCount);
        waitForZombieCountChanged("stopUpdatingZombiesCounter");
    }
}
recreateZombiesCounter(){ //Thanks to CabConModding
    level notify("stopUpdatingZombiesCounter");
    thread updateZombiesCounter();
}
waitForZombieCountChanged(endonNotification){ //Thanks to CabConModding
    level endon(endonNotification);
    oldZombiesCount = get_current_zombie_count();
    while(true){
        newZombiesCount = get_current_zombie_count();
        if(oldZombiesCount != newZombiesCount){
            return;
        }
        wait 0.05;
    }
}

