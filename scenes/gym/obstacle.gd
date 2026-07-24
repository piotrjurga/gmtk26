extends Node2D

const SPEED : float = 1600.0

var stopped : bool = false
@export var can_be_stopped : bool = true

func _ready():
    if can_be_stopped:
        Signals.last_tick.connect(stop)
        Signals.player_hit.connect(stop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if stopped:
        return
    global_position.x -= SPEED * delta
    
func stop():
    stopped = true
