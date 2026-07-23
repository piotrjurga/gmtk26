extends CharacterBody2D

var speed = 100.0
var minions : Array[Node2D]
var projectile : PackedScene = preload('res://scenes/bullet-hell/enemies/projectile.tscn')

var shot_delay = 0.5
var shot_timer = 0.0
var attacking = true

func stop_attack(_success: bool):
    attacking = false

func _ready():
    Signals.scene_done.connect(stop_attack)

func _physics_process(delta):
    if !attacking: return
    shot_timer += delta
    if shot_timer > shot_delay:
        shot_timer = 0.0
        var p = projectile.instantiate()
        var targets = get_tree().get_nodes_in_group('minions')
        var target = targets.pick_random()
        var t_pos = target.global_position
        p.transform = transform.looking_at(t_pos)
        add_sibling(p)
