class_name Head extends CharacterBody2D

@export var is_fall : bool = false
@export var count_head : CountHead
@export var start_pos : Vector2
@export var stop_shake : bool = false
@export var lived_rotation : float = -14.0
func _ready():
    Signals.failure.connect(failure)
    start_pos = global_position

func fall():
    if is_fall:
        return
    is_fall = true
    velocity.y = -200 + randf() * -200
    velocity.x = 200 * randf() - 200
    
func init_from_target(target : Target):
    count_head.init_from_target(target)
    
func _physics_process(delta):
    if !is_fall && !stop_shake:
        global_position = start_pos + Vector2(5 * randf(), 5 * randf())
    
    if !is_fall:
        return

    count_head.rotate(-3 * delta)
    velocity += get_gravity() * delta

    move_and_slide()

func failure():
    stop_shake = true
    var tween : Tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "rotation_degrees", lived_rotation, 0.2)
