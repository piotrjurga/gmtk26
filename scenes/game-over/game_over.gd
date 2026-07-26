extends Scene

var is_started :bool = false

func _ready():
    super._ready()
    Signals.progress_bar_set_visibility.emit(false)
    Signals.title_screen.emit()

func _input(event):
    if Input.is_action_just_pressed("space"):
        back_to_title()

func back_to_title():
    ScenesManager.change_scene(ScenesManager.title_screen)
