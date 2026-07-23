@tool
extends RichTextEffect
class_name FullText

var bbcode := "FULL"

func _process_custom_fx(char_fx) -> bool:
    char_fx.color = Color.DIM_GRAY
    
    return true
