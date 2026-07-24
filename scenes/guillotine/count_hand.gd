extends Sprite2D

var start_pos : Vector2

var stop_shake : bool = false
@export var dead_rotation : float
@export var lived_rotation : float

func _ready():
    Signals.success.connect(dead)
    Signals.failure.connect(failure)
    start_pos = global_position


func _physics_process(delta):
    if stop_shake:
        global_position = start_pos
        return
    global_position = start_pos + Vector2(10 * randf(), 10 * randf())
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func dead():
    stop_shake = true
    var tween : Tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "rotation_degrees", dead_rotation, 0.2)

    
func failure():
    stop_shake = true
    var tween : Tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "rotation_degrees", lived_rotation, 0.2)
