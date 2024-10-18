extends Node
@export var type : String
@export var damage : int
@export var heal : int
@export var full_heal : bool
@export var description : String
@export var accuracy : int
@export var status : String
@export var turns : int
@export var speed : int
@export var targetType : String
func activate(target, bonusAccuracy, bonusDamage):
	target.heal(heal, type, accuracy)
	var damaged = target.damage(damage + bonusDamage, type, accuracy + bonusAccuracy)
	if full_heal: target.full_heal(accuracy)
	if status != null and damaged:
		target.applyStatus(status, turns)

func getTargetType():
	return targetType
	
