extends Sprite2D

var init_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    init_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    var t = Time.get_ticks_msec()
    position.x = init_pos.x + 20*sin(t * 4e-3 * PI)
    position.y = init_pos.y + 20*cos(t * 3e-3 * PI)
