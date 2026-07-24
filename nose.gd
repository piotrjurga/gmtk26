class_name FacePart extends Node2D

@export var index : int
var sprites : Array[Sprite2D]

func _ready():
    for child in get_children():
        if child is Sprite2D:
            sprites.append(child)
    sprites[index].visible = true
