extends CharacterBody2D

const speed = 200.0

var window_size = Vector2(1920, 1080)

var captured = false
var timer = 0.0

func get_hit():
    if !captured:
        $Animation.stop()
        captured = true
        timer = 0.0
        Signals.scene_done.emit(true)

func captured_anim():
    const death_time = 0.4
    rotation = min(timer * PI*0.5 / death_time, PI*0.5)

func _physics_process(delta: float) -> void:
    timer += delta
    if captured:
        captured_anim()
        return
    var minions = get_tree().get_nodes_in_group('minions')
    if minions.is_empty(): return
    var p = minions.reduce(func(a, b):
        var da = (a-position).length_squared()
        var db = (b.position-position).length_squared()
        if da < db: return a
        return b.position, 
        minions[0].position
    )
    if (p-position).length() < 300.0:
        $Animation.play('walk')
        velocity = (position - p).normalized() * speed
        if velocity.x > 0.0:
            $Sprites.scale.x = -1
        else:
            $Sprites.scale.x = 1
        move_and_slide()
    else:
        $Animation.stop()
