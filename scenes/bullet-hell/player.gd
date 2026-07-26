extends Node2D

var window_size = Vector2(1920, 1080)

func get_minion_centroid(minions) -> Vector2:
    return minions.reduce(
        func(a, b): return a+b.position,
        Vector2.ZERO
    ) / minions.size()

func throw_fork(minions):
    var fork_bearers = minions.filter(func(m): return m.fork)
    if !fork_bearers.is_empty():
        fork_bearers.pick_random().throw_fork()

func _physics_process(delta: float) -> void:
    var minions = get_tree().get_nodes_in_group('minions')
    var centroid = get_minion_centroid(minions)

    if Input.is_action_just_pressed("space"):
        throw_fork(minions)
    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    var dir = Vector2(direction_x, direction_y).normalized()
    #var len = 3 * minions.reduce(func(v, m): \
    #        return max(v, (m.position-centroid).dot(dir)), 0)
    var len = 30000.0

    if dir:
        position = centroid + len*dir
    else:
        position = Vector2.ZERO
