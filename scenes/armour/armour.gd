extends Scene

@export var armour_bad : Sprite2D
@export var score_points_root : Node2D
@export var click_size : float = 70

# points for shader
var clicked_points : Array[Vector2]

# points for scoring
var score_points : Array[Node]
var max_points_count : int

var block_clicking : bool = false

func _ready():
    super._ready()
    clicked_points = []
    armour_bad.material.set("shader_parameter/points", clicked_points)
    armour_bad.material.set("shader_parameter/click_size", click_size)
    score_points = score_points_root.get_children()
    max_points_count = score_points.size()
    Signals.last_tick.connect(last_tick)

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
        self.on_click(event.position)

func on_click(mouse_pos : Vector2):
    if block_clicking:
        return
    clicked_points.append(mouse_pos)
    armour_bad.material.set("shader_parameter/points", clicked_points)
    for score_point : Node2D in score_points:
        if ! is_instance_valid(score_point):
            continue
        if score_point.global_position.distance_to(mouse_pos) < click_size:
            score_points.erase(score_point)
            score_point.queue_free()


func last_tick():
    block_clicking = true
    score_points = score_points_root.get_children()

    print((float(score_points.size()) / float(max_points_count)))
    if (float(score_points.size()) / float(max_points_count)) < 0.3:
        print("good")
    else:
        print("baaad")
