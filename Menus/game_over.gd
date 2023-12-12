extends Control

# Handle the "Verlassen" button press event
func _on_verlassen_pressed():
	# Quit the game
	get_tree().change_scene_to_file("res://menus/main.tscn")


func _on_nochmal_pressed():
	Game.playerHP = 10
	Game.Gold = 0
	Game.collectables = 0
	Game.key = 0
	get_tree().change_scene_to_file(Game.current_level)


#button sounds



func _on_verlassen_mouse_entered():
	$Buttons/Verlassen/ClickSound.play()


func _on_nochmal_mouse_entered():
	$Buttons/Verlassen/ClickSound.play()
