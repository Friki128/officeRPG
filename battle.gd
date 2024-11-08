extends CanvasLayer

var playerBattler
var enemyBattler
var enemies
var turn = 0
var enemyIndex = 0
@onready var log = $Control/CenterContainer/VBoxContainer/RichTextLabel/MarginContainer/RichTextLabel
@export var animation : Node

func startBattle(battler1, currentEnemies):
	get_tree().paused = true
	playerBattler = battler1
	enemies = currentEnemies
	enemyBattler = enemies[enemyIndex].instantiate()
	enemyIndex += 1
	$Control/CenterContainer/VBoxContainer/HBoxContainer/MarginContainer/enemyPosition.add_child(enemyBattler)
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/MarginContainer/playerPosition.add_child(playerBattler)
	playerBattler.setRival(enemyBattler)
	enemyBattler.setRival(playerBattler)
	var playerMoves = playerBattler.getMoves()
	var move1 = playerMoves.pop_front()
	var move2 = playerMoves.pop_front()
	var move3 = playerMoves.pop_front()
	var move4 = playerMoves.pop_front()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button.text = move1.getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button2.text = move2.getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button3.text = move3.getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button4.text = move4.getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/VBoxContainer/playerBar.max_value = playerBattler.getHp()
	
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button.setMove(move1)
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button2.setMove(move2)
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button3.setMove(move3)
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button4.setMove(move4)
	$Control/CenterContainer/VBoxContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/enemyBar.max_value = enemyBattler.getHp()
	turn = 0
	self.visible = true
	nextTurn()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	Logger.connect("logText", logEvent)

func nextTurn():
	if checkDeath(): 
		endBattle()
		return
	updateGameInfo()
	turn += 1
	Logger.doLog("Turn: " + str(turn) + "\n")

func updateGameInfo():
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/VBoxContainer/PlayerStatus.text = playerBattler.getStatus()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/VBoxContainer/PlayerName.text = playerBattler.getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/VBoxContainer/PlayerHp.text = str(playerBattler.getCurrentHp()) + "/" + str(playerBattler.getHp())
	$Control/CenterContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/VBoxContainer/playerBar.value = playerBattler.getCurrentHp()
	
	$Control/CenterContainer/VBoxContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/enemyName.text = enemyBattler.getName()
	$Control/CenterContainer/VBoxContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/enemyStatus.text = enemyBattler.getStatus()
	$Control/CenterContainer/VBoxContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/enemyHp.text = str(enemyBattler.getCurrentHp()) + "/" + str(enemyBattler.getHp())
	$Control/CenterContainer/VBoxContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/enemyBar.value = enemyBattler.getCurrentHp()

func endBattle():
	get_tree().paused = false
	enemyIndex = 0
	enemyBattler.queue_free()
	playerBattler.queue_free()
	self.visible = false
	$"../CanvasLayer/battle_enter_animation".play()

func moveSelectedByPlayer(move):
	log.text = ""
	var enemyMove = enemyBattler.pick_random_move()
	var enemySpeed = enemyBattler.getSpeed() + enemyMove.getSpeed()
	var playerSpeed = playerBattler.getSpeed() + move.getSpeed()
	if enemySpeed > playerSpeed:
		enemyBattler.pick_move(enemyMove)
		playerBattler.pick_move(move)
	elif enemySpeed <= playerSpeed:
		playerBattler.pick_move(move)
		enemyBattler.pick_move(enemyMove)
	nextTurn()

func logEvent(text):
	log.text += text

func checkDeath():
	if enemyBattler.getCurrentHp() == 0:
		if enemyIndex < 3:
			Logger.doLog(enemyBattler.getName() + " was defeated.\n")
			enemyBattler.queue_free()
			enemyBattler = enemies[enemyIndex].instantiate()
			enemyIndex += 1
			$Control/CenterContainer/VBoxContainer/HBoxContainer/MarginContainer/enemyPosition.add_child(enemyBattler)
			$Control/CenterContainer/VBoxContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/enemyBar.max_value = enemyBattler.getHp()
			enemyBattler.setRival(playerBattler)
			playerBattler.setRival(enemyBattler)
		else:
			return true
	if playerBattler.getCurrentHp() == 0:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://lost_page.tscn")
	return false
