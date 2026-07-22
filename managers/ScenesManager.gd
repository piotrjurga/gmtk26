extends Node

var town : PackedScene = preload("res://scenes/town.tscn")
var tavern : PackedScene = preload("res://scenes/tavern.tscn")

var current_scene : Node2D

func _ready():
    Signals.tick.connect(pick_new_scene)
    
func pick_new_scene(current_tick):
    if current_scene == null:
        change_scene(town)
        return
        
    if current_tick == 1:
        if current_scene.name.to_lower() == 'town':
            change_scene(tavern)
        else:
            change_scene(town)
            

func change_scene(new_scene : PackedScene):
    if current_scene:
        current_scene.queue_free()
    current_scene = new_scene.instantiate()
    
    get_tree().root.add_child(current_scene)
