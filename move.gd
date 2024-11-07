extends Node
class_name Move
enum types {Normal, Percentage}
enum targetTypes {Self, Enemy}
enum statusTypes {Null, Burned, Electrocuted, Resting, Bold, Clean, Motivated, Fast}
@export var moveName : String
@export var targetType : targetTypes
@export var type : types
@export var unconditional : bool
@export var speed : int
@export var damage : int
@export var heal : int
@export var full_heal : bool
@export var accuracy : int
@export var casterStatus : statusTypes
@export var casterTurns : int
@export var enemyStatus : statusTypes
@export var enemyTurns : int
@export var description : String


func activate(rival, caster, bonusAccuracy, bonusDamage):
	var healed = caster.heal(heal, type, accuracy)
	var damaged = rival.hit(damage + bonusDamage, type, accuracy + bonusAccuracy)
	print(caster.getName() + " used " + moveName)
	if damage != 0:
		if damaged:
			print(" and hit " + rival.getName())
		else:
			print(" and missed the hit")
	
	if heal != 0:
		if healed:
			print(" and healed")
		else:
			print(" and failed to heal")
		
		
	if enemyStatus != statusTypes.Null and ((healed and heal != 0) or (damaged and damage != 0) or unconditional):
		rival.applyStatus(enemyStatus, enemyTurns)
	if casterStatus != statusTypes.Null and ((healed and heal != 0) or (damaged and damage != 0) or unconditional):
		caster.applyStatus(casterStatus, casterTurns)
	
	if full_heal: 
		var fully_healed = caster.full_heal(accuracy)
		if fully_healed: print("and fully fully healed")
		else: print("and failed to heal itself")

func getTargetType():
	return targetType
	
func getName():
	return moveName
	
func getSpeed():
	return speed
