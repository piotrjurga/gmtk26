class_name RythmManager extends Node

@export var pip_sound : AudioStreamPlayer
@export var pop_sound : AudioStreamPlayer
@export var music : AudioStreamPlayer
@export var bpm : int = 120
@export var measures : int = 8

@export var delay_start_timer : Timer

var max_ticks : int = 4
var current_tick : int = 0

# Tracking the beat and song position
var song_position = 0.0
var song_position_in_beats = 1
var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

# Determining how close to the beat an event is
var closest = 0
var time_off_beat = 0.0

var last_playback_position : float = 0.0
var was_first_beat_emited = false

func _ready():
    sec_per_beat = 60.0 / bpm
    Signals.set_stream.connect(set_stream)
    
func set_stream(stream_index : int):
    var stream : AudioStreamSynchronized = music.stream
    for i in range(stream.stream_count):
        if stream_index == i:
            stream.set_sync_stream_volume(i, 0)
        else:
            stream.set_sync_stream_volume(i, -60)
            
    
func finished():
    song_position = 0.0
    song_position_in_beats = 1
    last_reported_beat = 0
    beats_before_start = 0
    measure = 1
    if ! was_first_beat_emited:
        Signals.tick.emit(measure)
        was_first_beat_emited = true
        
    

func _process(_delta):
    var playback_position = music.get_playback_position()
    
    if playback_position < last_playback_position:
        finished()
    if music.playing:
        last_playback_position = playback_position
        song_position = last_playback_position + AudioServer.get_time_since_last_mix()
        song_position -= AudioServer.get_output_latency()
        song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
        _report_beat()


func _report_beat():
    var last_measure = measure
    if last_reported_beat < song_position_in_beats:
        if measure >= measures:
            measure = 1
        else:
            measure += 1
        last_reported_beat = song_position_in_beats
        
    if last_measure == measure:
        return
    
    if measure >= measures:
        Signals.tick.emit(measure)
        Signals.last_tick.emit()
        was_first_beat_emited = false
        #pop_sound.play()
        return
    
    if !was_first_beat_emited || measure > 1:
        Signals.tick.emit(measure)
        was_first_beat_emited = true
    #pip_sound.play()
            
func start():
    music.play()
    Signals.tick.emit(measure)
    #pip_sound.play()
