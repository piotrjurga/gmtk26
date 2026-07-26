extends Sprite2D


var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
    move_rignt()


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
