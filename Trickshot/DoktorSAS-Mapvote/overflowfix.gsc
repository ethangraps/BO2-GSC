OverflowFix(){
	level endon("game_ended");
    level waittill("connected", player);
    level.stringtable = [];
    level.textelementtable = [];
    textanchor = CreateServerFontString("default", 1);
    textanchor SetElementText("Anchor");
    textanchor.alpha = 0; 

    if (GetDvar("g_gametype") == "tdm" || GetDvar("g_gametype") == "hctdm")
        limit = 54;

    if (GetDvar("g_gametype") == "dm" || GetDvar("g_gametype") == "hcdm")
        limit = 54;

    if (GetDvar("g_gametype") == "dom" || GetDvar("g_gametype") == "hcdom")
        limit = 38;

    if (GetDvar("g_gametype") == "dem" || GetDvar("g_gametype") == "hcdem")
        limit = 41;

    if (GetDvar("g_gametype") == "conf" || GetDvar("g_gametype") == "hcconf")
        limit = 53;

    if (GetDvar("g_gametype") == "koth" || GetDvar("g_gametype") == "hckoth")
        limit = 41;

    if (GetDvar("g_gametype") == "hq" || GetDvar("g_gametype") == "hchq")
        limit = 43;

    if (GetDvar("g_gametype") == "ctf" || GetDvar("g_gametype") == "hcctf")
        limit = 32;

    if (GetDvar("g_gametype") == "sd" || GetDvar("g_gametype") == "hcsd")
        limit = 38;

    if (GetDvar("g_gametype") == "oneflag" || GetDvar("g_gametype") == "hconeflag")
        limit = 25;

    if (GetDvar("g_gametype") == "gun")
        limit = 48;

    if (GetDvar("g_gametype") == "oic")
        limit = 51;

    if (GetDvar("g_gametype") == "shrp")
        limit = 48;

    if (GetDvar("g_gametype") == "sas")
        limit = 50;

    if (IsDefined(level.stringoptimization))
        limit += 172;

    while (!level.gameended)    {      
        if (IsDefined(level.stringoptimization) && level.stringtable.size >= 100 && !IsDefined(textanchor2)){
            textanchor2 = CreateServerFontString("default", 1);
            textanchor2 SetElementText("Anchor2");                
            textanchor2.alpha = 0; 
        }
        if (level.stringtable.size >= limit){
            if (IsDefined(textanchor2)){
                textanchor2 ClearAllTextAfterHudElem();
                textanchor2 DestroyElement();
            }           
            textanchor ClearAllTextAfterHudElem();
            level.stringtable = [];           

            foreach (textelement in level.textelementtable){
                if (!IsDefined(self.label))
                    textelement SetElementText(textelement.text);
                else
                    textelement SetElementValueText(textelement.text);
            }
        }            
        wait 0.01;
    }
}
SetElementText(text){
    self SetText(text);
    if (self.text != text)
        self.text = text;
    if (!IsInArray(level.stringtable, text))
        level.stringtable[level.stringtable.size] = text;
    if (!IsInArray(level.textelementtable, self))
        level.textelementtable[level.textelementtable.size] = self;
}
SetElementValueText(text){
    self.label = &"" + text;  
    if (self.text != text)
        self.text = text;
    if (!IsInArray(level.stringtable, text))
        level.stringtable[level.stringtable.size] = text;
    if (!IsInArray(level.textelementtable, self))
        level.textelementtable[level.textelementtable.size] = self;
}
DestroyElement(){
    if (IsInArray(level.textelementtable, self))
        ArrayRemoveValue(level.textelementtable, self);
    if (IsDefined(self.elemtype)){
        self.frame Destroy();
        self.bar Destroy();
        self.barframe Destroy();
    }       
    self Destroy();
}
drawtext( text, font, fontscale, x, y, color, alpha, glowcolor, glowalpha, sort ){
	hud = self createfontstring( font, fontscale );
	hud SetElementText( text );
	hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	return hud;
}
drawshader( shader, x, y, width, height, color, alpha, sort ){
	hud = newclienthudelem( self );
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud.x = x;
	hud.y = y;
	return hud;
}

