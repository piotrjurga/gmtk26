extends Node2D

const SPEED = 300.0
var window_size: Vector2

func _ready():
    window_size = get_window().size

func get_minion_centroid() -> Vector2:
    var minions = get_tree().get_nodes_in_group('minions')
    var centroid = Vector2.ZERO
    var count = 0
    for m in minions:
        #if m.dead: continue
        centroid += m.position
        count += 1
    centroid /= count
    return centroid

func _physics_process(delta: float) -> void:
    var centroid = get_minion_centroid()

    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    var dir = Vector2(direction_x, direction_y)

    if dir:
        position = centroid + 300.0*dir.normalized()
    else:
        position = centroid
