extends Area2D


signal off_collect_speed



func _on_body_entered(body):
	emit_signal("off_collect_speed")
	queue_free()
