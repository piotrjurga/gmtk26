extends CharacterBody2D

var speed = 200.0
var target: Node2D

func hit():
    Signals.minion_died.emit()
    queue_free()

func _physics_process(_delta):
    var t_pos = target.global_position
    var delta = t_pos - global_position
    if delta.length() < 40.0:
        velocity = Vector2.ZERO
    else:
        velocity = delta.normalized() * speed
    move_and_slide()
