extends Node2D

@export var enemies = [load("res://Battlers/LooseWire.tscn")]
var rival = null
@onready var player = get_node("player")
@export var battle : Node
var battleStatus = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_player_random_encounter():
	create_encounter(enemies.pick_random())
	
func create_encounter(enemy):
	rival = enemy
	$player/CanvasLayer/battle_enter_animation.play()

func toggleBattle():
	if battleStatus:
		battle.endBattle()
	else:
		battle.startBattle(player.getEmployee().instantiate(), rival.instantiate())
