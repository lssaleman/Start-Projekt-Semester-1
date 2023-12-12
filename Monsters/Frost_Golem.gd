#Import the necessary modules
extends CharacterBody2D

# Define variables
var attackSpeed = 50 # Adjust this speed as needed
var is_attacking = false
var health = 10
var maxHealth = 10
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 60
var attackCooldown = 1.0 # Adjust the cooldown time between attacks
var timeSinceLastAttack = 0
func _ready():
	# Initialize the enemy with the "Idle" animation
	get_node("AnimatedSprite2D").play("Idle")
	var healthBar = get_node("healthBar")
	healthBar.max_value = maxHealth
	healthBar.value = health

func _physics_process(delta):
# Apply constant upward velocity for flying effect
	velocity.y += gravity * delta

	# Check if chasing and attacking
	if chase == true:
		if is_attacking:
			timeSinceLastAttack += delta
			if timeSinceLastAttack >= attackCooldown:
				# Inflict damage to the player when the cooldown is over
				timeSinceLastAttack = 0.2
				dealDamageToPlayer()

		# Check and play animations
		if get_node("AnimatedSprite2D").animation != "Death":
			if not is_attacking:
				get_node("AnimatedSprite2D").play("Walk")

		# Get player reference and calculate direction
		player = Game.Player
		var direction = (player.position - self.position).normalized()

		# Flip the enemy sprite based on the direction
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false

		# Set the velocity based on the direction and speed
		velocity = direction * SPEED
		if is_attacking:
			velocity= direction * attackSpeed
	else:
		# Handle non-chase scenarios
		if get_node("AnimatedSprite2D").animation != "Death" and not is_attacking:
			get_node("AnimatedSprite2D").play("Idle")
		velocity = Vector2.ZERO  # Stop the enemy

	# Move the enemy and handle collisions
	move_and_slide()

# Start attacking
func start_attack():
	if !is_attacking:
		is_attacking = true
		get_node("AnimatedSprite2D").play("Attack")

# Stop attacking
func stop_attack():
	if is_attacking:
		is_attacking = false
		get_node("AnimatedSprite2D").play("Idle")

# Called when the enemy's detection area enters the player's body
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true  # Start chasing the player

# Called when the enemy's detection area exits the player's body
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false  # Stop chasing the player

# Called when the enemy's body enters the player's body (collision)
# Handle damage and death
func _on_frost_golem_death_body_entered(body):
	if body.name == "Player":
		receiveDamage(1)  # Inflict damage to player
	if health <= 0:
		death()  # Perform death actions

	if Game.playerHP <= 0:
		queue_free()  # Queue for freeing resources
		#get_tree().change_scene_to_file("res://main.tscn")  # Change scene

# Handle receiving damage
func receiveDamage(damage):
	health -= damage
	var healthBar = get_node("healthBar")
	healthBar.value = health
	
	if health <= 0:
		death()  # Perform death actions

# Handle collision with player
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 6  # Decrease player's HP

# Function to handle enemy's death
func death():
	Game.Gold += 5  # Increase player's gold
	Utils.saveGame()  # Save game data
	chase = false  # Stop chasing the player
	get_node("AnimatedSprite2D").play("Death")  # Play death animation
	await get_node("AnimatedSprite2D").animation_finished  # Wait for animation
	self.queue_free()  # Free resources
	get_tree().change_scene_to_file("res://menus/main.tscn")

# Handle enemy's attack collision
func _on_frost_golem_attack_body_entered(body):
	if body.name == "Player":
		#chase = true
		start_attack()  # Start attacking
		if health <= 0:
			death() 

func _on_frost_golem_attack_body_exited(body):
	if body.name == "Player":
		stop_attack()
		#chase = false
		if health <= 0:
			death() 

# Deal damage to the player
func dealDamageToPlayer():
	if player:
		Game.playerHP -= 4  # Decrease player's HP 
