extends Node
@export var moveset:Array[Node]
@onready var lifeComponent = get_node("lifeComponent")
@export var hp = 10
@onready var statusComponent = get_node("statusComponent")

func _ready():
	lifeComponent.set_initial_hp(hp)
	full_heal()

func applyStatus(status, turns):
	statusComponent.addStatus(status, turns)

func pick_random_move():
	moveset.pick_random().activate()
	
func pick_move(move):
	move.activate()

func hit(ammount, type, accuracy):
	var hit_attempt = randi_range(0,100)
	if hit_attempt > accuracy: return
	if type == "normal":
		lifeComponent.damage(ammount)
	else:
		lifeComponent.percentage_damage(ammount)
		
func heal(ammount, type, accuracy):
	var heal_attempt = randi_range(0,100)
	if heal_attempt > accuracy: return
	if type == "normal":
		lifeComponent.heal(ammount)
	else:
		lifeComponent.percentage_heal(ammount)
		
func full_heal():
	lifeComponent.full_heal()
