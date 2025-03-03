extends Node3D

var mapsrc_enabled: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Console.add_command("noclip", console_noclip)
	Console.add_command("mapsrc", mapsrc, 0, 0, "Enable loading external scenes from outside the maps folder.")
	Console.add_command("map", loadmap, ["'Scene Name'"], 1, "Loads a map or level from the maps folder.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func console_noclip():
	Console.print_line("Not implamented yet.")
	
func mapsrc():
	mapsrc_enabled = !mapsrc_enabled
	
	if mapsrc_enabled:
		Console.print_line("Developer Maps Enabled! (This might break things!!)")
	else:
		Console.print_line("Developer Maps Disabled!")
	 
# Loads a map from the "maps" folder
func loadmap(scene_name: String):
	if mapsrc_enabled:
		var scene_path = "res://" + scene_name + ".tscn"
		if ResourceLoader.exists(scene_path):
			Console.print_line("Loading map: " + scene_name)
			var tree = get_tree()
			tree.change_scene_to_file(scene_path)
		else:
			Console.print_line("Error: Map '" + scene_name + "' not found!")
	else:
		var scene_path = "res://maps/" + scene_name + ".tscn"
		if ResourceLoader.exists(scene_path):
			Console.print_line("Loading map: " + scene_name)
			var tree = get_tree()
			tree.change_scene_to_file(scene_path)
		else:
			Console.print_line("Error: Map '" + scene_name + "' not found!")
			
