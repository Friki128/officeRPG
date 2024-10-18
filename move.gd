extends Node
enum types {Normal, Percentage}
enum targetTypes {Self, Enemy}
enum statusTypes {Null, Burned, Electrocuted, Resting, Bold, Clean, Motivated, Fast}
@export var moveName : String
@export var targetType : targetTypes
@export var type : types
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
	var damaged = rival.damage(damage + bonusDamage, type, accuracy + bonusAccuracy)
	
	if damage != 0:
		print(caster.getName() + "used " + moveName)
		if damaged:
			print(" and hit " + rival.getName())
		else:
			print(" and missed")
	
	if heal != 0:
		print(caster.getName() + "used " + moveName)
		if healed:
			print(" and healed")
		else:
			print(" and missed")
		
		
	if enemyStatus != statusTypes.Null and damaged:
		rival.applyStatus(enemyStatus, enemyTurns)
	if casterStatus != statusTypes.Null and healed:
		caster.applyStatus(casterStatus, casterTurns)
	
	if full_heal: 
		var fully_healed = caster.full_heal(accuracy)
		if fully_healed: print(caster.getName() + "used fully healed")
		else: print(caster.getName() + "used and failed to heal itself")

func getTargetType():
	return targetType
	
func getName():
	return moveName
