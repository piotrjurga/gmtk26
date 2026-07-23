extends Scene

@export var sight : Sight
@export var dart : DartThrow
@export var target_positions_root : Node2D
var target_positions : Array[Node]
var targets : Array[Node2D]
var min_distance : float = 100
var target_scene : PackedScene = preload("res://scenes/darts/dart_target.tscn")

func _ready():
    super._ready()
    target_positions = target_positions_root.get_children()
    target_positions.shuffle()
    print(TargetManager.targets)
    for target : Target in TargetManager.targets:
        var new_target : DartTarget = target_scene.instantiate()
        new_target.init_from_target(target)
        targets.append(new_target)
        new_target.global_position = target_positions.pop_front().global_position
        target_positions_root.add_child(new_target)
        
func last_tick():
    var closest_target : Node2D = null
    var distance_to_target : float
    var current_distance : float
    for target in targets:
        current_distance = sight.global_position.distance_to(target.global_position)
        if current_distance > min_distance:
            continue
        
        if closest_target == null || distance_to_target > current_distance:
            closest_target = target
            distance_to_target = current_distance
        
    if closest_target == null:
        closest_target = targets.pick_random()
        
    dart.set_target(closest_target.global_position)
    TargetManager.set_target(closest_target.target)
    
    sight.enabled = false
    
