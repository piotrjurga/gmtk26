extends Scene

var window_size : Vector2
var enemy : PackedScene = preload("res://scenes/bullet-hell/enemies/enemy.tscn")
var minion : PackedScene = preload("res://scenes/bullet-hell/minions/minion.tscn")
var player : PackedScene = preload("res://scenes/bullet-hell/player.tscn")

var enemy_count: int
var last_tick_count : int = 0
var max_last_tick_count : int = 2

func minion_down(_id):
    if StatsManager.army.is_empty():
        Signals.scene_done.emit(false)

func enemy_down():
    enemy_count -= 1
    if enemy_count == 0:
        Signals.scene_done.emit(true)

func next_scene() -> PackedScene:
    if StatsManager.army.is_empty():
        return ScenesManager.town # TODO(piotr): game over
    return ScenesManager.guillotine

func setup(enemy_count_: int):
    enemy_count = enemy_count_
    var p = player.instantiate()
    p.position = Vector2(window_size.x*0.5, window_size.y*0.8)
    add_child(p)

    var minion_count = StatsManager.army.size()
    var radius = 30.0 * minion_count
    var angle_delta = 2*PI / minion_count
    for i in range(StatsManager.army.size()):
        var m = minion.instantiate()

        var stats = StatsManager.army[i]
        if stats.fork:
            pass # TODO
        if stats.armor:
            pass # TODO
        m.speed *= stats.speed
        m.id = stats.id

        # TODO(piotr): hex grid? triangle?
        var angle = i * angle_delta
        var offset = radius * Vector2(cos(angle), sin(angle))
        m.position = p.position + offset
        m.target = p
        add_child(m)

    var pos_delta = window_size.x / (enemy_count+1.0)
    var pos_bias = -0.5*enemy_count + 0.5
    for i in range(enemy_count):
        var e = enemy.instantiate()
        var offset = (i+pos_bias) * pos_delta
        var x = window_size.x*0.5 + offset
        e.position = Vector2(x, window_size.y*0.1)
        add_child(e)

func _ready():
    super._ready()
    window_size = get_window().size
    setup(5)
    Signals.minion_died.connect(minion_down)
    Signals.enemy_died.connect(enemy_down)

func clear():
    for c in get_children():
        c.queue_free()
        remove_child(c)
        
func tick(current_tick : int):
    if self != ScenesManager.current_scene:
        return
    if current_tick == 1:
        last_tick_count += 1
    
    if last_tick_count == max_last_tick_count:
        Signals.scene_ended.emit()
    else:
        progress -= 100.0 / 15
        Signals.progress_bar_set.emit(progress)
