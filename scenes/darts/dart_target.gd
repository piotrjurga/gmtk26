class_name DartTarget extends Node2D

@export var dart_image : Sprite2D 
@export var name_label : Label 
@export var gold_label : Label
var target : Target 

# Called when the node enters the scene tree for the first time.
func init_from_target(new_target : Target):
    target = new_target
    dart_image.texture = target.texture
    name_label.text = target.name
    gold_label.text = "GOLD: " + str(target.gold)
    
