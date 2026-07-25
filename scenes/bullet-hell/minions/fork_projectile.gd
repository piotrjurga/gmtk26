extends Area2D

const speed = 500.0

func hit(area: Area2D):
    var p = area.get_parent()
    if p.has_method('get_hit'):
        p.get_hit()
        queue_free()

func _ready():
    area_entered.connect(hit)

func _physics_process(delta: float) -> void:
    var velocity = transform.x * speed
    position += velocity * delta
