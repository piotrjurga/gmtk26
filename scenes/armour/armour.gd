extends Scene

@export var armour_good : Sprite2D
@export var armour_bad : Sprite2D
@export var score_points_root : Node2D
@export var click_size : float = 50
@export var hammer_icon : Sprite2D
@export var hammer_rotation_free : float
@export var hammer_rotation_hit : float

# points for shader
var clicked_points : Array[Vector3]

# points for scoring
var score_points : Array[Node]
var max_points_count : int

var block_clicking : bool = false

var is_success : bool = false
var starting_scale : Vector2

func _ready():
    super._ready()
    clicked_points = []
    armour_bad.material.set("shader_parameter/points", clicked_points)
    
    score_points = score_points_root.get_children()
    max_points_count = score_points.size()
    starting_scale = armour_good.scale
    
func _input(event):
    if event is InputEventMouseMotion:
        hammer_icon.global_position = event.position + Vector2(50, 0)
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.is_pressed():
            hammer_icon.rotation_degrees = hammer_rotation_hit
            self.on_click(event.position)
        if event.is_released():
            hammer_icon.rotation_degrees = hammer_rotation_free
            

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

    if (float(score_points.size()) / float(max_points_count)) < 0.3:
        is_success = true
        print(is_success)
