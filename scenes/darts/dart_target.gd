class_name DartTarget extends Node2D

@export var dart_image : Sprite2D 
@export var name_label : Label 
@export var gold_label : Label
@export var count_head : CountHead
@export var top : Node2D
@export var bot : Node2D

var target : Target 

func init_from_target(new_target : Target):
    target = new_target
    name_label.text = target.name
    gold_label.text = "GOLD: " + str(target.gold)
    count_head.set_cutoff(top.global_position, bot.global_position)
    count_head.init_from_target(target)
