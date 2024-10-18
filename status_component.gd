extends Node
var status
var turns = 0
var target
var stage = 1

func addStatus(status_name, time):
	if status == status_name: stage += 1
	if stage > 4: stage = 4
	status = status_name
	turns = time

func checkStatus():
	return status
	
func afflict_end():
	match status:
		"burned":
			target.hit(5,"Percentage",100)
		"Bold":
			target.setBonuses(25*stage, -10*stage, -5*stage, -10*stage, 5*stage)
		"Fast":
			target.setBonuses(0,0,0,0,10*stage)
		"Motivated":
			target.setBonuses(10*stage,10*stage,5*stage,5*stage,0)
		null:
			target.setBonuses(0,0,0,0,0)
	turns -= 1
	if turns < 0:
		if status == "Resting": target.full_heal()
		turns = 0
		status = null

func afflict_start():
	match status:
		"Resting":
			target.setIncapacitated(true)
		"Electrocuted":
			var chance = randi_range(0,100)
			if chance > 50: target.setIncapacitated(true)
		"Bold":
			target.setBonuses(25*stage, -10*stage, -5*stage, -10*stage, 5*stage)
		"Fast":
			target.setBonuses(0,0,0,0,10*stage)
		"Motivated":
			target.setBonuses(10*stage,10*stage,5*stage,5*stage,0)
		"Clean":
			target.setBonuses(-15*stage,25*stage,5*stage,10*stage,5*stage)
		null:
			target.setBonuses(0,0,0,0,0)

func addTarget(new_target):
	target = new_target

func removeStatus():
	status = null
	turns = 0
	stage = 1
