extends Sprite2D

@export var target : Node2D
@export var new_scale : float = 1.0
var tween : Tween

func _ready():
    Signals.success.connect(success)
    visible = false
    scale = Vector2.ZERO
    
func success():
    visible = true
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "scale", Vector2(new_scale, new_scale), 0.15)
    tween.tween_property(self, "scale", Vector2(new_scale - 0.1, new_scale - 0.1), 0.1).set_delay(0.05)
    tween.tween_property(self, "scale", Vector2(new_scale, new_scale), 0.3).set_delay(0.05)
