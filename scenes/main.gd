extends Node2D

@export var rythm_manager : RythmManager
var is_started :bool = false
func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(event):
    if !is_started && Input.is_action_just_pressed("space"):
        rythm_manager.start()
        is_started = true
        
