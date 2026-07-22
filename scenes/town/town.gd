extends Scene

var picked_place : TownPlace.Places = TownPlace.Places.Street

func _ready():
    Signals.place_picked.connect(place_picked)
    
func place_picked(place : TownPlace.Places):
    picked_place = place

func next_scene() -> PackedScene:
    match picked_place:
        TownPlace.Places.Tavern:
            return ScenesManager.tavern
        TownPlace.Places.Gym:
            return ScenesManager.gym
        TownPlace.Places.Swords:
            return ScenesManager.sword
        TownPlace.Places.Armour:
            return ScenesManager.armour
        TownPlace.Places.Street:
            return ScenesManager.town
    return ScenesManager.town
