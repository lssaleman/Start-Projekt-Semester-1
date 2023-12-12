class_name Interacable extends Area2D

@export var interact_label = "none"
@export var interact_type = "hide_object"
@export var interact_value = "none"

func hide_object():
	Game.collectables = Game.collectables + 1
	queue_free()
