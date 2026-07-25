extends TextureProgressBar

func _ready():
    Signals.progress_bar_set.connect(progress_bar_set)
    Signals.progress_bar_set_visibility.connect(progress_bar_set_visibility)


func progress_bar_set(new_value : float):
    value = new_value
    
func progress_bar_set_visibility(new_value : float):
    visible = new_value
