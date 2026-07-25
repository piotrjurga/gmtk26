extends Node

var targets : Array[Target]
var current_target : Target
var dead_targets : Array[Target]

var eyes : Array[Texture]
var mouths : Array[Texture]
var necks : Array[Texture]
var noses : Array[Texture]
var torsos  : Array[Texture]
var wigs : Array[Texture]
var title : Array[String] = [
    "Sir",
    "Lord",
    "Count",
]
var names : Array[String] = [
    "Baguette",
    "Au Revoir",
    "Geoffroy",
    "Chardonnay",
    "Michelin",
    "Jaques",
    "Rafaael",
    "Johan",
    "Gregory",
    "Polnareff",
]
var king_target : Target

func fill_in_assets(folder : String, variable_to_fill : Array[Texture]):
    for file_name in DirAccess.get_files_at("res://assets/count/" + folder):
        if file_name.contains('.import'):
            continue
        variable_to_fill.append(ResourceLoader.load("res://assets/count/" + folder + "/" + file_name))

func _ready():
    fill_in_assets('eyes', eyes)
    fill_in_assets('mouths', mouths)
    fill_in_assets('necks', necks)
    fill_in_assets('noses', noses)
    fill_in_assets('torsos', torsos)
    fill_in_assets('wigs', wigs)
    
    var temp_names : Array[String] = names
    temp_names.shuffle()
    for i in range(9):
        var new_target : Target = Target.new()
        new_target.title = title[i % 3]
        new_target.name = temp_names.pop_front()
        new_target.eyes = randi_range(0, 2)
        new_target.mouth = randi_range(0, 2)
        new_target.neck = randi_range(0, 3)
        new_target.nose = randi_range(0, 2)
        new_target.torso = 0
        new_target.wig = randi_range(0, 3)
        set_gold(new_target)
        targets.append(new_target)
        
    var new_target : Target = Target.new()
    new_target.title = "King"
    new_target.name = temp_names.pop_front()
    new_target.eyes = randi_range(0, 2)
    new_target.mouth = randi_range(0, 2)
    new_target.neck = randi_range(0, 3)
    new_target.nose = randi_range(0, 2)
    new_target.torso = 0
    new_target.wig = randi_range(0, 3)
    new_target.gold = 99
    king_target = new_target
    
    Signals.target_dead.connect(dead_target)
    
func has_target() -> bool:
    return current_target is Target
    
func set_target(new_target : Target):
    current_target = new_target

    
func dead_target(dead_target : Target):
    StatsManager.gold += dead_target.gold
    if dead_target.title == "King":
        king_target = null
    else:
        targets.erase(dead_target)

    current_target = null

func set_gold(new_target : Target):
    var idx : int = title.find(new_target.title)

    new_target.gold = 5 * idx + int(randf() * 3) + 2
    
