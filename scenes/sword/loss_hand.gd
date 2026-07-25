extends Sprite2D

@export var rock : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.failure.connect(failure)
    visible = false


func failure():
    visible = true
    global_position.x = rock.global_position.x
