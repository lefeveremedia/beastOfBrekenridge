extends State

@export var idle: State  # Reference to the Idle state
@export var wallSlide: State  # Reference to the WallSlide state

var movement: float

func enter():
    super()  # Calls the enter function as defined in the State class
    animations.play("fall")  # Play the fall animation

func physics(delta: float):
    # Get movement input and calculate movement force
    movement = getXInput() * parent.speed
    
    # Apply movement force to player velocity (only X axis)
    parent.velocity.x = movement
    
    # Apply gravity
    parent.velocity.y += parent.gm.gravity * delta
    
    # Move the player
    parent.move_and_slide()
    
    # Transition to Idle state if the player lands (is_on_floor() and Y velocity is not falling)
    if parent.is_on_floor() and parent.velocity.y >= 0:
        return idle
    
    # Transition to WallSlide state if the player is touching a wall
    if parent.isTouchingWall:
        return wallSlide
    
    return null
