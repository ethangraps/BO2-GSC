botsifempty(){
	level endon("game_ended");
	level waittill("connected", player);
	wait 5;
	if(level.players.size < 4){ // If there less then 4 client the game spawn 8 bot
		player thread addBots( 8 ); // Bot to spawn on game start
	}
	for(;;){
		kickedBot = false;
		level waittill("connected", player);
		if(level.players.size > 5){
			foreach(p in level.players){
				if(isDefined(player.pers["isBot"]) && player.pers["isBot"] && kickedBot == false){	  
					kick(p getentitynumber(), "EXE_PLAYERKICKED");
					kickedBot = true;
				}
			}
		}
	}
}
addBots( num ){
	while(num > -1){
		if(level.players.size < 5){
			self thread maps\mp\bots\_bot::spawn_bot("autoassign");
			wait 1;
			}
		num--;
	}
}
