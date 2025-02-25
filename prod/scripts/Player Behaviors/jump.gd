extends State

@export var fall: State  # Reference to the Fall state

var movement: float
var jumpTime: float = 0.0  # Tracks how long the jump button has been held

func enter():
    super()  # Calls the enter function as defined in the State class
    animations.play("jump")  # Play the jump animation
    
    # Apply upward force for the jump
    parent.velocity.y = -parent.jumpForce
    jumpTime = 0.0  # Reset jump time on entering the state
    parent.isJumping = true  # Set jumping flag to true


func physics(delta: float):
    # Get movement input and calculate movement force
    movement = getXInput() * parent.speed
    
    # Apply movement force to player velocity (only X axis)
    parent.velocity.x = movement
    
    # Handle variable jump height
    if parent.moveInput.wantsToHoldJump():  # Check if jump button is held
        jumpTime += delta
        if jumpTime < parent.maxJumpTime:
            # Continue applying upward force while jump button is held
            var jumpScale = jumpTime / parent.maxJumpTime  # Calculate jump scale (increases over time)
            parent.velocity.y = -parent.jumpForce * (1.0 + jumpScale)  # Increase upward force
        else:
            # Stop applying upward force after max jump time is reached
            parent.isJumping = false
    else:
        # Stop applying upward force if jump button is released early
        parent.isJumping = false
    
    # Apply gravity based on ascent or descent
    if parent.velocity.y < 0:
        # Apply lower gravity during ascent
        parent.velocity.y += parent.gm.gravity * parent.ascentGravityScale * delta
    else:
        # Apply higher gravity during descent
        parent.velocity.y += parent.gm.gravity * parent.descentGravityScale * delta
    
    # Move the player
    parent.move_and_slide()
    
    # Transition to Fall state if the player is descending (positive Y velocity)
    if parent.velocity.y > 0:
        return fall
    
    return null
