extends State

@export var fall: State  # Reference to the Fall state

var movement: float

func enter():
    super()  # Calls the enter function as defined in the State class
    animations.play("wallJump")  # Play the wall jump animation
    
    # Apply wall jump force
    parent.velocity.x = parent.wallJumpForceX if parent.transform.x.x == -1 else -parent.wallJumpForceX
    parent.transform.x.x *= -1
    parent.velocity.y -= parent.wallJumpForceY

func physics(delta: float):
    # Apply gravity
    parent.velocity.y += parent.gm.gravity * delta
    
    ## Get movement input and calculate movement force
    #movement = getXInput() * parent.speed
    #
    # Apply movement force to player velocity
    parent.velocity.x += getXInput() * parent.speed
    #
    ## Move the playerdadadadadadadadadadadadadadadwwwwdawd
    #parent.move_and_slide()
    
    # Transition to Fall state if the player is descending (positive Y velocity)
    if parent.velocity.y > 0:
        return fall
    return null
