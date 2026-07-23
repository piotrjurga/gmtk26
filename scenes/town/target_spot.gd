extends Node2D

var target_scene : PackedScene = preload("res://scenes/darts/dart_target.tscn")

func _ready():
    var new_target : DartTarget = target_scene.instantiate()
    new_target.init_from_target(TargetManager.current_target)
    new_target.global_position = global_position
    add_child(new_target)
