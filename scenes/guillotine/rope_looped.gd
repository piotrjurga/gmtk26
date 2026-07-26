extends Sprite2D

@export var blade : Node2D
var blade_start_pos : Vector2
var rope_start_pos : Vector2
var tween : Tween
var ended : bool = false

func _ready():
    blade_start_pos = blade.global_position
    rope_start_pos = global_position
    Signals.failure.connect(failure)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if ended:
        return
    global_position = rope_start_pos + (blade_start_pos - blade.global_position)

func failure():
    ended = true
    var tween : Tween = create_tween()
    tween.tween_property(self, "global_position", Vector2(global_position.x - 400, global_position.y), 0.5)
