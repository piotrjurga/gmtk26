extends TextureProgressBar


func _ready():
    Signals.progress_bar_set.connect(progress_bar_set)


func progress_bar_set(new_value : float):
    value = new_value
