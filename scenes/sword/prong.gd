class_name Prong extends Sprite2D

@export var area : Area2D
@export var bad_sprite : Sprite2D
@export var hit_sound :Array[AudioStreamPlayer]

func _ready():
    area.area_entered.connect(area_entered)
    
func area_entered(area: Area2D):
    bad_sprite.visible = false
    var sound : AudioStreamPlayer = hit_sound.pick_random()
    sound.pitch_scale = 0.7 + randf() * 0.6
    sound.play()
    

func is_sharp():
    return ! bad_sprite.visible
    
