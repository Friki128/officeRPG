extends Button
var move : Node
@onready var battle = $"../../../../../.."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMove(move):
	self.move = move

func _on_pressed() -> void:
	battle.moveSelectedByPlayer(move)
