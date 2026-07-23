extends Node2D

const speed = 150.0

func destroy():
    queue_free()

func _physics_process(delta: float) -> void:
    var velocity = transform.x * speed
    position += velocity * delta
