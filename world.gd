extends Node2D

@export var enemies = ["hola", "adios"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_player_random_encounter():
	create_encounter(enemies.pick_random())
	
func create_encounter(enemy):
	$player/CanvasLayer/battle_enter_animation.play()
