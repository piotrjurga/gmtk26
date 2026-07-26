class_name Scene extends Node2D

@export var stream_idx : int = 0

var progress : float = 100.0
@export var allow_end : bool = false

func _ready():
    Signals.set_stream.emit(stream_idx)
    Signals.tick.connect(tick)
    Signals.last_tick.connect(last_tick)
    Signals.progress_bar_set_visibility.emit(true)

func tick(current_tick : int):
    if self != ScenesManager.current_scene:
        return
    if current_tick == 1:
        if allow_end:
            Signals.scene_ended.emit()
            return
    else:
        progress -= 100.0 / 6
        Signals.progress_bar_set.emit(progress)
    
func last_tick():
    allow_end = true
    
func next_scene() -> PackedScene:
    return ScenesManager.town
