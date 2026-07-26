extends Scene

@export var words : Array[String]
@export var word_label : RichTextLabel
var current_word : String 
var letter_index : int
var block_input : bool = false
var is_success : bool = false
@export var cough : AudioStreamPlayer
@export var type : AudioStreamPlayer
@export var type_fail : AudioStreamPlayer
@export var cheer : AudioStreamPlayer

func _ready():
    super._ready()
    current_word = words.pick_random()
    letter_index = 0
    update_current_label_text()

func last_tick():
    super.last_tick()
    block_input = true
    if ! is_success:
        Signals.failure.emit()
        cough.play()
    
func _input(event):
    if block_input:
        return
    if event is not InputEventKey:
        return
    if not event.pressed:
        return
    if event.unicode != 32 && (event.unicode < 65 || event.unicode > 122):
        return
    if current_word[letter_index].to_upper() != char(event.unicode).to_upper():
        type_fail.pitch_scale = 0.5 + randf() * 0.1
        type_fail.play()
        return
    type.pitch_scale = 0.9 + randf() * 0.2
    type.play()
    letter_index += 1
    if letter_index == current_word.length():
        success()
        return
        
    update_current_label_text()

func update_current_label_text():
    word_label.text = ("[tavern]" + current_word.substr(0, letter_index) + "[/tavern][full]" + current_word.substr(letter_index, current_word.length() - letter_index) + "[/full]").to_upper()
    
    
func success():
    cheer.play()
    Signals.success.emit()
    is_success = true
    for x in range(StatsManager.invest):
        StatsManager.add_minion()
    word_label.text = ("[success]" + current_word).to_upper()
    
