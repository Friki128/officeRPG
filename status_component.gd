extends Node
var status = Move.statusTypes.Null
var turns = 0
var target
var stage = 1

func addStatus(status_name, time):
	if status == Move.statusTypes.Resting:
		Logger.doLog(target.getName() + " is now awake.\n")
		target.setIncapacitated(false)
	if status == status_name: 
		if stage < 4:
			Logger.doLog("Will increment it's stage by one.\n")
		stage += 1
	else: 
		Logger.doLog(target.getName() + " is now " + Move.statusTypes.keys()[status_name] + "\n")
		stage = 1
	if stage > 4: 
		stage = 4
	status = status_name
	turns = time

func checkStatus():
	return status
	
func afflict_end():
	match Move.statusTypes.keys()[status]:
		"Burned":
			Logger.doLog(target.getName() + " is burned and takes damage.\n")
			target.hit(5*stage,Move.types.Percentage,100)
		"Bold":
			target.setBonuses(25*stage, -10*stage, -5*stage, -10*stage, 5*stage)
		"Fast":
			target.setBonuses(0,0,0,0,10*stage)
		"Motivated":
			target.setBonuses(10*stage,10*stage,5*stage,5*stage,0)
		"Null":
			target.setBonuses(0,0,0,0,0)
	turns -= 1
	if turns <= 0 and status != Move.statusTypes.Null:
		if status == Move.statusTypes.Resting: 
			Logger.doLog(target.getName() + " is fully rested and will get fully healed.\n")
			target.full_heal(100)
		removeStatus()
	target.setIncapacitated(false)

func afflict_start():
	match Move.statusTypes.keys()[status]:
		"Resting":
			Logger.doLog(target.getName() + " is resting and will not be able to move.\n")
			target.setIncapacitated(true)
			
		"Electrocuted":
			var chance = randi_range(0,100) + 10*stage
			if chance > 80: 
				Logger.doLog(target.getName() + " is electrocuted and will not be able to move.\n")
				target.setIncapacitated(true)
				
		"Bold":
			target.setBonuses(25*stage, -10*stage, -5*stage, -10*stage, 5*stage)
		"Fast":
			target.setBonuses(0,0,0,0,10*stage)
		"Motivated":
			target.setBonuses(10*stage,10*stage,5*stage,5*stage,0)
		"Clean":
			target.setBonuses(-15*stage,25*stage,5*stage,10*stage,5*stage)
		"Null":
			target.setBonuses(0,0,0,0,0)

func addTarget(new_target):
	target = new_target

func removeStatus():
	status = Move.statusTypes.Null
	turns = 0
	stage = 1
