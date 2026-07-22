extends Node

var town : PackedScene = preload("res://scenes/town/town.tscn")
var tavern : PackedScene = preload("res://scenes/tavern/tavern.tscn")
var sword : PackedScene = preload("res://scenes/sword/sword.tscn")
var armour : PackedScene = preload("res://scenes/armour/armour.tscn")
var gym : PackedScene = preload("res://scenes/gym/gym.tscn")
var boss : PackedScene = preload("res://scenes/boss/boss.tscn")

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
