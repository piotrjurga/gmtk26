class_name Scene extends Node

@export var stream_idx : int = 0

var progress : float = 100.0

func _ready():
    Signals.set_stream.emit(stream_idx)
    Signals.tick.connect(tick)
    Signals.last_tick.connect(last_tick)

func tick(current_tick : int):
    if self != ScenesManager.current_scene:
        return
    if current_tick == 1:
        Signals.scene_ended.emit()
    else:
        progress -= 100.0 / 7 
        Signals.progress_bar_set.emit(progress)
    
func last_tick():
    pass
    
func next_scene() -> PackedScene:
    return ScenesManager.town
