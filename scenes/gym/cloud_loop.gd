extends Sprite2D

const SPEED : float = 100.0

var stopped : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if stopped:
        return
    global_position.x -= SPEED * delta
    
func stop():
    stopped = true
