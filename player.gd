extends CharacterBody2D

signal random_encounter
const SPEED = 100.0
var facing = "down"
@onready var anim = get_node("AnimatedSprite2D")
var employee = load("res://Battlers/zelda_star.tscn")
var steps = randi_range(15,100)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := 0
	var axis := 0
	if Input.is_action_pressed("ui_down"):
		direction = 1
		axis = 1
		facing = "down"
		
	if Input.is_action_pressed("ui_up"):
		direction = -1
		axis = 1
		facing = "up"
		
	if Input.is_action_pressed("ui_right"):
		direction = 1
		axis = -1
		facing = "right"
	if Input.is_action_pressed("ui_left"):
		direction = -1
		axis = -1
		facing = "left"
	
	if axis == 1:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if axis == -1:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if axis == 0:
		anim.play(facing + "_idle")
	else:
		anim.play(facing + "_walk")
		steps -= 1
		if steps < 0 and employee != null:
			steps = randi_range(100,300)
			emit_signal("random_encounter")
	

	move_and_slide()

func getEmployee():
	return employee
