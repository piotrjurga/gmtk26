extends Label

var start_pos : Vector2
@export var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
    text = str(StatsManager.army.size())
    
    start_pos = global_position
    Signals.missing_peasants.connect(missing_peasants)
    
func missing_peasants():
    timer.start()
    
func _physics_process(delta):
    if timer.is_stopped():
        global_position = start_pos
        return
    
    global_position = start_pos + Vector2(10 * randf(), 10 * randf())
    
