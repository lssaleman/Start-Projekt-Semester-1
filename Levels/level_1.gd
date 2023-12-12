extends Node2D
# Called when the node enters the scene tree for the first time.

func _ready():
	Game.current_level = "res://Levels/level_1.tscn"
	Game.pause_menu = $Player/Player/pauseMenu

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(_delta):
	BGsound.stop()
	
