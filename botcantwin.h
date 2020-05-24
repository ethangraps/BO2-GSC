onPlayerConnect()
{
    for(;;){
        level waittill("connected", player);
		/*Remeber to add this 2 Lines in onPlayerConnected function*/
        if(isDefined(player.pers["isBot"]) && player.pers["isBot"])
			player thread botCantWin();
		else	
       	player thread onPlayerSpawned();
    }
}

/*
	This code don't remove weapon, but the bot can't reache the score limit, the can kill and 
	get some points but when they reace scorelimit-1 the bot go back to 0
*/
botCantWin(){ //Made By DoktorSAS
 	self endon("disconnect");
	level endon("game_ended");
    for(;;)
    {
    	wait 0.25;
    	if(self.pers["pointstowin"] >= level.scorelimit - 1){
    		self.pointstowin = 0;
			self.pers["pointstowin"] = self.pointstowin;
			self.score = 0;
			self.pers["score"] = self.score;
			self.kills = 0;
			self.deaths = 0;
			self.headshots = 0;
			self.pers["kills"] = self.kills;
			self.pers["deaths"] = self.deaths;
			self.pers["headshots"] = self.headshots;
    	}
    }
    
}