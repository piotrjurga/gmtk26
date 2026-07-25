extends Scene

var picked_place : TownPlace.Places = TownPlace.Places.Street

func _ready():
    super._ready()
    Signals.place_picked.connect(place_picked)
    $StatsLabel.text = "Gold " + str(StatsManager.gold) + \
            "\nSoldiers " + str(StatsManager.army.size()) + \
            "\nArmour " + str(StatsManager.armour_count()) + \
            "\nForks " + str(StatsManager.fork_count()) + \
            "\nFast soldiers " + str(StatsManager.speed_count())
    Signals.progress_bar_set.connect(restart)
    Signals.progress_bar_set_visibility.emit(false)
    
func tick(current_tick : int):
    return
    
func last_tick():
    return

func restart(value : float):
    if value == 100.0:
        progress = 100.0
    
func place_picked(place : TownPlace.Places):
    picked_place = place

func next_scene() -> PackedScene:
    match picked_place:
        TownPlace.Places.Darts:
            return ScenesManager.darts
        TownPlace.Places.Tavern:
            return ScenesManager.tavern
        TownPlace.Places.Gym:
            return ScenesManager.gym
        TownPlace.Places.Swords:
            return ScenesManager.sword
        TownPlace.Places.Armour:
            return ScenesManager.armour
        TownPlace.Places.Boss:
            return ScenesManager.boss
        TownPlace.Places.Street:
            return ScenesManager.town
    return ScenesManager.town
