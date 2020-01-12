//------------------------------------------------//
var/list/Bans = list()
var/list/IPBans = list()
var/list/IDBans = list()
var/tmp/list/boots = list()

proc
	BanSave()
		if(length(Bans)||length(IPBans)||length(IDBans))
			var/savefile/F = new("Bans.sav")
			F["Bans"] << Bans
			F["IPBans"] << IPBans
			F["IDBans"] << IDBans
proc
	BanLoad()
		if(fexists("Bans.sav"))
			var/savefile/F = new("Bans.sav")
			F["Bans"] >> Bans
			F["IPBans"] >> IPBans
			F["IDBans"] >> IDBans
client/New()
	..()
	if(Bans.Find(key))
		src.verbs-=src.verbs
		src<<"<font color = red><big>You're banned from [world.name].</font>"
		del(src)
	if(IPBans.Find(address))
		src.verbs-=src.verbs
		src<<"<font color = red><big>You're banned from [world.name].</font>"
		del(src)
	if(IsComputerBanned())
		src<<"You are banned"
		del(src)
	//macros = new/button_tracker/echo

world
	New()
		..()
		BanLoad()
world
	Del()
		..()
		BanSave()

var/list/computer_bans=list()
proc
	saveComputerBans()
		var/savefile/F=new("computer_bans.sav")
		F<<computer_bans
	loadComputerBans()
		if(fexists("computer_bans.sav"))
			var/savefile/F=new("computer_bans.sav")
			F>>computer_bans

world
	New()
		loadComputerBans()
		..()
	Del()
		saveComputerBans()
		..()
client
	proc
		IsComputerBanned()
			if(computer_id in computer_bans)return 1
			else return 0