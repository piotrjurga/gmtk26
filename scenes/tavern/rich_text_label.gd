extends RichTextLabel

var pulse_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.tick.connect(pulse)
        
    Signals.success.connect(stop)
    Signals.failure.connect(stop)

func stop():
    Signals.tick.disconnect(pulse)

func pulse(tick_idx : int):
    if pulse_tween is Tween:
        pulse_tween.kill()
        pulse_tween = null
    pulse_tween = create_tween()
    pulse_tween.set_trans(Tween.TRANS_SINE)
    pulse_tween.set_ease(Tween.EASE_IN_OUT)
    scale = Vector2(1.05, 1.05)
    pulse_tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
    
