extends HSlider

func _ready():
	value = linear2db(globals.musicvol)
