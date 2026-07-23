extends CharacterBody2D

const speed = 150.0

func _physics_process(delta: float) -> void:
    velocity = transform.x * speed
    var c = move_and_collide(velocity * delta)
    if c:
        var col = c.get_collider()
        if col.has_method('hit'): col.hit()
        queue_free()
