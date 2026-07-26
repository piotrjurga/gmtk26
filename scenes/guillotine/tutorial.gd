extends Label

var start_pos : Vector2

func _ready():
    start_pos = global_position
    Signals.success.connect(queue_free)
    Signals.failure.connect(queue_free)


func _physics_process(delta):
    global_position = start_pos + Vector2(5 * randf(), 5 * randf())
    
