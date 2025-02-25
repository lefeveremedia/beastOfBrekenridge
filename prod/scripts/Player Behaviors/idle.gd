extends State

@export var move: State  # Reference to the Move state
@export var jump: State  # Reference to the Jump state
@export var fall: State  # Reference to the Fall state

func enter():
    super()  # Calls the enter function as defined in the State class
    animations.play("idle")  # Play the idle animation
    
    # Stop horizontal movement
    parent.velocity.x = 0
    parent.move_and_slide()

func physics(delta: float):
    # Transition to Move state if there's movement input
    if getXInput() != 0.0:
        return move
    
    # Transition to Fall state if the player is no longer on the floor AND Y velocity is positive (falling)
    if !parent.is_on_floor() and parent.velocity.y > 0:
        return fall
    
    return null

func input(event: InputEvent):
    # Transition to Jump state if the player presses the jump button and is on the floor or within coyote time
    if (parent.is_on_floor() or parent.coyoteTimeTimer > 0) and parent.jumpBufferTimer > 0:
        parent.jumpBufferTimer = 0.0  # Reset jump buffer timer
        return jump
    
    return null
