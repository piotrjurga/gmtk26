extends AudioStreamPlayer

@export var timer : Timer


func _ready():
    timer.timeout.connect(play)
