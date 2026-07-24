extends Sprite2D

@export var target : Node2D
var tween : Tween
func _ready():
    Signals.success.connect(success)
    visible = false
    
    
func success():
    visible = true
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "global_position", target.global_position, 0.1)
