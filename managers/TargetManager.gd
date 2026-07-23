extends Node

var targets : Array[Target]
var current_target : Target
var dead_targets : Array[Target]

func _ready():
    for file_name in DirAccess.get_files_at("res://targets/Targets/"):
        targets.append(ResourceLoader.load("res://targets/Targets/"+file_name))
    Signals.target_dead.connect(dead_target)
    
func has_target() -> bool:
    return current_target is Target
    
func set_target(new_target : Target):
    current_target = new_target

    
func dead_target(dead_target : Target):
    targets.erase(dead_target)
    print(targets)
    current_target = null
