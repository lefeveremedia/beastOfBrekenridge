extends State

@export var wallJump: State  # Reference to the WallJump state
@export var fall: State  # Reference to the Fall state

var movement: float

func enter():
    super()  # Calls the enter function as defined in the State class
    animations.play("wallSlide")  # Play the wall slide animation
    parent.isTouchingWall = true  # Set wall touching flag to true

func physics(delta: float):
    
    # Get movement input and calculate movement force
    movement = getXInput() * parent.speed
    
    # Apply movement force to player velocity (only X axis)
    parent.velocity.x = movement
    
    # Apply gravity
    parent.velocity.y += parent.gm.gravity * delta
    
    # Move the player
    parent.move_and_slide()
    
    #below block checks wall side and moves player toward the wall in the hopes that they continue colliding so they can continue sliding
    for i in parent.get_slide_collision_count():
        var collision = parent.get_slide_collision(i)
        var normal = collision.get_normal()
        if normal.x < 0:  # Wall on the right
            parent.velocity.x += 10
        elif normal.x > 0:  # Wall on the left
            parent.velocity.x -= 10

    if parent.velocity.y > 0 and parent.is_on_wall():
        parent.velocity.y = parent.wallSlideSpeed
    else:
        parent.velocity.y += parent.gm.gravity * delta
    pass
    
    if !parent.is_on_wall():
        return fall
    
    return null

func input(event: InputEvent):
    # Transition to WallJump state if the player presses the jump button
    if parent.moveInput.wantsToStartJump():  # Removed the wallJumpsRemaining check
        return wallJump
    
    return null
