extends Node

var army = []
var gold = 5
var day = 1

var current_army_id = 1

func army_count():
    return army.size()

func fork_count():
    var result = 0
    for a in army: result += int(a.fork)
    return result

func armour_count():
    var result = 0
    for a in army: result += int(a.armour)
    return result

func speed_count():
    var result = 0
    for a in army: result += int(a.speed > 1)
    return result

func add_minion(n = 1):
    for i in range(n):
        army.push_back({id=current_army_id, fork=false, armour=false, speed=1})
        current_army_id += 1

func get_fork():
    var unarmed_minions = army.filter(func(a): return !a.fork)
    if unarmed_minions.size() > 0:
        var m = unarmed_minions.pick_random()
        m.fork = true

func get_armour():
    var unarmed_minions = army.filter(func(a): return !a.armour)
    if unarmed_minions.size() > 0:
        var m = unarmed_minions.pick_random()
        m.armour = true

func get_speed():
    var slow_minions = army.filter(func(a): return a.speed == 1)
    if slow_minions.size() > 0:
        var m = slow_minions.pick_random()
        m.speed = 2

func find(id):
    return army.find_custom(func(a): return a.id == id)

func remove_minion(id):
    var idx = find(id)
    if idx >= 0:
        army.pop_at(idx)

func drop_armour(id):
    army[find(id)].armour = false

func _ready():
    add_minion(16)
    Signals.minion_died.connect(remove_minion)
