extends Node2D
class_name gameManager

@export var gravity: float = 1200.0 #universial downward force

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func returnGravity():
    return gravity
    pass
