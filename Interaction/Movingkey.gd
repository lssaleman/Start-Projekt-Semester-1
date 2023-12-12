extends Area2D




func _on_body_entered(_body):
	Game.key += 1
	queue_free()
