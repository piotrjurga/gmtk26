extends Scene

var is_started :bool = false

@export var videos : Array[VideoStreamPlayer]
var video_idx : int = 0
func _ready():
    super._ready()
    Signals.progress_bar_set_visibility.emit(false)
    Signals.title_screen.emit()
    videos[video_idx].play()
    videos[video_idx].visible = true
    for video in videos:
        video.finished.connect(finished)

func _input(event):
    if Input.is_action_just_pressed("space"):
        skip()

func finished():
    if videos[video_idx].loop:
        return
    skip()
    
func skip():
    if is_started:
        return
    videos[video_idx].stop()
    videos[video_idx].visible = false
    
    video_idx += 1
    
    if videos.size() <= video_idx:
        start_game()
        return
    
    videos[video_idx].play()
    videos[video_idx].visible = true
    
func start_game():
    is_started = true
    Signals.start_new_game.emit()
    queue_free()
