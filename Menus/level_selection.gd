extends Node2D



func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menus/main.tscn")


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")



func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Levels/level_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Levels/level_3.tscn")
	
func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://Levels/level_4.tscn")

# button sounds
func _on_level_1_mouse_entered():
	$Buttons/Level_1/Clicksound.play()
	
func _on_level_2_mouse_entered():
	$Buttons/Level_2/Clicksound.play()
	

func _on_level_3_mouse_entered():
	$Buttons/Level_3/Clicksound.play()
	

func _on_level_4_mouse_entered():
	$Buttons/Level_4/Clicksound.play()


func _on_level_5_mouse_entered():
	$Buttons/Level_5/Clicksound.play()


func _on_menu_mouse_entered():
	$Buttons/Menu/Clicksound.play()



