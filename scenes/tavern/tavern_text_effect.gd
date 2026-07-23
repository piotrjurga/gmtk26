@tool
extends RichTextEffect
class_name TavernText

var bbcode := "TAVERN"

func _process_custom_fx(char_fx) -> bool:
    #var bounce := pow((fmod(6.0 + char_fx.elapsed_time + char_fx.range.x/4.0, 4.0)-2.0), 2.0) / 4.0
    #char_fx.offset.y = 10.0 * bounce - 10.0
    
    char_fx.color = Color.SANDY_BROWN
    return true
