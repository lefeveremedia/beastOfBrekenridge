extends Node2D

# Return the desired direction of movement for the player in range [-1, 1]
func getMovementDirection() -> float:
    return Input.get_axis("Move Left", "Move Right")

# Return a boolean indicating if the player wants to start a jump (initial press)
func wantsToStartJump() -> bool:
    return Input.is_action_just_pressed("Jump")

# Return a boolean indicating if the player wants to hold the jump button
func wantsToHoldJump() -> bool:
    return Input.is_action_pressed("Jump")

# Return a boolean indicating if the player wants to end the jump
func wantsToEndJump() -> bool:
    return Input.is_action_just_released("Jump")
