class_name DartTarget extends Node2D

@export var overlay : Sprite2D 
@export var dart_image : Sprite2D 
@export var name_label : Label 
@export var gold_label : Label
@export var count_head : CountHead
@export var top : Node2D
@export var bot : Node2D
@export var left : Node2D
@export var right : Node2D
@export var color_sir : Color
@export var color_lord : Color
@export var color_count : Color
@export var color_king : Color

var target : Target 

func init_from_target(new_target : Target):
    target = new_target
    name_label.text = target.full_name()
    gold_label.text = str(target.gold) + " g"
    count_head.set_cutoff(top.global_position, bot.global_position, left.global_position, right.global_position)
    count_head.init_from_target(target)
    match target.title:
        "Sir":
            overlay.modulate = color_sir
        "Lord":
            overlay.modulate = color_lord
        "Baron":
            overlay.modulate = color_count
        "Count":
            overlay.modulate = color_king
    
