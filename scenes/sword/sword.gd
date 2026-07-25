extends Scene

@export var prongs : Array[Prong]

func _ready():
    super._ready()
    for prong : Prong in prongs:
        prong.prongs = prongs

func last_tick():
    super.last_tick()
    for prong : Prong in prongs:
        if !prong.is_sharp():
            Signals.failure.emit()
            return
            
    StatsManager.get_fork()
