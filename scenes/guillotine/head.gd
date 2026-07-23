extends CharacterBody2D

@export var fall : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if !fall:
        return

    rotate(-3 * delta)
    
    
    
