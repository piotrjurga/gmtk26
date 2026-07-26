extends Label

var tween : Tween
func _ready():
    Signals.missing_gold.connect(missing_peasants)
    modulate = Color.TRANSPARENT


func missing_peasants():
    modulate = Color.WHITE
    if tween is Tween:
        tween.kill()
        tween = null
    
    tween = create_tween()
    tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5).set_delay(0.2)
