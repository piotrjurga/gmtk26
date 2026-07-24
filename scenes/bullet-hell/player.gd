extends Node2D

const SPEED = 300.0
var window_size: Vector2

func _ready():
    window_size = get_window().size

func get_minion_centroid(minions) -> Vector2:
    var centroid = Vector2.ZERO
    var count = 0
    for m in minions:
        centroid += m.position
        count += 1
    centroid /= count
    return centroid

func _physics_process(delta: float) -> void:
    var minions = get_tree().get_nodes_in_group('minions')
    var centroid = get_minion_centroid(minions)

    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    var dir = Vector2(direction_x, direction_y).normalized()
    var len = dir.dot

    if dir:
        position = centroid + 300.0*dir
    else:
        position = centroid
