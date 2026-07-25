extends Sprite2D


@export var target : Node2D
var tween : Tween

func _ready():
    Signals.success.connect(success)
    visible = false
    scale = Vector2(1, 1)
    
    
func success():
    visible = true
    tween = create_tween()
    var new_scale = 2
    tween.tween_property(self, "scale", Vector2(new_scale, new_scale), 0.15)
    new_scale = new_scale - 0.25
    tween.tween_property(self, "scale", Vector2(new_scale, new_scale), 0.10).set_delay(0.15)
