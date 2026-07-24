class_name CountHead extends Node2D

@export var target : Target

@export var eyes : Node2D
@export var mouth : Node2D
@export var neck : Node2D
@export var nose : Node2D
@export var wig : Node2D

@export var top : Vector2
@export var bot : Vector2
@export var left : Vector2
@export var right : Vector2

@export var shader : ShaderMaterial
@export var has_neck : bool = true
@export var neck_background : Sprite2D
@export var colors : bool = false

func _ready():
    neck_background.visible = has_neck
        

func init_from_target(_target : Target):
    target = _target
    
    handle_part_visibility(eyes, _target.eyes)
    handle_part_visibility(mouth, _target.mouth)
    handle_part_visibility(neck, _target.neck if ! has_neck else 99)
    handle_part_visibility(nose, _target.nose)
    handle_part_visibility(wig, _target.wig)

func handle_part_visibility(part : Node2D, index : int):
    var i : int = 0
    for child : Node in part.get_children():
        if child is Sprite2D:
            child.visible = index == i
            i += 1
            if child.visible:
                child.material = shader
                child.material.resource_local_to_scene = true
                child.material.set("shader_parameter/top_cutoff", top.y)
                child.material.set("shader_parameter/bot_cutoff", bot.y)
                child.material.set("shader_parameter/left_cutoff", left.x)
                child.material.set("shader_parameter/right_cutoff", right.x)


func set_cutoff(_top : Vector2, _bot : Vector2, _left : Vector2, _right : Vector2):
    top = _top
    bot = _bot
    left = _left
    right = _right
    
