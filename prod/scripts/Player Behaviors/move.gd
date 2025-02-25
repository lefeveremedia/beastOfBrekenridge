extends State

@export var idle: State  # Reference to the Idle state
@export var jump: State  # Reference to the Jump state
@export var fall: State  # Reference to the Fall state

var movement: float

func enter():
    super()  # Calls the enter function as defined in the State class
    animations.play("run")  # Play the run animation

func physics(delta: float):
    # Get movement input and calculate movement force
    movement = getXInput() * parent.speed
    
    # Apply movement force to player velocity
    parent.velocity.x = movement
    
    # Move the player
    parent.move_and_slide()
    
    # Transition to Idle state if there's no movement input
    if getXInput() == 0:
        return idle
    
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
