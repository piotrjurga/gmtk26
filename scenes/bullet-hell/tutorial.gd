extends Label


@export var enable_pulse : bool = false
@export var enable_move : bool = true

var tween: Tween
var pulse_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
    if enable_move:
        move_rignt()
    if enable_pulse:
        Signals.tick.connect(pulse)
        Signals.success.connect(stop)
        Signals.failure.connect(stop)
        
    Signals.success.connect(success)

func stop():
    Signals.tick.disconnect(pulse)

func success():
    var hide_tween = create_tween()
    hide_tween.set_trans(Tween.TRANS_SINE)
    hide_tween.set_ease(Tween.EASE_IN_OUT)
    hide_tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.2)

func move_rignt():
    if tween is Tween:
        tween.kill()
        tween = null
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "global_position", global_position + Vector2(10, 0), 1)
    tween.tween_callback(move_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func move_left():
    if tween is Tween:
        tween.kill()
        tween = null
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "global_position", global_position + Vector2(-10, 0), 1)
    tween.tween_callback(move_rignt)

func pulse(tick_idx : int):
    if pulse_tween is Tween:
        pulse_tween.kill()
        pulse_tween = null
    pulse_tween = create_tween()
    pulse_tween.set_trans(Tween.TRANS_SINE)
    pulse_tween.set_ease(Tween.EASE_IN_OUT)
    scale = Vector2(1.2, 1.2)
    pulse_tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
    
