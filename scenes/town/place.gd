class_name TownPlace extends Node2D

enum Places {Tavern, Gym, Swords, Armour, Street, Boss}

@export var place : Places
@export var area : Area2D
@export var sprite : Sprite2D
var is_picked : bool = false

func _ready():
    area.body_entered.connect(pick_place)
    Signals.place_picked.connect(place_picked)
    sprite.visible = false
    
func pick_place(body : Node2D):
    Signals.place_picked.emit(place)

func place_picked(new_place : TownPlace.Places):
    is_picked = new_place == place
    
func _physics_process(delta):
    if !is_picked:
        sprite.visible = false
        return
    
    sprite.visible = true
