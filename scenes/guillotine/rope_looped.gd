extends Sprite2D

@export var blade : Node2D
var blade_start_pos : Vector2
var rope_start_pos : Vector2

func _ready():
    blade_start_pos = blade.global_position
    rope_start_pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    global_position = rope_start_pos + (blade_start_pos - blade.global_position)
