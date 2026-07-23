extends Node

# clock
signal tick(current_tick : int)
signal last_tick()
signal scene_ended()
signal progress_bar_set(value : float)

# town
signal place_picked(place : TownPlace.Places)
