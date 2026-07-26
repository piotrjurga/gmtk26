extends Area2D

const speed = 1000.0
@export var timer : Timer
@export var fall_sound : AudioStreamPlayer
var is_stopped : bool

func hit(area: Area2D):
    var p = area.get_parent()
    if p.has_method('get_hit'):
        p.get_hit()
        queue_free()

func _ready():
    area_entered.connect(hit)
    timer.timeout.connect(stop)

func _physics_process(delta: float) -> void:
    if is_stopped:
        return
    var velocity = transform.x * speed
    position += velocity * delta

func stop():
    fall_sound.pitch_scale = 0.9 + 0.2 * randf()
    fall_sound.play()
    is_stopped = true
