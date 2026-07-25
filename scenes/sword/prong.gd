class_name Prong extends Node2D

@export var area : Area2D
@export var good_sprite : Sprite2D
@export var hit_sound :Array[AudioStreamPlayer]
@export var prongs : Array[Prong]

func _ready():
    area.area_entered.connect(area_entered)
    Signals.success.connect(success)
    
func area_entered(area: Area2D):
    good_sprite.visible = true
    var sound : AudioStreamPlayer = hit_sound.pick_random()
    sound.pitch_scale = 0.7 + randf() * 0.6
    sound.play()
    
    for prong : Prong in prongs:
        if !prong.is_sharp():
            return
    Signals.success.emit()
    

func success():
    area.area_entered.disconnect(area_entered)

func is_sharp():
    return good_sprite.visible
    
