extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.failure.connect(play)
