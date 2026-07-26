extends Scene

var window_size = Vector2(1920, 1080)
var enemy : PackedScene = preload("res://scenes/bullet-hell/enemies/enemy.tscn")
var count : PackedScene = preload("res://scenes/bullet-hell/enemies/count.tscn")
var minion : PackedScene = preload("res://scenes/bullet-hell/minions/minion.tscn")
var player : PackedScene = preload("res://scenes/bullet-hell/player.tscn")

var enemy_count: int
var last_tick_count : int = 0
var max_last_tick_count : int = 2
var count_down = false

func scene_end(success: bool):
    count_down = success

func minion_down(_id):
    if StatsManager.army.is_empty():
        Signals.scene_done.emit(false)

func enemy_down():
    enemy_count -= 1

func next_scene() -> PackedScene:
    if count_down:
        return ScenesManager.guillotine
    if StatsManager.army.is_empty():
        TargetManager.current_target = null
        return ScenesManager.game_over
    TargetManager.current_target = null
    return ScenesManager.town

func fib_layout(n: int) -> Array[Vector2]:
    var result: Array[Vector2] = []
    var radius = 35.0 * sqrt(n)
    result.resize(n)
    const golden_angle = 2.399963229728653
    for i in range(n):
        var distance = radius * sqrt(float(i + 0.5) / float(n))
        var angle = i * golden_angle
        result[i] = Vector2(
            distance * cos(angle),
            distance * sin(angle)
        )
    return result

# generate a hex grid
func grid_layout(n: int) -> Array[Vector2]:
    const radius = 30.0
    var height = radius * sqrt(3.0)
    var rows = int(round(sqrt(float(n))))
    var cols = int(ceil(float(n) / rows))
    var result: Array[Vector2]
    for row in range(rows):
        var odd = row & 1
        var row_cols = min(cols + odd, n-result.size())
        var row_offset = -odd*radius
        var missing = cols+odd - row_cols
        if missing > 1:
            row_offset += float(missing / 2)
        for col in range(row_cols):
            var p = Vector2(col*2*radius + row_offset, height*row)
            result.push_back(p)
    # recenter the distribution
    var center = result.reduce(func(a,b): return a+b, Vector2.ZERO) / n
    for i in range(n):
        result[i] -= center
    return result

func rand_in_circle():
    var a = randf() * TAU
    return sqrt(randf()) * Vector2(cos(a), sin(a))

func setup(enemy_count_: int):
    enemy_count = enemy_count_
    var p = player.instantiate()
    p.position = Vector2(window_size.x*0.1, window_size.y*0.6)
    add_child(p)

    var c = count.instantiate()
    c.position = Vector2(window_size.x*0.9, window_size.y*0.6)
    add_child(c)

    var offsets = fib_layout(StatsManager.army.size())
    var minx = offsets.reduce(func(a,b): return min(a, b.x), 1e3)
    if minx+p.position.x < 50.0:
        for i in range(offsets.size()):
            offsets[i].x += 50.0 - (minx + p.position.x)

    for i in range(StatsManager.army.size()):
        var m = minion.instantiate()
        var stats = StatsManager.army[i]
        m.set_stats(stats)
        m.position = p.position + offsets[i]
        m.target = p
        m.count = c
        add_child(m)

    var pos_delta = window_size.y / (enemy_count+1)
    var pos_bias = -0.5*enemy_count + 0.5
    for i in range(enemy_count):
        var e = enemy.instantiate()
        var offset = (i+pos_bias) * pos_delta
        var y = window_size.y*0.5 + offset

        e.position = Vector2(window_size.x * 0.7, y)
        e.position += rand_in_circle() * 100.0
        add_child(e)

func _ready():
    super._ready()
    Signals.set_stream.emit(2)
    setup(TargetManager.current_target.gold)
    Signals.minion_died.connect(minion_down)
    Signals.enemy_died.connect(enemy_down)
    Signals.scene_done.connect(scene_end)

func clear():
    for c in get_children():
        c.queue_free()
        remove_child(c)
        
func tick(current_tick : int):
    if self != ScenesManager.current_scene:
        return
    if current_tick == 1:
        last_tick_count += 1
        Signals.set_stream.emit(3)
    
    if last_tick_count == max_last_tick_count:
        Signals.scene_ended.emit()
    else:
        progress -= 100.0 / 16
        Signals.progress_bar_set.emit(progress)
