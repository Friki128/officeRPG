extends Node2D
class_name Battler
@export var battlerName : String
@export var moveset:Array[String]
@onready var animation = get_node("Sprite2D")
var moves : Array[Node]
@onready var lifeComponent = get_node("lifeComponent")
@export var hp = 100
@onready var statusComponent = get_node("statusComponent")
@export var description : String
var rival = self
var bonusAccuracy = 0
var bonusDamage = 0
var bonusDefense = 0
var bonusDodge = 0
var speedBonus = 0
var incapacitated = false


func _ready():
	lifeComponent.set_initial_hp(hp)
	full_heal(100)
	statusComponent.addTarget(self)
	for move in moveset:
		moves.append(load("res://moves/" + move + ".tscn").instantiate())
	animation.play("combat")
	
func applyStatus(status, turns):
	statusComponent.addStatus(status, turns)

func pick_random_move():
	return moves.pick_random()
	
func pick_move(move):
	statusComponent.afflict_start()
	if !incapacitated: 
		move.activate(rival, self, bonusAccuracy, bonusDamage)
	statusComponent.afflict_end()

func hit(ammount, type, accuracy):
	var hit_attempt = randi_range(0,100)
	if hit_attempt + bonusDodge > accuracy: return false
	if type == Move.types.Normal:
		lifeComponent.damage(ammount - bonusDefense)
	else:
		lifeComponent.percentage_damage(ammount)
	return true
		
func heal(ammount, type, accuracy):
	var heal_attempt = randi_range(0,100)
	if heal_attempt > accuracy: return false
	if type == Move.types.Normal:
		lifeComponent.heal(ammount)
	else:
		lifeComponent.percentage_heal(ammount)
	return true
		
func full_heal(accuracy):
	var heal_attempt = randi_range(0,100)
	if heal_attempt > accuracy: return false
	lifeComponent.full_heal()
	return true
	
func setIncapacitated(status):
	incapacitated = status
	
func removeStatus():
	statusComponent.removeStatus()

func setBonuses(damage, defense, accuracy, dodge, speed):
	bonusDamage = damage
	bonusDefense = defense
	bonusAccuracy = accuracy
	bonusDodge = dodge
	speedBonus = speed

func getName():
	return battlerName

func getSpeed():
	return speedBonus
	
func getMoves():
	return moves
	
func getAnimation():
	return animation
	
func getHp():
	return lifeComponent.getInitialHp()

func getCurrentHp():
	return lifeComponent.getHp()
	
func getStatus():
	var currentStatus = statusComponent.checkStatus()
	if currentStatus != Move.statusTypes.Null:
		return Move.statusTypes.keys()[currentStatus]
	return ""
func setRival(target):
	rival = target
