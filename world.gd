extends Node2D

@export var enemies = [load("res://Battlers/LooseWire.tscn"), load("res://Battlers/sans_undertale.tscn"), load("res://Battlers/bug.tscn"), load("res://Battlers/hacker.tscn"), load("res://Battlers/internet_error.tscn"), load("res://Battlers/printer.tscn"), load("res://Battlers/code_smell.tscn"), load("res://Battlers/technical_debt.tscn")]
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
	create_encounter()
	
func create_encounter():
	$player/CanvasLayer/battle_enter_animation.play()

func toggleBattle():
	if battleStatus:
		battle.endBattle()
	else:
		var currentEnemies = [enemies.pick_random(), enemies.pick_random(), enemies.pick_random()]
		battle.startBattle(player.getEmployee().instantiate(), currentEnemies)
