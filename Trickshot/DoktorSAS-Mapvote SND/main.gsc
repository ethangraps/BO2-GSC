#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init(){ //Made by DoktorSAS
	/*------------------------------------------Dont't Tuch This Lines------------------------------------------*/
    level waittill("game_ended");
    if([[level._getteamscore]]( "axis" ) == level.scorelimit || [[level._getteamscore]]( "allies" ) == level.scorelimit){
    	thread OverflowFix();
    	thread mapvote();
   		thread updateVote();
    	thread gameended();
    	thread switchingTeam();
    	wait 10; //This is autoclose menu wiat, change it to have more or less time to vote
    	foreach(player in level.players){
    		if(player.mapvotemenu){
    			player thread closemenumapmenu();
    			player.mapvotemenu = false;
    		}
    	}
    }
    /*------------------------------------------Dont't Tuch This Lines------------------------------------------*/
}
switchingTeam(){ 
	foreach(player in level.players){
    	player thread selectmap();
   	}
}


