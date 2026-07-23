extends Sprite2D

@export var cutof_point : Node2D

func _ready():
    material.set("shader_parameter/rope_top_cutoff", cutof_point.global_position.y)
