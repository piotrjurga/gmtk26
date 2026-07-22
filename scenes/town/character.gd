extends CharacterBody2D

@export var places : Array[TownPlace]

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var enabled : bool = true
var target : Vector2

func _ready():
    Signals.last_tick.connect(last_tick)

func last_tick():
    enabled = false
    collision_layer = 0
    collision_mask = 0
    var picked_place : TownPlace.Places = get_parent().picked_place
    
    if picked_place == TownPlace.Places.Street:
        target = Vector2.ZERO
    
    for place in places:
        if place.place == picked_place:
            target = place.global_position
            return
    target = Vector2.ZERO

func move_to_target():
    if target == Vector2.ZERO:
        return
    var dir = (target - global_position).normalized()    
    
    velocity = dir * SPEED * 2
    move_and_slide()

func _physics_process(delta):
    if not enabled:
        move_to_target()
        return
    var direction_x = Input.get_axis("left", "right")
    var direction_y = Input.get_axis("up", "down")
    if direction_x:
        velocity.x = direction_x * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    if direction_y:
        velocity.y = direction_y * SPEED
    else:
        velocity.y = move_toward(velocity.y, 0, SPEED)

    move_and_slide()
