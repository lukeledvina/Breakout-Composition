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

var score: int = 0

#load previous game's high score here
var high_score: int = 0

var max_lives: int = 3
var player_lives: int = max_lives


func _ready():
	$Ball.connect("block_destroyed", _on_block_destroyed)
	$Ball.connect("ball_destroyed", _on_ball_destroyed)
	
	for block in $Blocks.get_children():
		block.queue_free()
	
	var y_pos: int = 64
	var x_pos: int = 26
	for i in range(6):
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
		for j in range(14):
			var new_block = block.instantiate()
			$Blocks.add_child(new_block)
			new_block.position = Vector2(x_pos, y_pos)
			x_pos += 45
		y_pos += 16
		
func _on_block_destroyed(block_value):
	
	score += block_value
	score_label.text = "Score: " + str(score)
	
func _on_ball_destroyed():
	player_lives -= 1
	if player_lives <= 0:
		#end the game, show score and check if it is higher than high score, if it is then save it as the new high score
		end_game()


	else:
		$Ball.reset_ball()
		$Player.reset_player()
		

func end_game():
	# blank the screen, say some lose message and then show the score large
	
	if score > high_score:
		#maybe add some fanfare (particle fx)
		high_score = score
