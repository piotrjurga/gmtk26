extends Scene

@export var sight : Sight
@export var dart : DartThrow
@export var targets : Array[Node2D]
var min_distance : float = 100

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
    
    sight.enabled = false
    
