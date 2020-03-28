botsifempty(){		
	level endon("game_ended");
	level waittill("connected", player);
	wait 5;
	cont = 0;
	foreach(p in level.players){
		if(isDefined(player.pers["isBot"]) && player.pers["isBot"]){	  
		}else{
			cont++;
		}
	}
	if(cont < 4){
		player thread addBots( 8 );
	}
	for(;;){
		kickedBot = false;
		cont = 0;
		level waittill("connected", player);
		foreach(p in level.players){
			if(isDefined(p.pers["isBot"]) && p.pers["isBot"]){	  
			}else{
				cont++;
			}
		}
		if(cont < 4){
			foreach(p in level.players){
				if(isDefined(p.pers["isBot"]) && p.pers["isBot"] && kickedBot == false){	  
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
