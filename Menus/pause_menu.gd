extends Control

var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	# self.pause_menu.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pauseMenu()
	
func pauseMenu():
	if paused:
		Game.pause_menu.hide()
		Engine.time_scale = 1
	else:
		Game.pause_menu.show()
		Engine.time_scale = 0
	paused = !paused


func _on_resume_pressed():
	pauseMenu()


func _on_restart_pressed():
	pauseMenu()
	reset()
	get_tree().change_scene_to_file(Game.current_level)


func _on_quit_menu_pressed():
	reset()
	pauseMenu()
	get_tree().change_scene_to_file("res://menus/main.tscn")


func _on_quit_game_pressed():
	get_tree().quit()
	
func reset():
	Game.playerHP = 10
	Game.Gold = 0
	Game.collectables = 0
	Game.key = 0
