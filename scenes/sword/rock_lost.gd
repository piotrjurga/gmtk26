extends Sprite2D

@export var rock : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.failure.connect(failure)
    visible = false

func _physics_process(delta):
    if visible:
        rotate(10 * delta)

func failure():
    visible = true
    global_position = rock.global_position
    var tween : Tween = create_tween()
    tween.tween_property(self, "global_position", global_position + Vector2(-500, 1600), 0.5)
