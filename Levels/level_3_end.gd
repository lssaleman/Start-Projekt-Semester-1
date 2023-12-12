extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player") && Game.key == 3:
		get_tree().change_scene_to_file("res://Menus/end_menu.tscn")
		Game.playerHP = 10
		Game.Gold = 0
		Game.collectables = 0
		Game.key = 0
