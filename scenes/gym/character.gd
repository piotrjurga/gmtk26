class_name GymCharacter extends CharacterBody2D

@export var area : Area2D
@export var area_lower : Area2D
@export var sprite : AnimatedSprite2D
@export var jump_hold_force : float = 4
@export var jump_release_force : float = 8
@export var step : AudioStreamPlayer
@export var jump : AudioStreamPlayer
@export var slide : AudioStreamPlayer
const SPEED = 300.0
const JUMP_VELOCITY = -2000.0

var start_position : Vector2
var jump_intent : bool
var crouch_intent : bool

var got_hit : bool = false
var enabled : bool = true

func _ready():
    start_position = global_position
    area.area_entered.connect(hit)
    area_lower.area_entered.connect(hit)
    sprite.frame_changed.connect(frame_changed)
    sprite.animation_changed.connect(animation_changed)

func animation_changed():
    if sprite.animation != "slide" && slide.playing:
        slide.stop()
    if sprite.animation == "run":
        step.pitch_scale = 0.7 + randf() * 0.6
        step.play()
    
func frame_changed():
    if sprite.animation != "run":
        return
    step.pitch_scale = 0.7 + randf() * 0.6
    step.play()

func _physics_process(delta):
    if got_hit:
        process_hit(delta)
        return
    
    sprite.offset.y = 0
    if not is_on_floor():
        sprite.animation = "jump"
        var strength : float = jump_hold_force if jump_intent else jump_release_force
        velocity += get_gravity() * strength * delta
    else:
        if crouch_intent:
            area.monitoring = false
            sprite.animation = "slide"
            sprite.offset.y = 100
            if !slide.playing:
                slide.play()
        else:
            area.monitoring = true
            sprite.animation = "run"
        
    
    if enabled and jump_intent and is_on_floor():
        velocity.y = JUMP_VELOCITY
        jump.pitch_scale = 1 + randf() * 0.3
        jump.play()
#
    if !enabled && is_on_floor():
        sprite.animation = "slide"
        sprite.offset.y = 100
        slide.stop()
        
    move_and_slide()

func process_hit(delta):
    sprite.animation = "jump"
    if !enabled:
        return
    sprite.rotate(-20 * delta)
    velocity += get_gravity() * 6 * delta
    velocity.x = -500
    move_and_slide()
    

func _input(event):
    if Input.is_action_just_pressed("up") || Input.is_action_just_pressed("space"):
        jump_intent = true
    if !Input.is_action_pressed("up") && !Input.is_action_pressed("space"):
        jump_intent = false
        
    if Input.is_action_just_pressed("down"):
        crouch_intent = true
    if Input.is_action_just_released("down"):
        crouch_intent = false

func hit(_area : Area2D):
    if _area.get_parent() == self:
        return
    if !enabled || got_hit:
        return
    got_hit = true
    velocity.y = JUMP_VELOCITY
    collision_layer = 0
    collision_mask = 0
    Signals.player_hit.emit()
    
    
