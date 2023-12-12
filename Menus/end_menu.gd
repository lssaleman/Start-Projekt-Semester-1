extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://menus/main.tscn")


func _on_level_selection_pressed():
	get_tree().change_scene_to_file("res://Menus/level_selection.tscn")


func _on_restart_pressed():
	Game.playerHP = 10
	Game.Gold = 0
	get_tree().change_scene_to_file(Game.current_level)
