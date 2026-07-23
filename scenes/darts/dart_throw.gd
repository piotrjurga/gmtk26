class_name DartThrow extends CharacterBody2D


const SPEED = 1500.0

@export var target : Vector2 = Vector2.ZERO

func set_target(new_target : Vector2):
    target = new_target + Vector2(25 - randf() * 50, 25 - randf() * 50)
    look_at(target)

func _physics_process(delta):
    if target == Vector2.ZERO:
        return
    
    if global_position.distance_to(target) < 30:
        return
    
    var dir = (target - global_position).normalized()    
    
    velocity = dir * SPEED
    move_and_slide()
