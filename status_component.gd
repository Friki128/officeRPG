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
		"poisoned":
			pass
		null:
			target.setBonuses(0,0,0,0)
	turns -= 1
	if turns < 0:
		turns = 0
		status = null

func afflict_start():
	match status:
		"Resting":
			target.setIncapacitated(true)
		"Electrocuted":
			var chance = randi_range(0,100)
			if chance > 50: target.setIncapacitated(true)
		null:
			target.setBonuses(0,0,0,0)

func addTarget(new_target):
	target = new_target

func removeStatus():
	status = null
	turns = 0
	stage = 1
