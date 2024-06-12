extends Area2D

# on spawn, pick a random direction and go
# whenever it collides with the boundaries, reverse velocity of one direction, keep velocity in other direction the same
# if colliding with the paddle, depending on which side of the paddle, change velocity accordingly

var direction: Vector2 = Vector2.ZERO
var initial_speed: int = 100
var speed: int = initial_speed
var velocity: Vector2
var player_width: int = 65

func _ready():
	await get_tree().create_timer(0.5).timeout
	
	direction = Vector2(randf_range(-1, 1), randf_range(0.1, 1)).normalized()

func _physics_process(delta):
	
	velocity = direction * speed
	
	position += velocity * delta

func _on_area_left_body_entered(body):
	if body.name == "block":
		#increment score depending on the type of block ( color )
		#increase the speed of the ball
		#destroy the block
		pass
	
	direction.x = -direction.x

func _on_area_up_body_entered(body):
	print("top")
	direction.y = -direction.y

func _on_area_down_body_entered(body):
	
	
	if body.is_in_group("block"):
		#increment score depending on the type of block ( color )
		#increase the speed of the ball
		#destroy the block
		pass
	elif body.name == "Player":
		#reflect differently depending on what area of player hit
		
		var player_position_x: float = body.position.x
		var difference: float = clampf((player_position_x - position.x) / player_width, -0.9, 0.9)
		print(difference)
		direction = Vector2(-difference, (1 - difference)).normalized()
		
	direction.y = -direction.y
	print("bottom")
	
	

func _on_area_right_body_entered(body):
	direction.x = -direction.x

