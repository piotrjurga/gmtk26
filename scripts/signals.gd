extends Node

# clock
signal tick(current_tick : int)
signal last_tick()
signal scene_ended()
signal progress_bar_set(value : float)
signal progress_bar_set_visibility(value : bool)

# town
signal place_picked(place : TownPlace.Places)
signal missing_gold()

# bullet hell
signal minion_died(id: int)
signal enemy_died()
signal scene_done(success : bool)

# target
signal target_dead(target : Target)

# gym
signal player_hit()

# game state
signal success()
signal failure()

# music
signal set_stream()


# title screen
signal start_new_game()
signal title_screen()
signal start_rythm_manager()

# darts
signal unlock_scene_change()
