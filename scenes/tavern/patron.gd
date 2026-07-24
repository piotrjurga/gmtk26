extends Sprite2D

@export var target : Node2D
@export var delay : float = 0.1
var tween : Tween
func _ready():
    Signals.failure.connect(failure)
    
    
func failure():
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_IN)
    tween.tween_property(self, "global_position:y", global_position.y - 50, delay)
    tween.tween_property(self, "global_position:x", target.global_position.x, 0.3).set_delay(delay)
