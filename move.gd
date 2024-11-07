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
	Logger.doLog(caster.getName() + " used " + moveName)
	if damage != 0:
		if damaged:
			Logger.doLog(" and hit " + rival.getName() +"\n")
		else:
			Logger.doLog(" and missed the hit.\n")
	
	if heal != 0:
		if healed:
			Logger.doLog(" and healed\n")
		else:
			Logger.doLog(" and failed to heal\n")
		
		
	if enemyStatus != statusTypes.Null and ((healed and heal != 0) or (damaged and damage != 0) or unconditional):
		rival.applyStatus(enemyStatus, enemyTurns)
	if casterStatus != statusTypes.Null and ((healed and heal != 0) or (damaged and damage != 0) or unconditional):
		caster.applyStatus(casterStatus, casterTurns)
	
	if full_heal: 
		var fully_healed = caster.full_heal(accuracy)
		if fully_healed: Logger.doLog(" and fully fully healed.\n")
		else: Logger.doLog(" and failed to heal itself.\n")

func getTargetType():
	return targetType
	
func getName():
	return moveName
	
func getSpeed():
	return speed
