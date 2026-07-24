extends Scene

var window_size : Vector2
var enemy : PackedScene = preload("res://scenes/bullet-hell/enemies/enemy.tscn")
var minion : PackedScene = preload("res://scenes/bullet-hell/minions/minion.tscn")
var player : PackedScene = preload("res://scenes/bullet-hell/player.tscn")

var minion_count: int
var last_tick_count : int = 0
var max_last_tick_count : int = 2

func minion_lost():
    minion_count -= 1
    if minion_count == 0:
        Signals.scene_done.emit(false)

func next_scene() -> PackedScene:
    if minion_count >= 1:
        return ScenesManager.guillotine
    return ScenesManager.town

func setup(enemy_count: int, minion_count_: int):
    minion_count = minion_count_
    var p = player.instantiate()
    p.position = Vector2(window_size.x*0.5, window_size.y*0.8)
    add_child(p)

    var radius = 50.0 * minion_count
    var angle_delta = 2*PI / minion_count
    for i in range(minion_count):
        var m = minion.instantiate()
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
    setup(3, 5)
    Signals.minion_died.connect(minion_lost)

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
