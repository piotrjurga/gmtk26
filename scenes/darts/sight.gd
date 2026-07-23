class_name Sight extends CharacterBody2D

const SPEED = 500.0

var enabled : bool = true

func _physics_process(delta):
    if !enabled:
        return
    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    if direction_x:
        velocity.x = move_toward(velocity.x, direction_x * SPEED, delta * SPEED / 2)
    else:
        velocity.x = move_toward(velocity.x, 0, delta * SPEED / 2)
    if direction_y:
        velocity.y = move_toward(velocity.y, direction_y * SPEED, delta * SPEED / 2)
    else:
        velocity.y = move_toward(velocity.y, 0, delta * SPEED / 2)

    move_and_slide()
