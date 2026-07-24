class_name Sight extends CharacterBody2D

@export var SPEED = 800.0
@export var force = 2
@export var slowdown_force = 3

var enabled : bool = true

func _physics_process(delta):
    if !enabled:
        return
    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    var force_x = delta * SPEED * force
    var force_y = delta * SPEED * force
    
    if sign(direction_x) != sign(velocity.x):
        force_x = force_x * slowdown_force
    if sign(direction_x) != sign(velocity.x):
        force_y = force_y * slowdown_force
        
    velocity.x = move_toward(velocity.x, direction_x * SPEED, force_x)
    velocity.y = move_toward(velocity.y, direction_y * SPEED, force_y)

    move_and_slide()
