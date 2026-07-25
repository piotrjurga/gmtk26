extends Scene

@export var sight : Sight
@export var dart : DartThrow
@export var target_positions_root : Node2D
@export var king_position : Node2D
@export var king_appears_when_others_left : int = 4
var target_positions : Array[Node]
var targets : Array[Node2D]
var min_distance : float = 150
var target_scene : PackedScene = preload("res://scenes/darts/dart_target.tscn")
var last_tick_count : int = 0
var max_last_tick_count : int = 2

var locked : bool = true

func _ready():
    super._ready()
    target_positions = target_positions_root.get_children()
    var targets_temp = TargetManager.targets
    targets_temp.shuffle()

    if targets_temp.size() <= king_appears_when_others_left:
        var new_target : DartTarget = target_scene.instantiate()
        targets.append(new_target)
        new_target.global_position = king_position.global_position
        target_positions_root.add_child(new_target)
        new_target.init_from_target(TargetManager.king_target)
    var i : int = 0
    for target : Target in targets_temp:
        if target.spot == -1:
            target.spot = i
            i += 1
        var new_target : DartTarget = target_scene.instantiate()
        targets.append(new_target)
        new_target.global_position = target_positions[target.spot].global_position
        target_positions_root.add_child(new_target)
        new_target.init_from_target(target)
    Signals.unlock_scene_change.connect(unlock)
    
func unlock():
    locked = false
        
func _input(event):
    if ! sight.enabled:
        return
    if Input.is_action_just_pressed("space"):
        throw_target()
        
func last_tick():
    super.last_tick()
    if TargetManager.current_target != null:
        return
    if last_tick_count != max_last_tick_count - 1:
        return
    locked = false
    throw_target(true)

func throw_target(force : bool = false):
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
        
    if force && closest_target == null:
        for target in targets:
            if closest_target == null:
                closest_target = target
            elif closest_target.target.gold > target.target.gold:
                closest_target = target

    if closest_target == null:
        return
    dart.set_target(closest_target.global_position)
    TargetManager.set_target(closest_target.target)
    
    sight.enabled = false

func tick(current_tick : int):
    if self != ScenesManager.current_scene:
        return
    if current_tick == 1:
        last_tick_count += 1
        if !locked && TargetManager.current_target != null:
            Signals.scene_ended.emit()
            return
    
    
    if !locked && current_tick % 4 == 1 && TargetManager.current_target != null:
        Signals.scene_ended.emit()
        return
            
    
    if last_tick_count == max_last_tick_count:
        Signals.scene_ended.emit()
    else:
        progress -= 100.0 / 14
        Signals.progress_bar_set.emit(progress)


func next_scene() -> PackedScene:
    return ScenesManager.boss
