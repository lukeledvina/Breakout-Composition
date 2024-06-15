extends Node


func save_game(node):
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
		
	var node_data = node.call("save")
	
	var json_string = JSON.stringify(node_data)
		
	save_game.store_line(json_string)


func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		
		print(node_data)
		
		return node_data
