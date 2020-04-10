#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init(){ //Made by DoktorSAS

	
	/*------------------------------------------Dont't Tuch This Lines------------------------------------------*/
    level waittill("game_ended");
    if([[level._getteamscore]]( "axis" ) == level.scorelimit || [[level._getteamscore]]( "allies" ) == level.scorelimit /*|| getDvar("timelimit") <= 0 /*<-- add this for TDM*/){
    	mapvote();
    	wait 0.02;
    	thread OverflowFix();
   		thread updateVote();
    	foreach(player in level.players){
    		player thread selectmap();
   		}
    	wait 10; //This is autoclose menu wiat, change it to have more or less time to vote
    	foreach(player in level.players){
    		if(player.mapvotemenu){
    			player thread closemenumapmenu();
    			player.mapvotemenu = false;
    		}
    	}
    	thread gameended();
    }
    /*------------------------------------------Dont't Tuch This Lines------------------------------------------*/

}

