extends Scene

@export var timer : Timer
@export var obstacles : Array[PackedScene]
@export var main_spawn_point : Node2D
@export var init_spawn_point_a : Node2D
@export var gym_character : GymCharacter


func _ready():
    super._ready()
    timer.timeout.connect(spawn.bind(main_spawn_point.global_position))
    spawn(main_spawn_point.global_position)
    spawn(init_spawn_point_a.global_position)

func spawn(pos : Vector2):
    if !gym_character.enabled || gym_character.got_hit:
        return
    var obstacle_scene : PackedScene = obstacles.pick_random()
    var obstacle : Node2D = obstacle_scene.instantiate()
    main_spawn_point.add_child(obstacle)
    obstacle.global_position = pos
    
func last_tick():
    gym_character.enabled = false
    if gym_character.got_hit:
        print('failed')
    else:
        StatsManager.get_speed()
        print('success')
