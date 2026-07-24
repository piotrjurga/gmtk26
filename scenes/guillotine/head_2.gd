class_name Head extends CharacterBody2D

@export var is_fall : bool = false
@export var count_head : CountHead

func fall():
    if is_fall:
        return
    is_fall = true
    velocity.y = -200 + randf() * -200
    velocity.x = 200 * randf() - 200
    
    
    
func init_from_target(target : Target):
    count_head.init_from_target(target)
    
func _physics_process(delta):
    if !is_fall:
        return

    count_head.rotate(-3 * delta)
    velocity += get_gravity() * delta

    move_and_slide()
