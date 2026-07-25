extends CharacterBody2D

var speed = 300.0
var projectile : PackedScene = preload('res://scenes/bullet-hell/enemies/projectile.tscn')
@onready var weapon = $Weapon

enum State { ATTACK, WALK, CHEER, DIE }
var state = State.ATTACK

const max_walk_time = 3.0
var shot_delay = 1.0
var shot_count = 0


var cheer_freq = 1.0
var cheer_init_pos: Vector2
var timer = 0.0

var target = Vector2.ZERO

func cheer():
    if state != State.DIE and state != State.CHEER:
        state = State.CHEER
        timer = -randf()
        cheer_init_pos = position
        cheer_freq = 1.0 + 0.2*randf()

func die():
    if state != State.DIE:
        $Feet.set_deferred('disabled', true)
        Signals.enemy_died.emit()
        state = State.DIE
        timer = 0.0

func get_hit():
    die()

func scene_done(success: bool):
    if success: die()
    else: cheer()

func _ready():
    Signals.scene_done.connect(scene_done)
    timer = randf()

func rand_in_circle():
    var a = randf() * TAU
    return sqrt(randf()) * Vector2(cos(a), sin(a))

func select_target():
    const r = 300.0
    target = position + r*rand_in_circle()

func shoot():
    if timer > shot_delay:
        shot_count += 1
        timer = 0.0
        var p = projectile.instantiate()
        var targets = get_tree().get_nodes_in_group('minions')
        if !targets.is_empty():
            var target = targets.pick_random()
            var t_pos = target.find_child('Hurtbox').global_position
            var t = transform.translated(weapon.position)
            p.transform = t.looking_at(t_pos)
            add_sibling(p)
        if shot_count == 3:
            shot_count = 0
            state = State.WALK
            select_target()

func walk():
    if !target: select_target()
    var delta = target - position
    if delta.length() < 10.0 or timer > max_walk_time:
        state = State.ATTACK
        timer = 0.0
        return
    velocity = delta.normalized() * speed
    move_and_slide()

func cheer_anim():
    var t = max(0.0, timer) # for random initial delay
    var offset = min(0.0, sin(timer*2*PI * cheer_freq)) * 20.0
    position.y = cheer_init_pos.y + offset

func die_anim():
    const death_time = 0.4
    rotation = min(timer * PI*0.5 / death_time, PI*0.5)

func _physics_process(delta: float):
    timer += delta
    match state:
        State.ATTACK:
            shoot()
        State.WALK:
            walk()
        State.CHEER:
            cheer_anim()
        State.DIE:
            die_anim()
