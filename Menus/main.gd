extends Node2D

# Handle the "Verlassen" button press event
func _on_verlassen_pressed():
	# Quit the game
	get_tree().quit()


func _on_spielen_pressed():
	get_tree().change_scene_to_file("res://Menus/level_selection.tscn")


#button sounds
func _on_spielen_mouse_entered():
	$Buttons/Spielen/Clicksound.play()


func _on_verlassen_mouse_entered():
	$Buttons/Verlassen/Clicksound.play()
