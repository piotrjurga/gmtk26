extends Scene

@export var armour_good : Sprite2D
@export var armour_bad : Sprite2D
@export var score_points_root : Node2D
@export var click_size : float = 70
@export var hammer_icon : Sprite2D
@export var hammer_rotation_free : float
@export var hammer_rotation_hit : float

@export var sight : Sight

# points for shader
var clicked_points : Array[Vector3]

# points for scoring
var score_points : Array[Node]
var max_points_count : int

var block_clicking : bool = false

var is_success : bool = false
var starting_scale : Vector2

var tween : Tween

func _ready():
    super._ready()
    clicked_points = []
    armour_bad.material.set("shader_parameter/points", clicked_points)
    
    score_points = score_points_root.get_children()
    max_points_count = score_points.size()
    starting_scale = armour_good.scale
    
    Signals.tick.connect(hit)

func hit(current_tick : int):
    on_click(sight.global_position)
    hammer_icon.rotation_degrees = hammer_rotation_hit
    if tween:
        tween.kill()
        tween = null
    
    tween = create_tween()
    tween.tween_property(hammer_icon, "rotation_degrees", 0.0, 0.2)


func on_click(mouse_pos : Vector2):
    if block_clicking:
        return
        
    var spot_size : float = ((click_size / 2) * randf()) + click_size
    clicked_points.append(Vector3(mouse_pos.x, mouse_pos.y, spot_size))
    armour_bad.material.set("shader_parameter/points", clicked_points)
    for score_point : Node2D in score_points:
        if ! is_instance_valid(score_point):
            continue
        if score_point.global_position.distance_to(mouse_pos) < spot_size:
            score_points.erase(score_point)
            score_point.queue_free()

func last_tick():
    block_clicking = true
    score_points = score_points_root.get_children()

    print((float(score_points.size()) / float(max_points_count)))
    if (float(score_points.size()) / float(max_points_count)) < 0.5:
        is_success = true
    
    if is_success:
        armour_bad.visible = false
        StatsManager.get_armour()
