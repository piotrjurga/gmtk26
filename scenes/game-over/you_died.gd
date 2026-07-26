extends Label

var start_pos : Vector2

func _ready():
    start_pos = global_position


func _physics_process(delta):
    global_position = start_pos + Vector2(10 * randf(), 10 * randf())
    
