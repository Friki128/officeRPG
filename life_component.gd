extends Node
@export var initial_hp := 10
var hp := 10

func _ready():
	full_heal()

func full_heal():
	hp = initial_hp

func damage(ammount):
	hp -= ammount
	if hp < 1:
		hp = 0
		die()
		
func percentage_damage(ammount):
	damage(ammount * initial_hp / 100)

func heal(ammount):
	hp +=  ammount
	if hp > initial_hp:
		full_heal()
			
func percentage_heal(ammount):
	heal(ammount * initial_hp / 100)

func die():
	emit_signal("died")
