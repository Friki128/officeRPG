extends CanvasLayer
@onready var mariaBase = load("res://Battlers/maria_lazy.tscn")
@onready var bobBase = load("res://Battlers/bob_gossiper.tscn")
@onready var zeldaBase = load("res://Battlers/zelda_star.tscn")
var active = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	_on_zelda_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false


func _on_bob_pressed() -> void:
	if active!= null: active.queue_free()
	var bob = bobBase.instantiate()
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/MarginContainer/position.add_child(bob)
	active = bob
	$"..".employee = bobBase
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button.text = "Coffe Break"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button2.text = "Gossip"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button3.text = "Rush"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button4.text = "Distracted Work"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/RichTextLabel.text = "Bob is a pretty average worker but does the work on time.\n\nA serial gossiper, he will do anything to talk about the lifes of other coworkers and keeping and ear on private conversations.\n\nThat has caused problems with him rushing work to gossip more."
func _on_zelda_pressed() -> void:
	if active!= null: active.queue_free()
	var zelda = zeldaBase.instantiate()
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/MarginContainer/position.add_child(zelda)
	active = zelda
	$"..".employee = zeldaBase
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button.text = "Clean Code"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button2.text = "Problem Solving"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button3.text = "Short Vacation"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button4.text = "Innovative Idea"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/RichTextLabel.text = "I'm a software developer that really likes videogames, board games and hard puzzles.\n\nSince very little i've been interested in tecnology and software developer and have learned a lot in the process of research and personal projects.\n\nSpecially interested in game development, this webpage is a tribute to videogames.\n\nMy github account \"Friki128\" has some of my personal projects for everyone to see.\n\nYou can contact me via my gmail account zeldagarrocho@gmail.com or via my phone number +34 655 96 84 84."

func _on_maria_pressed() -> void:
	if active!= null: active.queue_free()
	var maria = mariaBase.instantiate()
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/MarginContainer/position.add_child(maria)
	active = maria
	$"..".employee = mariaBase
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button.text = "Procrastinate"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button2.text = "Personal Project"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button3.text = "Delayed Work"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Button4.text = "Boring Obligation"
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/Panel/MarginContainer/RichTextLabel.text = "Maria is a talented worker with a pretty big caviat.\n\nShe cannot concentrate for her life. \n\nWhen she does work, the work is great but most of the time she is doing anything but the work.\n\nMight have undiagnosed adhd."
