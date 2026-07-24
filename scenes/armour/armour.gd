extends Scene

@export var armour_good : Sprite2D
@export var armour_bad : Sprite2D
@export var score_points_root : Node2D
@export var click_size : float = 90
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

@export var texture : Texture
@export var hit_sound : AudioStreamPlayer

func _ready():
    super._ready()
    clicked_points = []
    armour_bad.material.set("shader_parameter/points", clicked_points)
    
    score_points = score_points_root.get_children()
    max_points_count = score_points.size()
    starting_scale = armour_good.scale
    
    Signals.tick.connect(hit)
    hammer_icon.rotation_degrees = hammer_rotation_free
    
    # debug
    #for score_point in score_points:
        #var sprite = Sprite2D.new()
        #sprite.texture = texture
        #score_point.add_child(sprite)
        #sprite.global_position = score_point.global_position
        #sprite.scale = Vector2(0.2, 0.2)

func hit(current_tick : int):
    on_click(sight.global_position)
    hammer_icon.rotation_degrees = hammer_rotation_hit
    if tween:
        tween.kill()
        tween = null
    
    tween = create_tween()
    tween.tween_property(hammer_icon, "rotation_degrees", hammer_rotation_free, 0.2)


func on_click(pos : Vector2):
    if block_clicking:
        return
    hit_sound.pitch_scale = 0.7 + randf() * 0.6
    hit_sound.play()
    var spot_size : float = ((click_size / 2) * randf()) + click_size
    clicked_points.append(Vector3(pos.x, pos.y, spot_size))
    armour_bad.material.set("shader_parameter/points", clicked_points)
    var new_points :Array[Node] = []
    var points_to_delete :Array[Node2D] = []
    for score_point : Node2D in score_points:
        if score_point.global_position.distance_to(pos) <= spot_size:
            points_to_delete.append(score_point)
        else:
            new_points.append(score_point)
    score_points = new_points
    for point_to_delete in points_to_delete:
        point_to_delete.queue_free()

func last_tick():
    block_clicking = true

    if (float(score_points.size()) / float(max_points_count)) < 0.5:
        is_success = true
    
    if is_success:
        armour_bad.visible = false
        StatsManager.get_armour()
