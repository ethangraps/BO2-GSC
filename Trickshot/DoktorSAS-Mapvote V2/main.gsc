#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

/*
	Developer: DoktorSAS
	Discord: Discord.io/Sorex
	Mod: All Maps - Map Vote
	Website: sorexproject.webflow.io
	Description: Simple map vote menu, not the best but work ;)
				 for more ask on Discord
*/

init(){
    level thread onPlayerConnect();
    /*
    	If you move vote menu on your mods remeber to call
    	    thread OverflowFix();
    		thread mapvote();
   			thread updateVote();
    		thread gameended();
    	in your init();
    */
    
    thread OverflowFix();
    thread mapvote();
    thread updateVote();
    thread gameended();
}
updateVote(){ //Update VOTE value everytime somone vote to voters players
	level endon("game_ended");
	for(;;){
		level waittill("updateVote");
		wait 0.01;
		foreach(player in level.players){
			if(player.mapvotemenu){
				player.textMAP1 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][0] + " \n^7Vote: [^2 " + level.maptovote["vote"][0] + " ^7]" );		
				player.textMAP2 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][1] + " \n^7Vote: [^2 " + level.maptovote["vote"][1] + " ^7]");		
				player.textMAP3 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][2] + " \n^7Vote: [^2 " + level.maptovote["vote"][2] + " ^7]" );
			}
		}
	}
}
gameended(){
	level waittill("game_ended");
	if(level.maptovote["vote"][0] == level.maptovote["vote"][1] && level.maptovote["vote"][2] <= level.maptovote["vote"][0]){
		setmap(randomintrange(0,1));
	}else if(level.maptovote["vote"][2] <= level.maptovote["vote"][0] && level.maptovote["vote"][0] == level.maptovote["vote"][2]){
		setmap(randomintrange(1,2));
	}else if(level.maptovote["vote"][0] == level.maptovote["vote"][1] && level.maptovote["vote"][0] == level.maptovote["vote"][2]){
		setmap(randomintrange(0,2));
	}else if(level.maptovote["vote"][0] > level.maptovote["vote"][1] && level.maptovote["vote"][0] > level.maptovote["vote"][2]){
		setmap(0);
	}else if(level.maptovote["vote"][1] >= level.maptovote["vote"][0] && level.maptovote["vote"][1] >= level.maptovote["vote"][2]){
		setmap(1);
	}else{
		setmap(2);
	}	
}
setmap( index ){
	setdvar( "sv_maprotation", "map " + level.maptovote["name"][index] );
	printboldToAll("The next map is ^5" + level.maptovote["map"][index] );
}
printboldToAll(str){
	foreach(player in level.players){
		player iprintlnbold(str);
	}
}
printToAllMapVoted(str){
	if(!level.gameended){
		foreach(player in level.players){
			if(player != self)
				player iprintln(str);
		}
	}
}
mapvote(){
	 level.maptovote["map"] = [];
	 level.maptovote["name"] = [];
	 level.maptovote["image"] = [];
	 level.maptovote["vote"] = [];
	 
	 level.maptovote["vote"][0] = 0;
	 level.maptovote["vote"][1] = 0;
	 level.maptovote["vote"][2] = 0;
	 
	 randommapbyindex(0);
	 randommapbyindex(1);
	 randommapbyindex(2);
}
randommapbyindex( index ){
	level endon("mapnotvalid");
	if(index == 0){
		i = randomintrange( 0, 11 );
		mapdata(i, index);
		if(level.maptovote["name"][index] == getDvar("mapname")){
			randommapbyindex(index);
			level notify("mapnotvalid");
		}
	}else if(index == 1){
		i = randomintrange( 11, 20 );
		mapdata(i, index);
		if(level.maptovote["name"][index] == getDvar("mapname") && level.maptovote["name"][index] == level.maptovote["name"][0]){
			randommapbyindex(index);
			level notify("mapnotvalid");
		}
	}else if(index == 2){
		i = randomintrange( 20, 30 );
		mapdata(i, index);
		if(level.maptovote["name"][index] == getDvar("mapname") && level.maptovote["name"][index] == level.maptovote["name"][0] && level.maptovote["name"][index] == level.maptovote["name"][1]){
			randommapbyindex(index);
			level notify("mapnotvalid");
		}
	}
	precacheshader( level.maptovote["image"][index] );
}
mapdata( i, index ){ //Map Parser
	/*
		This area convert a number i to a map with all information
		about the maps.
		 # Game Name
		 # map mp
		 # Map image
	*/
	switch( i ){
		//Base MAP
		case 0:
		level.maptovote["map"][index] = "Aftermath";
	 	level.maptovote["name"][index] = "mp_la";
	    level.maptovote["image"][index] = "loadscreen_mp_la";
		break;
		case 1:
		level.maptovote["map"][index] = "Cargo";
	 	level.maptovote["name"][index] = "mp_dockside";
	    level.maptovote["image"][index] = "loadscreen_mp_dockside";
		break;
		case 2:
		level.maptovote["map"][index] = "Carrier";
	 	level.maptovote["name"][index] = "mp_carrier";
	    level.maptovote["image"][index] = "loadscreen_mp_carrier";
		break;
		case 3:
		level.maptovote["map"][index] = "Drone";
	 	level.maptovote["name"][index] = "mp_drone";
	    level.maptovote["image"][index] = "loadscreen_mp_drone";
		break;
		case 4:
		level.maptovote["map"][index] = "Express";
	 	level.maptovote["name"][index] = "mp_express";
	    level.maptovote["image"][index] = "loadscreen_mp_express";
		break;
		case 5:
		level.maptovote["map"][index] = "Hijacked";
	 	level.maptovote["name"][index] = "mp_Hijacked";
	    level.maptovote["image"][index] = "loadscreen_mp_hijacked";
		break;
		case 6:
		level.maptovote["map"][index] = "Meltdown";
	 	level.maptovote["name"][index] = "mp_Meltdown";
	    level.maptovote["image"][index] = "loadscreen_mp_meltdown";
		case 7:
		level.maptovote["map"][index] = "Overflow";
	 	level.maptovote["name"][index] = "mp_Overflow";
	    level.maptovote["image"][index] = "loadscreen_mp_overflow";
		break;
		case 8:
		level.maptovote["map"][index] = "Plaza";
	 	level.maptovote["name"][index] = "mp_nightclub";
	    level.maptovote["image"][index] = "loadscreen_mp_nightclub";
		break;
		case 9:
		level.maptovote["map"][index] = "Raid";
	 	level.maptovote["name"][index] = "mp_raid";
	    level.maptovote["image"][index] = "loadscreen_mp_raid";
		break;
		case 10:
		level.maptovote["map"][index] = "Slums";
	 	level.maptovote["name"][index] = "mp_Slums";
	    level.maptovote["image"][index] = "loadscreen_mp_Slums";
		break;
		case 11:
		level.maptovote["map"][index] = "Standoff";
	 	level.maptovote["name"][index] = "mp_village";
	    level.maptovote["image"][index] = "loadscreen_mp_village";
		break;
		case 12:
		level.maptovote["map"][index] = "Turbine";
	 	level.maptovote["name"][index] = "mp_Turbine";
	    level.maptovote["image"][index] = "loadscreen_mp_Turbine";
		break;
		case 13:
		level.maptovote["map"][index] = "Yemen";
	 	level.maptovote["name"][index] = "mp_socotra";
	    level.maptovote["image"][index] = "loadscreen_mp_socotra";
		break;
		//Bouns MAP
		case 14:
		level.maptovote["map"][index] = "Nuketown 2025";
	 	level.maptovote["name"][index] = "mp_nuketown_2020";
	    level.maptovote["image"][index] = "loadscreen_mp_nuketown_2020";
		break;
		//DLC MAP 1 Revolution
		case 15:
		level.maptovote["map"][index] = "Downhill";
	 	level.maptovote["name"][index] = "mp_downhill";
	    level.maptovote["image"][index] = "loadscreen_mp_downhill";
		break;
		case 16:
		level.maptovote["map"][index] = "Mirage";
	 	level.maptovote["name"][index] = "mp_Mirage";
	    level.maptovote["image"][index] = "loadscreen_mp_Mirage";
		break;
		case 17:
		level.maptovote["map"][index] = "Hydro";
	 	level.maptovote["name"][index] = "mp_Hydro";
	    level.maptovote["image"][index] = "loadscreen_mp_Hydro";
		break;
		case 18:
		level.maptovote["map"][index] = "Grind";
	 	level.maptovote["name"][index] = "mp_skate";
	    level.maptovote["image"][index] = "loadscreen_mp_skate";
		break;
		//DLC MAP 2 Uprising
		case 19:
		level.maptovote["map"][index] = "Encore";
	 	level.maptovote["name"][index] = "mp_concert";
	    level.maptovote["image"][index] = "loadscreen_mp_concert";
		break;
		case 20:
		level.maptovote["map"][index] = "Magma";
	 	level.maptovote["name"][index] = "mp_Magma";
	    level.maptovote["image"][index] = "loadscreen_mp_Magma";
		break;
		case 21:
		level.maptovote["map"][index] = "Vertigo";
	 	level.maptovote["name"][index] = "mp_Vertigo";
	    level.maptovote["image"][index] = "loadscreen_mp_Vertigo";
		break;
	    case 22:
		level.maptovote["map"][index] = "Studio";
	 	level.maptovote["name"][index] = "mp_Studio";
	    level.maptovote["image"][index] = "loadscreen_mp_Studio";
		break;
		//DLC MAP 3 Vengeance
		case 23:
		level.maptovote["map"][index] = "Uplink";
	 	level.maptovote["name"][index] = "mp_Uplink";
	    level.maptovote["image"][index] = "loadscreen_mp_Uplink";
		break;
		case 24:
		level.maptovote["map"][index] = "Detour";
	 	level.maptovote["name"][index] = "mp_bridge";
	    level.maptovote["image"][index] = "loadscreen_mp_bridge";
		break;
		case 25:
		level.maptovote["map"][index] = "Cove";
	 	level.maptovote["name"][index] = "mp_castaway";
	    level.maptovote["image"][index] = "loadscreen_mp_castaway";
		break;
		case 26:
		level.maptovote["map"][index] = "Rush";
	 	level.maptovote["name"][index] = "mp_paintball";
	    level.maptovote["image"][index] = "loadscreen_mp_paintball";
		break;
		//DLLC MAP 4 Apocalypse 
		case 27:
		level.maptovote["map"][index] = "Dig";
	 	level.maptovote["name"][index] = "mp_Dig";
	    level.maptovote["image"][index] = "loadscreen_mp_Dig";
		break;
		case 28:
		level.maptovote["map"][index] = "Frost";
	 	level.maptovote["name"][index] = "mp_frostbite";
	    level.maptovote["image"][index] = "loadscreen_mp_frostbite";
		break;
		case 29:
		level.maptovote["map"][index] = "Pod";
	 	level.maptovote["name"][index] = "mp_Pod";
	    level.maptovote["image"][index] = "loadscreen_mp_Pod";
		break;
		case 30:
		level.maptovote["map"][index] = "Takeoff";
	 	level.maptovote["name"][index] = "mp_Takeoff";
	    level.maptovote["image"][index] = "loadscreen_mp_Takeoff";
		break;
		/*case def:
		level.maptovote["map"][index] = "";
	 	level.maptovote["name"][index] = "mp_";
	    level.maptovote["image"][index] = "loadscreen_mp_";
		break;*/
	}
}
onPlayerConnect(){
    for(;;){
        level waittill("connected", player);
        /*
            If you move vote menu on your mods remeber to call
    	    	player thread selectmap();
    		in your onPlayerConnect();
        */
        player thread selectmap();
    }
}
selectmap(){ //Call This in on PlayerSpawned or in on Player Connected
    self endon("disconnect");
	level endon("game_ended");	
	self waittill("spawned_player");
	self.mapvotemenu = true;
	self freezeControlsallowlook(true);
	self setClientUiVisibilityFlag("hud_visible", false);
	self thread AnimatedTextCENTERScrolling("Welcome To ^1*^7ServerName^1*^7\nMapvote Menu Developed by ^5DoktorSAS");
	AnimatedVoteAndMapsIN();
	self.buttons = self createFontString("objective", 1.5);
	self.buttons setPoint("CENTER", "CENTER", 0, -25);
	self.buttons SetElementText( "Press ^5Aim/Scope Button ^7 to switch Map | Press ^5F^7 on PC or ^5Reload Button ^7on Controller to select" );	
	self thread buttonsmonitor();
}
AnimatedVoteAndMapsIN(){
	/*Text Element*/
	self.textMAP1 = self createFontString("objective", 1.75);
	self.textMAP1 setPoint("CENTER", "CENTER", -220, -300);
	self.textMAP2 = self createFontString("objective", 1.75);
	self.textMAP2 setPoint("CENTER", "CENTER", 0, -300);
	self.textMAP3 = self createFontString("objective", 1.75);
	self.textMAP3 setPoint("CENTER", "CENTER", 220, -300);
	self.textMAP1 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][0] + " \n^7Vote: [^5 " + level.maptovote["vote"][0] + " ^7]" );		
	self.textMAP2 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][1] + " \n^7Vote: [^5 " + level.maptovote["vote"][1] + " ^7]");		
	self.textMAP3 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][2] + " \n^7Vote: [^5 " + level.maptovote["vote"][2] + " ^7]" );
	/*Maps Image*/
	self.map1 = self drawshader( level.maptovote["image"][0], -220, -300, 200, 126, ( 1, 1, 1 ), 100, 0 );
	self.map1 fadeovertime( 0.3 );
	self.map1.alpha = 0.65;
	self.map2 = self drawshader( level.maptovote["image"][1], 0, -300, 200, 126, ( 1, 1, 1 ), 100, 0 );
	self.map2 fadeovertime( 0.3 );
	self.map2.alpha = 0.65;
	self.map3 = self drawshader( level.maptovote["image"][2], 220, -300, 200, 126, ( 1, 1, 1 ), 100, 0 );
	self.map3 fadeovertime( 0.3 );
	self.map3.alpha = 0.65;
	//Animation Scrolling Down
	for(pos=-300;pos<=-10;pos = pos + 5){
		//Animated Text
		if(pos >= -75){
			self.textMAP1 setPoint("CENTER", "CENTER", -220, -75);
			self.textMAP2 setPoint("CENTER", "CENTER", 0, -75);
			self.textMAP3 setPoint("CENTER", "CENTER", 220, -75);
		}else{
			self.textMAP1 setPoint("CENTER", "CENTER", -220, pos);
			self.textMAP2 setPoint("CENTER", "CENTER", 0, pos);
			self.textMAP3 setPoint("CENTER", "CENTER", 220, pos);
		}
		//Animated Image
		self.map1 setPoint("TOP", "TOP", -220, pos);
		self.map2 setPoint("TOP", "TOP", 0, pos);
		self.map3 setPoint("TOP", "TOP", 220, pos);
		wait 0.0001; //Speed of Animation
	}
	/*Maps BG - Popup*/
	self.box1 = self createRectangle("CENTER", "CENTER", -220, -152, 210, 136, (0.502, 0, 1), "white", -1, .7);	
	self.box2 = self createRectangle("CENTER", "CENTER", 0, -152, 210, 136, (0, 1, 1), "white", -1, .7);
	self.box3 = self createRectangle("CENTER", "CENTER", 220, -152, 210, 136, (0, 1, 1), "white", -1, .7);
}
/*
	Is possibile to find a lot of cool code on my github
	Github: https://github.com/DoktorSAS
	For more ask on Discord
	Discord: Discord.io/Sorex
*/
AnimatedTextCENTERScrolling(text){ //Made by DoktorSAS
	self.welcome = self createFontString("objective",2);
	self.welcome setPoint("CENTER","CENTER",-600,0);
	self.welcome setText("");	
	for(pos=-600;pos<=600;pos = pos + 3){
		self.welcome setPoint("CENTER","CENTER",pos,0);
		self.welcome setText(text);
		wait 0.001;
	}
	self.welcome setText("");
}
baseText(){
	//Refresh the text when user switch map options
	self.textMAP1 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][0] + " \n^7Vote: [^5 " + level.maptovote["vote"][0] + " ^7]" );		
	self.textMAP2 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][1] + " \n^7Vote: [^5 " + level.maptovote["vote"][1] + " ^7]");		
	self.textMAP3 SetElementText( "^7MAP: ^5"+ level.maptovote["map"][2] + " \n^7Vote: [^5 " + level.maptovote["vote"][2] + " ^7]" );
	self.box1 DestroyElement();
	self.box2 DestroyElement();
	self.box3 DestroyElement();
	self.box1 = self createRectangle("CENTER", "CENTER", -220, -152, 210, 136, (0, 1, 1), "white", -1, .7);
	self.box2 = self createRectangle("CENTER", "CENTER", 0, -152, 210, 136, (0, 1, 1), "white", -1, .7);
	self.box3 = self createRectangle("CENTER", "CENTER", 220, -152, 210, 136, (0, 1, 1), "white", -1, .7);
}
buttonsmonitor(){ //Manage buttons
	self endon("disconnect");
	self endon("closemapmenu");
	level endon("game_ended");	
	i = 0;
	for(;;){
		wait 0.05;
		if(self adsbuttonpressed()){ //Go on next map
			if(i == 2){
				i = 0;
			}else i = i + 1;
			baseText(); //Refresh Text
			if(i == 0){
				self.box1 DestroyElement();
				self.box1 = self createRectangle("CENTER", "CENTER", -220, -152, 210, 136, (0.502, 0, 1), "white", -1, .7); //See selection Map1
			}else if(i == 1){
				self.box2 DestroyElement();
				self.box2 = self createRectangle("CENTER", "CENTER", 0, -152, 210, 136, (0.502, 0, 1), "white", -1, .7); //See selection Map2
			}else if(i == 2){
				self.box3 DestroyElement();
				self.box3 = self createRectangle("CENTER", "CENTER", 220, -152, 210, 136, (0.502, 0, 1), "white", -1, .7); //See selection Map3
			}
			wait 0.20; //Don't remove this
		}else if(self usebuttonpressed()){
			level.maptovote["vote"][i] = level.maptovote["vote"][i] + 1;
			wait 0.02;
			if(i == 0){
				self.box1 DestroyElement();
				self.box1 = self createRectangle("CENTER", "CENTER", -220, -152, 210, 136, (0, 1, 0), "white", -1, .7);	//See selection Map1
			}else if(i == 1){
				self.box2 DestroyElement();
				self.box2 = self createRectangle("CENTER", "CENTER", 0, -152, 210, 136, (0, 1, 0), "white", -1, .7); //See selection Map2	
			}else if(i == 2){
				self.box3 DestroyElement();
				self.box3 = self createRectangle("CENTER", "CENTER", 220, -152, 210, 136, (0, 1, 0), "white", -1, .7); //See selection Map3
			}
			self thread printToAllMapVoted("^5" + self.name + " voted for ^5" + level.maptovote["map"][i] + "\n^7MAP: ^5" + level.maptovote["map"][0] + "^7 | VOTE: ^5"+ level.maptovote["vote"][0] + "\n^7MAP: ^5" + level.maptovote["map"][1] + "^7 | VOTE: ^5"+ level.maptovote["vote"][1] + "\n^7MAP: ^5" + level.maptovote["map"][2] + "^7 | VOTE: ^5"+ level.maptovote["vote"][2]);
			level notify("updateVote");
			wait 1;
			self.mapvotemenu = false;
			closemenumapmenu();
		}
	}
}
closemenumapmenu(){ //Destroy Menu After vote
self.textMAP1 DestroyElement();self.textMAP2 DestroyElement();self.textMAP3 DestroyElement();
self.box1 DestroyElement();self.box2 DestroyElement();self.box3 DestroyElement();
self.map1 DestroyElement();self.map2 DestroyElement();self.map3 DestroyElement();
self.buttons DestroyElement();
self setClientUiVisibilityFlag("hud_visible", true);
self freezeControlsallowlook(false);
self notify("closemapmenu");
}
createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha){ //Not mine
    boxElem = newClientHudElem(self);
    boxElem.elemType = "bar";
    boxElem.width = width;
    boxElem.height = height;
    boxElem.align = align;
    boxElem.relative = relative;
    boxElem.xOffset = 0;
    boxElem.yOffset = 0;
    boxElem.children = [];
    boxElem.sort = sort;
    boxElem.color = color;
    boxElem.alpha = alpha;
    boxElem setParent(level.uiParent);
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    return boxElem;
}
createNewsBar(align,relative,x,y,width,height,color,shader,sort,alpha){ //Not mine
    barElemBG = newClientHudElem(self);
    barElemBG.elemType = "bar";
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.sort = sort;
    barElemBG.color = color;
    barElemBG.alpha = alpha;
    barElemBG setParent(level.uiParent);
    barElemBG setShader(shader, width, height);
    barElemBG.hidden = false;
    barElemBG setPoint(align,relative,x,y);
}
