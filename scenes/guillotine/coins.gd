extends Label


func _ready():
    text = str(TargetManager.current_target.gold)
