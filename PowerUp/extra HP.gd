extends Area2D




func _on_body_entered(body):
	if body.is_in_group("Climber"):
		Game.playerHP += 5
		queue_free()
