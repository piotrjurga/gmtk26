extends Node2D

@export var oofs : Array[AudioStreamPlayer]
@export var wooshes : Array[AudioStreamPlayer]

func _ready():
    Signals.minion_died.connect(minion_died)
    Signals.enemy_died.connect(enemy_died)
    Signals.weapon_thrown.connect(weapon_thrown)

func minion_died(id: int):
    enemy_died()
    
func enemy_died():
    var oofs_temp = oofs.duplicate()
    oofs_temp.shuffle()
    
    for oof : AudioStreamPlayer in oofs_temp:
        if oof.playing:
            continue
        oof.pitch_scale = 0.7 + 0.6 * randf()
        oof.play()
        return
    
func weapon_thrown():
    var woosh_temp = wooshes.duplicate()
    woosh_temp.shuffle()
    
    for woosh : AudioStreamPlayer in woosh_temp:
        if woosh.playing:
            continue
        woosh.pitch_scale = 0.9 + 0.2 * randf()
        woosh.play()
        return
    
