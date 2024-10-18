extends Node
@export var battlerName : String
@export var moveset:Array[Node]
@onready var lifeComponent = get_node("lifeComponent")
@export var hp = 100
@onready var statusComponent = get_node("statusComponent")
@export var description : String
var rival = null
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

func applyStatus(status, turns):
	statusComponent.addStatus(status, turns)

func pick_random_move():
	pick_move(moveset.pick_random())
	
func pick_move(move):
	statusComponent.afflict_start()
	if incapacitated: return
	move.activate(rival, self, bonusAccuracy, bonusDamage)
	statusComponent.afflict_end()
	setIncapacitated(false)

func hit(ammount, type, accuracy):
	var hit_attempt = randi_range(0,100)
	if hit_attempt + bonusDodge > accuracy: return false
	if type == "Normal":
		lifeComponent.damage(ammount - bonusDefense)
	else:
		lifeComponent.percentage_damage(ammount)
	return true
		
func heal(ammount, type, accuracy):
	var heal_attempt = randi_range(0,100)
	if heal_attempt > accuracy: return false
	if type == "Normal":
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
