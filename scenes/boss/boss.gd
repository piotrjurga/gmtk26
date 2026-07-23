extends Scene

var last_tick_count : int = 0
var max_last_tick_count : int = 2

func tick(current_tick : int):
    if self != ScenesManager.current_scene:
        return
    if current_tick == 1:
        last_tick_count += 1
    
    if last_tick_count == max_last_tick_count:
        Signals.scene_ended.emit()
    else:
        progress -= 100.0 / 7
        Signals.progress_bar_set.emit(progress)
