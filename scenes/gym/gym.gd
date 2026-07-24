extends Scene

@export var timer : Timer
@export var obstacles : Array[PackedScene]
@export var main_spawn_point : Node2D
@export var gym_character : GymCharacter
@export var obstacles_count : int = 4


func _ready():
    super._ready()
    timer.timeout.connect(spawn.bind(main_spawn_point.global_position))
    spawn(main_spawn_point.global_position)

func spawn(pos : Vector2):
    if obstacles_count <= 0:
        return
    if !gym_character.enabled || gym_character.got_hit:
        return
    obstacles_count -= 1
    var obstacle_scene : PackedScene = obstacles.pick_random()
    var obstacle : Node2D = obstacle_scene.instantiate()
    main_spawn_point.add_child(obstacle)
    obstacle.global_position = pos
    
func last_tick():
    gym_character.enabled = false
    if gym_character.got_hit:
        Signals.failure.emit()
    else:
        StatsManager.get_speed()
        Signals.success.emit()
