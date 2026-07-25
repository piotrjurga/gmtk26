extends CharacterBody2D

const speed = 200.0

var window_size = Vector2(1920, 1080)

var captured = false

func get_hit():
    if !captured:
        captured = true
        Signals.scene_done.emit(true)

func _physics_process(_delta: float) -> void:
    if captured: return
    # TODO(piotr): captured anim
    var minions = get_tree().get_nodes_in_group('minions')
    var p = minions.reduce(func(a, b):
        var da = (a-position).length_squared()
        var db = (b.position-position).length_squared()
        if da < db: return a
        return b.position, 
        minions[0].position
    )
    if (p-position).length() < 300.0:
        velocity = (position - p).normalized() * speed
        move_and_slide()
