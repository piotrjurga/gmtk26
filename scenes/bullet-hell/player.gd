extends CharacterBody2D

const SPEED = 300.0
var window_size: Vector2

func _ready():
    window_size = get_window().size

func _physics_process(delta: float) -> void:
    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    if direction_x:
        velocity.x = direction_x * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    if direction_y:
        velocity.y = direction_y * SPEED
    else:
        velocity.y = move_toward(velocity.y, 0, SPEED)

    move_and_slide()
    position = position.clamp(Vector2.ZERO, window_size)
