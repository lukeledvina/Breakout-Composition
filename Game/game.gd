extends Node2D

# programatically spawn the blocks at each start of game
# keep track of score?
# send a signal from the ball to this script whenever a block is destroyed, and accordingly increment the score to be sent to the UI
@onready var red_block: PackedScene = preload("res://Blocks/red_block.tscn")
@onready var orange_block: PackedScene = preload("res://Blocks/orange_block.tscn")
@onready var yellow_block: PackedScene = preload("res://Blocks/yellow_block.tscn")
@onready var green_block: PackedScene = preload("res://Blocks/green_block.tscn")
@onready var blue_block: PackedScene = preload("res://Blocks/blue_block.tscn")
@onready var violet_block: PackedScene = preload("res://Blocks/violet_block.tscn")

@onready var score_label: Label = $UI/MarginContainer/HBoxContainer/ScoreLabel
@onready var lives_label: Label = $UI/MarginContainer/HBoxContainer/LivesLabel
@onready var high_score_label: Label = $UI/MarginContainer/HBoxContainer/HighScoreLabel

@onready var ball_scene: PackedScene = preload("res://Ball/ball.tscn")

var score: int = 0

#load previous game's high score here
var high_score: int = 0

var max_lives: int = 3
var player_lives: int = max_lives


func _ready():
	$Ball.connect("block_destroyed", _on_block_destroyed)
	$Ball.connect("ball_destroyed", _on_ball_destroyed)
	
	var high_score_data = $SaveGameSystem.load_game()
	high_score = high_score_data["high_score"]
	high_score_label.text = "High Score: " + str(high_score)
	
	for block in $Blocks.get_children():
		block.queue_free()
	
	spawn_blocks()

		
func _on_block_destroyed(block_value):
	
	score += block_value
	score_label.text = "Score: " + str(score)
	if $Blocks.get_child_count() <= 1:
		$Ball.queue_free()
		reset_game()
		call_deferred("spawn_blocks")
	
func _on_ball_destroyed():
	player_lives -= 1
	lives_label.text = "Lives: " + str(player_lives)
	if player_lives <= 0:
		#end the game, show score and check if it is higher than high score, if it is then save it as the new high score
		end_game()


	else:
		reset_game()
		

func end_game():
	# blank the screen, say some lose message and then show the score large
	
	if score > high_score:
		#maybe add some fanfare (particle fx)
		high_score = score
		high_score_label.text = "High Score: " + str(high_score)
		$SaveGameSystem.save_game(self)
		#save high score to disk
		
		# await player input, on input close the game, or just stay on the score until they close the game


func spawn_blocks():
	var y_pos: int = 64
	var x_pos: int = 26
	for i in range(1): #6
		x_pos = 26
		var block: PackedScene
		if i == 0:
			block = red_block
		elif i == 1:
			block = orange_block
		elif i == 2:
			block = yellow_block
		elif i == 3:
			block = green_block
		elif i == 4:
			block = blue_block
		elif i == 5:
			block = violet_block
		for j in range(1): # 14
			var new_block = block.instantiate()
			$Blocks.add_child(new_block)
			new_block.position = Vector2(x_pos, y_pos)
			x_pos += 45
		y_pos += 16
		
func reset_game():
	var new_ball = ball_scene.instantiate()
	call_deferred("add_child", new_ball)
	new_ball.connect("block_destroyed", _on_block_destroyed)
	new_ball.connect("ball_destroyed", _on_ball_destroyed)
	$Player.reset_player()
		

func save():
	var save_dict = {
		"high_score": high_score
	}
	return save_dict
	

