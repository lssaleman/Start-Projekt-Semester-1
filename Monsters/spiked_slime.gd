extends CharacterBody2D

var attackSpeed = 75
var is_attacking = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 75
var attackCooldown = 1.0
var timeSinceLastAttack = 0
var jumpForce = 400  # Adjust the jump force as needed
var wallDetectionRaycast: RayCast2D
var timeSinceLastDirectionChange = 0
var directionChangeInterval = 1.5  # Adjust interval for random direction change

func _ready():
	wallDetectionRaycast = $RayCast2D
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta

	if chase == true:
		if is_attacking:
			timeSinceLastAttack += delta
			if timeSinceLastAttack >= attackCooldown:
				timeSinceLastAttack = 0.2
				dealDamageToPlayer()
		if get_node("AnimatedSprite2D").animation != "Death":
			if not is_attacking:
				get_node("AnimatedSprite2D").play("Walk")

		player = Game.Player
		var direction = (player.position - self.position).normalized()

		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true

		velocity.x = direction.x * SPEED
		if is_attacking:
			velocity.x = direction.x * attackSpeed
	else:
		timeSinceLastDirectionChange += delta
		if timeSinceLastDirectionChange > directionChangeInterval:
			if randf() < 0.2:  # Adjust probability as needed
				var randomDirection = Vector2(randf_range(-1, 1), 0).normalized()
				velocity.x = randomDirection.x * SPEED
				timeSinceLastDirectionChange = 0

		if get_node("AnimatedSprite2D").animation != "Death" and not is_attacking:
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0

	if wallDetectionRaycast.is_colliding():
		jump()

	move_and_slide()

func jump():
	if is_on_floor():
		velocity.y = -jumpForce

func start_attack():
	if !is_attacking:
		is_attacking = true
		get_node("AnimatedSprite2D").play("Attack")

func stop_attack():
	if is_attacking:
		is_attacking = false
		get_node("AnimatedSprite2D").play("Idle")

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = false

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

	if Game.playerHP <= 0:
		queue_free()
		#get_tree().change_scene_to_file("res://main.tscn")

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 5

func death():
	Game.Gold += 5
	Utils.saveGame()
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()

func _on_spiked_slime_attack_body_entered(body):
	if body.name == "Player":
		chase = true
		start_attack()

func _on_spiked_slime_attack_body_exited(body):
	if body.name == "Player":
		chase = false
		stop_attack()

func dealDamageToPlayer():
	if player:
		Game.playerHP -= 1
