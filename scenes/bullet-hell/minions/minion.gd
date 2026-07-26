extends CharacterBody2D

var fork_projectile = preload('res://scenes/bullet-hell/minions/fork_projectile.tscn')
var speed = 400.0
var target: Node2D
@onready var hurtbox: Area2D = $Hurtbox
@onready var attack_range: Area2D = $AttackRange
var count: Node2D

var dead = false
var timer = 0.0
var id = -1
var armour = false
var fork = false

@export var armour_drop_sound : AudioStreamPlayer

func throw_fork():
    if !fork: return
    fork = false
    StatsManager.drop_fork(id)
    $Sprites/Animation/Pitchfork.visible = false
    var p = fork_projectile.instantiate()
    var t_pos = count.find_child('Hurtbox').global_position
    var throw_offset = $Sprites/ThrowMarker.global_position - global_position
    var t = transform.translated(throw_offset)
    p.transform = t.looking_at(t_pos)
    add_sibling(p)

func set_stats(stats):
    id = stats.id
    armour = stats.armour
    fork = stats.fork
    speed *= stats.speed
    if armour:
        $Sprites/Animation/Armour.visible = true
    if fork:
        $Sprites/Animation/Pitchfork.visible = true

func die():
    if !dead:
        $Feet.set_deferred('disabled', true)
        timer = 0.0
        dead = true
        remove_from_group('minions')
        Signals.minion_died.emit(id)
        $Animation.stop()

func drop_armour():
    armour_drop_sound.play()
    armour = false
    $Sprites/Animation/Armour.visible = false
    StatsManager.drop_armour(id)
    
    var armour_on_floor : Node2D = $Sprites/Animation/Armour.duplicate()
    armour_on_floor.visible = true
    self.get_parent().add_child(armour_on_floor)
    armour_on_floor.global_position = $Sprites/Animation/Armour.global_position
    armour_on_floor.scale = Vector2(0.7, 0.7)
    armour_on_floor.rotation_degrees = -45


func get_hit(area: Area2D):
    area.destroy()
    if armour:
        drop_armour()
    else:
        die()

func attack(area: Area2D):
    var p = area.get_parent()
    if p.has_method('get_hit'):
        p.get_hit()

func _ready():
    hurtbox.area_entered.connect(get_hit)
    attack_range.area_entered.connect(attack)

func get_minion_centroid(minions) -> Vector2:
    return minions.reduce(
        func(a, b): return a+b.position,
        Vector2.ZERO
    ) / minions.size()

func follow_target():
    var minions = get_tree().get_nodes_in_group('minions')
    var centroid = get_minion_centroid(minions)

    var t_pos = target.global_position
    if t_pos == Vector2.ZERO:
        t_pos = global_position
    var delta = t_pos - global_position

    var dest_is_center = (centroid - t_pos).length() < 10.0
    var close_enough = delta.length() < 40.0 * sqrt(minions.size())
    if dest_is_center and close_enough:
        velocity = Vector2.ZERO
    else:
        velocity = delta.normalized() * speed

    if velocity.x < 0: $Sprites.scale.x = -1
    else: $Sprites.scale.x = 1

    if velocity.length() > 1e-3:
        $Animation.play('walk')
    else:
        $Animation.stop()

    move_and_slide()

func die_anim():
    const death_time = 0.4
    rotation = min(timer * PI*0.5 / death_time, PI*0.5)

func _physics_process(delta):
    timer += delta
    if dead:
        die_anim()
    else:
        follow_target()
