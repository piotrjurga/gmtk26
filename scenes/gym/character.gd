class_name GymCharacter extends CharacterBody2D

@export var area : Area2D
@export var sprite : Sprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -800.0

var start_position : Vector2
var jump_intent : bool

var got_hit : bool = false
var enabled : bool = true

func _ready():
    start_position = global_position
    area.area_entered.connect(hit)

func _physics_process(delta):
    if got_hit:
        process_hit(delta)
        return
    if not is_on_floor():
        var strength : float = 3 if jump_intent else 6
        velocity += get_gravity() * strength * delta

    
    if enabled and jump_intent and is_on_floor():
        velocity.y = JUMP_VELOCITY

    move_and_slide()

func process_hit(delta):
    if !enabled:
        return
    sprite.rotate(-20 * delta)
    velocity += get_gravity() * 6 * delta
    velocity.x = -500
    move_and_slide()
    

func _input(event):
    if Input.is_action_just_pressed("space"):
        jump_intent = true
    if Input.is_action_just_released("space"):
        jump_intent = false

func hit(_area : Area2D):
    if !enabled:
        return
    got_hit = true
    velocity.y = JUMP_VELOCITY
    collision_layer = 0
    collision_mask = 0
    Signals.player_hit.emit()
    
    
