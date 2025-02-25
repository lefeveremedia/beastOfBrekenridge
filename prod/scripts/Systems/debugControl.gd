extends Control

# Reference to the Label node
@onready var debugLabel: Label = $ColorRect/Label

# Function to update the debug text
func updateDebugInfo(position: Vector2, velocity: Vector2, state: String) -> void:
    # Format the debug text
    var debugText :=  "X Position: %.1f\n" % position.x
    debugText += "Y Position: %.1f\n" % position.y
    debugText += "X Velocity: %.1f\n" % velocity.x
    debugText += "Y Velocity: %.1f\n" % velocity.y
    debugText += "State: %s" % state
    
    # Update the label text
    debugLabel.text = debugText
