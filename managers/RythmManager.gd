extends Node

@export var scene_timer : Timer
@export var pip_sound : AudioStreamPlayer
@export var pop_sound : AudioStreamPlayer
var max_ticks : int = 4
var current_tick : int = 0

func _ready():
    scene_timer.start()
    scene_timer.timeout.connect(tick)
    
func tick():
    current_tick += 1
    
    Signals.tick.emit(current_tick)
    
    
    if current_tick == max_ticks:
        current_tick = 0
        pop_sound.play()
        return
    
    pip_sound.play()
        
        
