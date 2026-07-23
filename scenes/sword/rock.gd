extends Node2D

@export var point_a : Node2D
@export var point_b : Node2D
@export var point_off_camera : Node2D
var target : Node2D
var max_distance : float

enum Modes {Swing, Hit}
var mode : Modes = Modes.Swing

var tween : Tween

func _ready():
    target = point_b
    max_distance = point_a.global_position.distance_to(point_b.global_position)
    Signals.last_tick.connect(last_tick)

func _physics_process(delta):
    if mode == Modes.Swing:
        swing(delta)

func swing(delta):
    if target.global_position.distance_to(global_position) < 20 && target != point_off_camera:
        target = point_a if target == point_b else point_b
        tween.kill()
        tween = null
        
    if tween:
        return

    var distance : float = target.global_position.distance_to(global_position)
    var target_pos : Vector2 = target.global_position
    
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "global_position", target_pos, distance / max_distance * 1.0)

func hit():
    mode = Modes.Hit
    if tween:
        tween.kill()
        tween = null
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "global_position", global_position + Vector2(0, -400), 0.05)
    tween.tween_property(self, "global_position", global_position, 0.1)
    tween.tween_callback(set_swing)
    
func _input(event):
    if target == point_off_camera:
        return
    if mode != Modes.Swing:
        return
    if !Input.is_action_just_pressed("space"):
        return
    hit()
    
func set_swing():
    mode = Modes.Swing
    if tween:
        tween.kill()
        tween = null

func last_tick():
    set_swing()
    target = point_off_camera
