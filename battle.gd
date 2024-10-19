extends CanvasLayer

@onready var playerBattler : Node = preload("res://Battlers/LooseWire.tscn").instantiate()
@onready var enemyBattler : Node = preload("res://Battlers/LooseWire.tscn").instantiate()
var turn = 0
@export var animation : Node

func startBattle(battler1, battler2):
	playerBattler = battler1
	enemyBattler = battler2
	
	add_child(enemyBattler)
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/MarginContainer/playerPosition.add_child(playerBattler)
	playerBattler.scale.x = 4
	playerBattler.scale.y = 4
	var playerMoves = playerBattler.getMoves()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button.text = playerMoves.pop_front().getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button2.text = playerMoves.pop_front().getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button3.text = playerMoves.pop_front().getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button4.text = playerMoves.pop_front().getName()
	turn = 0
	self.visible = true
	nextTurn()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

func nextTurn():
	updateGameInfo()
	turn += 1
	print("Turn: " + str(turn))

func updateGameInfo():
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/VBoxContainer/PlayerName.text = playerBattler.getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/VBoxContainer/PlayerHp.text = str(playerBattler.getCurrentHp()) + "/" + str(playerBattler.getHp())

func endBattle():
	self.visible = false
	animation.play()

func moveSelectedByPlayer(move):
	var enemyMove = enemyBattler.pick_random_move()
	var enemySpeed = enemyBattler.getSpeed() + enemyMove.getSpeed()
	var playerSpeed = playerBattler.getSpeed() + move.getSpeed()
	if enemySpeed > playerSpeed:
		enemyBattler.pick_move(enemyMove)
		playerBattler.pick_move(move)
	elif enemySpeed <= playerSpeed:
		playerBattler.pick_move(move)
		enemyBattler.pick_move(enemyMove)
