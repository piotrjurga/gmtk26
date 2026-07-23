class_name Scene extends Node

var progress : float = 100.0

func _ready():
    Signals.tick.connect(tick)

func tick(current_tick : int):
    if self != ScenesManager.current_scene:
        return
    if current_tick == 1:
        Signals.scene_ended.emit()
    else:
        progress -= 100.0 / 3 
        Signals.progress_bar_set.emit(progress)
    
func next_scene() -> PackedScene:
    return ScenesManager.town
