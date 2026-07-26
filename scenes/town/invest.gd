class_name Invest extends Node2D

@export var change : AudioStreamPlayer
@export var investment_label : Label
@export var character : CharacterBody2D
var invest_toggle_values : Array[int] = [1, 2, 5, 10]
var tween : Tween

func _ready():
    set_init_investment()
    
    investment_label.text = str(StatsManager.invest)
    
func set_init_investment():
    if StatsManager.invest <= StatsManager.gold:
        return
    if StatsManager.gold >= 5:
        StatsManager.invest = 5
        return
    if StatsManager.gold >= 2:
        StatsManager.invest = 2
        return
    
    StatsManager.invest = 1
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
    if character.picked_place != TownPlace.Places.Street:
        return
    if Input.is_action_just_pressed("space"):
        toggle()

func toggle():
    var current_idx : int = invest_toggle_values.find(StatsManager.invest)
    var new_idx : int = current_idx + 1
    
    if new_idx > invest_toggle_values.size() - 1:
        new_idx = 0
    
    var new_value : int = invest_toggle_values[new_idx]
    
    if new_value > StatsManager.gold:
        new_idx = 0
        
    StatsManager.invest = invest_toggle_values[new_idx]
    investment_label.text = str(StatsManager.invest)
    visuals()
    
func visuals():
    if tween is Tween:
        tween.kill()
        tween = null
    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.set_ease(Tween.EASE_IN_OUT)
    var new_scale = 1 + 0.2
    tween.tween_property(investment_label, "scale", Vector2(new_scale, new_scale), 0.15)
    tween.tween_property(investment_label, "scale", Vector2(new_scale - 0.1, new_scale - 0.1), 0.1).set_delay(0.05)
    tween.tween_property(investment_label, "scale", Vector2(1, 1), 0.3).set_delay(0.05)
    change.play()
