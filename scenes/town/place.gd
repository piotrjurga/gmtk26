class_name TownPlace extends Sprite2D

enum Places {Tavern, Gym, Swords, Armour, Street}

@export var place : Places
@export var area : Area2D

func _ready():
    area.body_entered.connect(pick_place)

func pick_place(body : Node2D):
    Signals.place_picked.emit(place)
