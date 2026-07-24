extends Node

var town : PackedScene = preload("res://scenes/town/town.tscn")
var tavern : PackedScene = preload("res://scenes/tavern/tavern.tscn")
var sword : PackedScene = preload("res://scenes/sword/sword.tscn")
var armour : PackedScene = preload("res://scenes/armour/armour.tscn")
var gym : PackedScene = preload("res://scenes/gym/gym.tscn")
var boss : PackedScene = preload("res://scenes/bullet-hell/bullet-hell.tscn")
var darts : PackedScene = preload("res://scenes/darts/darts.tscn")
var guillotine : PackedScene = preload("res://scenes/guillotine/guillotine.tscn")

var current_scene : Scene

func _ready():
    Signals.scene_ended.connect(pick_new_scene)
    Signals.tick.connect(new_game)
    
func pick_new_scene():
    change_scene(current_scene.next_scene())

func change_scene(new_scene : PackedScene):
    Signals.progress_bar_set.emit(100.0)
    if current_scene:
        current_scene.queue_free()
    current_scene = new_scene.instantiate()
    
    get_tree().root.add_child(current_scene)

func new_game(current_tick : int):
    if current_scene == null:
        Signals.tick.disconnect(new_game)
        change_scene(darts)
