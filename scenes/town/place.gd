class_name TownPlace extends Node2D

enum Places {Tavern, Gym, Swords, Armour, Street, Boss, Darts}

@export var label : Label
@export var place : Places
@export var area : Area2D
@export var sprite : Sprite2D
var is_picked : bool = false
var pulse_tween: Tween

func _ready():
    area.body_entered.connect(pick_place)
    Signals.place_picked.connect(place_picked)
    sprite.visible = false
    Signals.tick.connect(pulse)
        

func stop():
    Signals.tick.disconnect(pulse)

func pulse(tick_idx : int):
    if place != Places.Darts:
        if StatsManager.gold < StatsManager.invest:
            return
        if !validate(false):
            return
    if pulse_tween is Tween:
        pulse_tween.kill()
        pulse_tween = null
    pulse_tween = create_tween()
    pulse_tween.set_trans(Tween.TRANS_SINE)
    pulse_tween.set_ease(Tween.EASE_IN_OUT)
    scale = Vector2(1.02, 1.02)
    pulse_tween.tween_property(self, "scale", Vector2(1, 1), 0.2)

    
func pick_place(body : Node2D):
    if place == Places.Darts:
        Signals.place_picked.emit(place)
        return
    if StatsManager.gold < StatsManager.invest:
        Signals.missing_gold.emit()
        return
    if !validate():
        return
    Signals.place_picked.emit(place)
    StatsManager.gold -= StatsManager.invest

func place_picked(new_place : TownPlace.Places):
    is_picked = new_place == place
    
func _physics_process(delta):
    if !is_picked:
        sprite.visible = false
        return
    
    sprite.visible = true

func validate(emit : bool = true) -> bool:
    match place:
        Places.Gym:
            if (StatsManager.speed_count() + StatsManager.invest) > StatsManager.army.size():
                if emit:
                    Signals.missing_peasants.emit()
                    Signals.incorrect_speed.emit()
                return false
        Places.Armour:
            if (StatsManager.armour_count() + StatsManager.invest) > StatsManager.army.size():
                if emit:
                    Signals.missing_peasants.emit()
                    Signals.incorrect_armour.emit()
                return false
        Places.Swords:
            if (StatsManager.fork_count() + StatsManager.invest) > StatsManager.army.size():
                if emit:
                    Signals.missing_peasants.emit()
                    Signals.incorrect_dmg.emit()
                return false
    
    return true
    
