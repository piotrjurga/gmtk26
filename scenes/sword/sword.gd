extends Scene

@export var prongs : Array[Prong]


func last_tick():
    super.last_tick()
    for prong : Prong in prongs:
        if !prong.is_sharp():
            return
            
    StatsManager.get_fork()
    Signals.success.emit()
