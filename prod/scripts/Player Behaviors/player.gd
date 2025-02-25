class_name Player
extends CharacterBody2D

@export_group("Basic Movement")
@export var speed: float = 125.0 # X axis speed
@export var jumpForce: float = 500.0 # Y axis speed
@export_group("Advance Movement")
@export_subgroup("Advance Y Movement")
@export var maxJumpTime: float = 0.2  # Maximum time jump button can be held
@export var jumpInputBufferTime: float = 0.1  # Time window for jump input buffering
@export var coyoteTime: float = 0.1  # Time window for coyote time
@export var ascentGravityScale: float = 0.5  # Gravity scale during jump ascent
@export var descentGravityScale: float = 1.5  # Gravity scale during jump descent
@export var wallSlideSpeed: float = 100.0  # Speed at which the player slides down a wall
@export var wallJumpForceY: float = 400.0  # Vertical force for wall jump
@export var wallJumpForceX: float = 600.0  # Horizontal force for wall jump
@onready 
var debugUi: Control = get_node("/root/Game/CanvasLayer/DebugUI") #sets debug UI ref 
@onready
var stateMachine = $stateMachine #SM Reference
@onready
var animations = $AnimatedSprite2D #animation reference
@onready
var moveInput = $moveInput #moveInput reference

var gm = gameManager
var facingDirection
var currentState
var jumpBufferTimer: float = 0.0  # Tracks time since jump input was pressed
var coyoteTimeTimer: float = 0.0  # Tracks time since player left the ground
var isJumping: bool = false  # Tracks if the player is currently jumping
var jumpButtonHoldTime: float = 0.0  # Tracks how long the jump button is held
var isTouchingWall: bool = false  # Tracks if the player is touching a wall
var wallDirection: int = 0  # Direction of the wall (-1 for left, 1 for right)


func _ready():
    #Initializes the state machine, passing a reference of the player to 
    #the states, that way they can move and react accordingly
    stateMachine.init(self, animations, moveInput) 
    currentState = "idle" #sets a base value for currentState debugger
    gm = get_parent() #assings gm ref value

func _unhandled_input(event: InputEvent):
    # Handle jump input for buffering (only on initial press)
    if moveInput.wantsToStartJump():
        jumpBufferTimer = jumpInputBufferTime
    # Allow child states to detect inputs    
    stateMachine.input(event)

func _physics_process(delta: float):
     # Allow child states to have a _physics_process
    stateMachine.physics(delta)
    
    # Update timers
    if jumpBufferTimer > 0:
        jumpBufferTimer -= delta
    if !is_on_floor():
        coyoteTimeTimer -= delta
    
    # Handle coyote time
    if is_on_floor():
        coyoteTimeTimer = coyoteTime
    
    # Detect walls
    detect_walls()
    
    # Manage player base gravity force
    if !is_on_floor():
        velocity.y += gm.gravity * delta  # Apply gravity
    
    move_and_slide()
    
    debugUi.updateDebugInfo(position, velocity, currentState)
    
    
func detect_walls():
    # Res # Reset wall touching flag
    isTouchingWall = false
    
    # Check for walls on the left and right
    if is_on_wall_only():
        isTouchingWall = true
        wallDirection = get_wall_normal().x  # Get the direction of the wall (-1 for left, 1 for right)

func _process(delta: float): #runs every frame
    # Allow child states to have a _process function
    stateMachine.update(delta)
    
    currentState = str(stateMachine.currentState)  # Set current state string for debug
    
    # Manage player X input for player flipping
    facingDirection = Input.get_axis("Move Left", "Move Right")
    if facingDirection != 0:
        transform.x.x = facingDirection
    
pass
