class_name State
extends Node2D

@export
var animationName: String

var parent: CharacterBody2D
var animations: AnimatedSprite2D
var moveInput

#runs on state enter via a return
func enter():
    animations.play(animationName)
    pass 


#runs on state exit
func exit():
    pass 
 

#runs based on input in the _unhandledInput function through the State Machine
func input(event: InputEvent):
    return null #null by default so SM knows not to switch states
 

#runs every frame in the _process function through the State Machine
func update(delta):
    return null 


#runs every frame in the _physics_process function through the State Machine
func physics(delta):
    return null
    
#returns input values
func getXInput():
    return moveInput.getMovementDirection()
