extends Node2D

@export var startState: State #defines the default state

var currentState : State

#Initializes the state machine by giving each child state a refernce to the 
#parent object it belongs to and enter the default starting state
func init(parent: CharacterBody2D, animations: AnimatedSprite2D, moveInput): 
    for child in get_children():
        child.parent = parent
        child.animations = animations
        child.moveInput = moveInput
    changeState(startState)


 #change to the new state by first calling any exit logic of active state
func changeState(newState: State):
    if currentState:
        currentState.exit()
    
    currentState = newState
    currentState.enter()


#pass through physics function for entity to call, handling state changes as 
#needed
func physics(delta: float): 
    var newState = currentState.physics(delta)
    if newState:
        changeState(newState)
  
      
#pass through input function for entity to call, handling state changes as 
#needed
func input(event: InputEvent): 
    var newState = currentState.input(event)
    if newState:
        changeState(newState)
 
       
#pass through frame update function for entity to call, handling state 
#changes as needed
func update(delta: float): 
    var newState = currentState.update(delta)
    if newState:
        changeState(newState)
    
