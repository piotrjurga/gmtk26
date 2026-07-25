extends Node2D

const SPEED = 300.0
var window_size = Vector2(1920, 1080)

func _ready():
    #window_size = get_window().size
    pass

func get_minion_centroid(minions) -> Vector2:
    return minions.reduce(
        func(a, b): return a+b.position,
        Vector2.ZERO
    ) / minions.size()

func _physics_process(delta: float) -> void:
    var minions = get_tree().get_nodes_in_group('minions')
    var centroid = get_minion_centroid(minions)

    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    var dir = Vector2(direction_x, direction_y).normalized()
    #var len = 3 * minions.reduce(func(v, m): \
    #        return max(v, (m.position-centroid).dot(dir)), 0)
    var len = 30000.0

    if dir:
        position = centroid + len*dir
    else:
        position = centroid
