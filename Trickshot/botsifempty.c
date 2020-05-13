botsifempty(){ //Made by DoktorSAS

	level endon("game_ended");

	level waittill("connected", player);

	wait 1;

	cont = 0;

	contB = 0;

	foreach(p in level.players){

		if(isDefined(p.pers["isBot"]) && p.pers["isBot"]){	

			contB++;

		}else{

			cont++;

		}

	}


	if(cont < 5 && contB < 8){

		if(cont == 1 && contB == 0){

			player addBots( 7 );

		}else player addBots( (contB-cont) );

	}

	while(!level.gameended){
		cont = 0;
		contB = 0;
		level waittill("connected", player);
		foreach(p in level.players){
			if(isDefined(p.pers["isBot"]) && p.pers["isBot"] && isDefined(p.botOwner) && p.botOwner == "DoktorSASisTheOwnerOfThisCode"){	
				contB++;
			}else
				cont++;
		}
		 if(cont > 5 && contB > 0){
				player kickBots( 1 );
		}else if(cont <= 12 && contB < 8)
			player addBots(7-contB);
	}
}

kickBots( num ){ //Made by DoktorSAS

	i = level.players.size;

	while(i > -1 && num > 0){

		if(level.players[i].pers["isBot"] && isDefined(level.players[i].botOwner) && level.players[i].botOwner == "DoktorSASisTheOwnerOfThisCode"){

		    kickSelf(level.players[i]);

			num--;

		}

		i++;

	}

}

kickSelf( p ){ //Made by DoktorSAS

	kick(p getentitynumber(), "EXE_PLAYERKICKED");

}

addBots( num ){ //Made by DoktorSAS

	while(num > -1){

		self thread maps\mp\bots\_bot::spawn_bot("autoassign");

		wait 1;

		num--;

	}

}
