onPlayerSpawned(){
	self endon("disconnect");
	level endon("game_ended");
	self waittill("spawned_player");
	self iprintln("Welcome To *ServerName*\nSecond Line\nThird Line");
	self iprintlnbold("Welcome To *ServerName*\nSecond Line\nThird Line");
	WelcomeMessage("Welcome To *ServerName*\n Second Line");
	for(;;){
		self waittill("spawned_player");
		/*Put There if u need something there*/
	}
}
WelcomeMessage(line1, line2, icon, glow){
	hmb=spawnstruct();
	hmb.titleText=line1;
	hmb.notifyText=line2;
	hmb.iconName=icon;
	hmb.glowColor=glow;
	hmb.hideWhenInMenu=true;
	hmb.archived=false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(hmb);
	self thread AnimatedTextTOP("Welcome To *ServerName*");
	self thread AnimatedTextCENTER("Welcome To *ServerName*");
	self thread AnimatedTextBOTTOM("Welcome To *ServerName*");
}
AnimatedTextTOP(text){ //Made by DoktorSAS
	textSubStr = getSubStr(text,0,text.size);
	result = "";
	self.welcome = self createFontString("objective",2);
	self.welcome setPoint("CENTER","CENTER",0,-200);
	self.welcome setText("");	
	for(i=0;i<textSubStr.size;i++){
		result = result + textSubStr[i];
		self.welcome setText(result);
		wait 0.5;
	}
	self.welcome setText("");
}
AnimatedTextCENTER(text){ //Made by DoktorSAS
	textSubStr = getSubStr(text,0,text.size);
	result = "";
	self.welcome = self createFontString("objective",2);
	self.welcome setPoint("CENTER","CENTER",0,0);
	self.welcome setText("");	
	for(i=0;i<textSubStr.size;i++){
		result = result + textSubStr[i];
		self.welcome setText(result);
		wait 0.5;
	}
	self.welcome setText("");
}
AnimatedTextBOTTOM(text){ //Made by DoktorSAS
	textSubStr = getSubStr(text,0,text.size);
	result = "";
	self.welcome = self createFontString("objective",2);
	self.welcome setPoint("CENTER","CENTER",0,200);
	self.welcome setText("");	
	for(i=0;i<textSubStr.size;i++){
		result = result + textSubStr[i];
		self.welcome setText(result);
		wait 0.5;
	}
	self.welcome setText("");
}
AnimatedTextTOPcrolling(text){ //Made by DoktorSAS
	self.welcome = self createFontString("objective",2);
	self.welcome setPoint("CENTER","CENTER",-600,-200);
	self.welcome setText("");	
	for(pos=-600;pos<=600;pos = pos + 3){
		self.welcome setPoint("CENTER","CENTER",pos,0);
		self.welcome setText(text);
		wait 0.02;
	}
	self.welcome setText("");
}
AnimatedTextCENTERScrolling(text){ //Made by DoktorSAS
	self.welcome = self createFontString("objective",2);
	self.welcome setPoint("CENTER","CENTER",-600,0);
	self.welcome setText("");	
	for(pos=-600;pos<=600;pos = pos + 3){
		self.welcome setPoint("CENTER","CENTER",pos,0);
		self.welcome setText(text);
		wait 0.02;
	}
	self.welcome setText("");
}
AnimatedTextBOTTOMScrolling(text){ //Made by DoktorSAS
	self.welcome = self createFontString("objective",2);
	self.welcome setPoint("CENTER","CENTER",-600,200);
	self.welcome setText("");	
	for(pos=-600;pos<=600;pos = pos + 3){
		self.welcome setPoint("CENTER","CENTER",pos,0);
		self.welcome setText(text);
		wait 0.02;
	}
	self.welcome setText("");
}