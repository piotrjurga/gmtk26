extends Sprite2D

const SPEED : float = 1600

var stopped : bool = false

func _ready():
    Signals.last_tick.connect(stop)
    Signals.player_hit.connect(stop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if stopped:
        return
    global_position.x -= SPEED * delta
    
func stop():
    stopped = true
