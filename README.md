# Black ops 2 - GSC Codes
In this section there a few code for mod developer
# Welcome
*How to have it?*
1. Put the code in your mod
2. Puth this lines in your onPlayerSpawned() before **for(;;)**
```
	self waittill("spawned_player");
	self iprintln("Welcome To *ServerName*\nSecond Line\nThird Line");
	self iprintlnbold("Welcome To *ServerName*\nSecond Line\nThird Line");
	WelcomeMessage("Welcome To *ServerName*\n Second Line");
```

# Bots if Empty 
*How to have it?*
1. Put the code in your mod
2. And call *level thread botifempty();* in *init()*
