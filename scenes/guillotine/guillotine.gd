extends Scene

@export var blade_success_height : float
@export var blade_top_max_y : float
@export var blade_bottom_max_y : float
@export var blade_drop_y : float
var min_height : float

@export var blade : Sprite2D
@export var fall_speed : float
@export var strength : float = 30

@export var head : Head

var enabled : bool = true

func _ready():
    super._ready()
    blade.global_position.y = blade_bottom_max_y
    min_height = blade_bottom_max_y
    if TargetManager.current_target:
        head.init_from_target(TargetManager.current_target)

func _physics_process(delta):
    if blade.global_position.y < min_height:
        blade.global_position.y += delta * fall_speed
    if blade.global_position.y >= blade_drop_y:
        head.fall()
        Signals.success.emit()
        if TargetManager.current_target is Target:
            Signals.target_dead.emit(TargetManager.current_target)

func last_tick():
    if blade_success_height > blade.global_position.y:
        min_height = blade_drop_y
        print("success")
    else:
        Signals.failure.emit()
    fall_speed = fall_speed * 10
    enabled = false

func _input(event):
    if !enabled:
        return
    if ! Input.is_action_just_pressed("space"):
        return

    blade.global_position.y -= strength
    if blade.global_position.y < blade_top_max_y:
        blade.global_position.y = blade_top_max_y

func next_scene() -> PackedScene:
    if TargetManager.current_target is Target:
        return ScenesManager.town
    else:
        return ScenesManager.darts
