extends CharacterBody2D

@export var places : Array[TownPlace]

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
var enabled : bool = true
var target : Vector2
var tween : Tween 
var picked_place : TownPlace.Places = TownPlace.Places.Street

@onready var sprite = $Sprite2D
var crowd_one = load('res://assets/main_city/crowd_map_alone.png')
var crowd_small = load('res://assets/main_city/crowd_map_small.png')
var crowd_medium = load('res://assets/main_city/crowd_map_medium.png')
var crowd_big = load('res://assets/main_city/crowd_map_big.png')

func _ready():
    var n = StatsManager.army.size()
    if n < 2:
        sprite.texture = crowd_one
    elif n < 8:
        sprite.texture = crowd_small
    elif n < 20:
        sprite.texture = crowd_medium
    else:
        sprite.texture = crowd_big
    Signals.place_picked.connect(place_picked)
    Signals.tick.connect(tick)
    
func place_picked(new_place : TownPlace.Places):
    picked_place = new_place
    
    if picked_place == TownPlace.Places.Street:
        return
        
    enabled = false
    collision_layer = 0
    collision_mask = 0
    
    for place in places:
        if place.place == picked_place:
            target = place.global_position
            return
    target = Vector2.ZERO
    
func tick(current_tick : int):
    if picked_place == TownPlace.Places.Street:
        return
        
    if current_tick % 4 == 1:
        Signals.scene_ended.emit()
    
func move_to_target():
    if target == Vector2.ZERO:
        return
        
    if target.distance_to(global_position) < 90:
        global_position = target
        target = Vector2.ZERO
        tween = create_tween()
        tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
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
