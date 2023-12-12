extends Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# updates the HP label texte
	text = "HP: " + str(Game.playerHP)
