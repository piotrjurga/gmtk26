extends Scene

@export var prongs : Array[Prong]

func last_tick():
    for prong : Prong in prongs:
        if !prong.is_sharp():
            return
            
    print("success")
