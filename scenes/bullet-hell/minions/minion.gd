extends CharacterBody2D

var speed = 200.0
var target: Node2D
@onready var hurtbox: Area2D = $Hurtbox
@onready var attack_range: Area2D = $AttackRange

var dead = false
var timer = 0.0
var id = -1

func die():
    if !dead:
        $Feet.set_deferred('disabled', true)
        timer = 0.0
        dead = true
        remove_from_group('minions')
        Signals.minion_died.emit(id)

func get_hit(area: Area2D):
    area.destroy()
    # TODO(piotr): armor
    die()

func attack(area: Area2D):
    var p = area.get_parent()
    if p.has_method('get_hit'):
        p.get_hit()

func _ready():
    hurtbox.area_entered.connect(get_hit)
    attack_range.area_entered.connect(attack)

func get_minion_distribution():
    var minions = get_tree().get_nodes_in_group('minions')
    var centroid = Vector2.ZERO
    var count = 0
    for m in minions:
        #if m.dead: continue
        centroid += m.position
        count += 1
    centroid /= count
    var variance = 0.0
    for m in minions:
        #if m.dead: continue
        variance += (m.position - centroid).length_squared()
    var std = sqrt(variance / count)
    return { 'centroid': centroid, 'std': std }

func follow_target():
    var dist = get_minion_distribution()
    var t_pos = target.global_position
    var delta = t_pos - global_position

    var dest_is_center = (dist.centroid - t_pos).length() < 10.0
    var close_enough = delta.length() < 60.0
    if dest_is_center and close_enough:
        velocity = Vector2.ZERO
    else:
        velocity = delta.normalized() * speed

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
