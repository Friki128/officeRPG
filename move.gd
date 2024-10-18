extends Node
enum types {Normal, Percentage}
enum targetTypes {Self, Enemy}
enum statusTypes {Null, Burned, Electrocuted, Resting, Bold, Clean, Motivated, Fast}
@export var targetType : targetTypes
@export var type : types
@export var damage : int
@export var heal : int
@export var full_heal : bool
@export var accuracy : int
@export var status : statusTypes
@export var turns : int
@export var speed : int
@export var description : String

func activate(target, bonusAccuracy, bonusDamage):
	target.heal(heal, type, accuracy)
	var damaged = target.damage(damage + bonusDamage, type, accuracy + bonusAccuracy)
	if full_heal: target.full_heal(accuracy)
	if status != statusTypes.Null and damaged:
		target.applyStatus(status, turns)

func getTargetType():
	return targetType
	
