class_name DartThrow extends CharacterBody2D


const SPEED = 4500.0
@export var throw : AudioStreamPlayer
@export var hit : AudioStreamPlayer

@export var target : Vector2 = Vector2.ZERO
var tween : Tween

func set_target(new_target : Vector2):
    throw.play()
    target = new_target + Vector2(25 - randf() * 50, 25 - randf() * 50)
    look_at(target)
    var tween = create_tween()
    tween.tween_property(self, "global_position", target, 0.2)
    tween.tween_callback(target_hit)

func target_hit():
    hit.play()
