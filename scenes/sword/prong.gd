class_name Prong extends Sprite2D

@export var area : Area2D
@export var bad_sprite : Sprite2D

func _ready():
    area.area_entered.connect(area_entered)
    
func area_entered(area: Area2D):
    bad_sprite.visible = false
    

func is_sharp():
    return ! bad_sprite.visible
    
