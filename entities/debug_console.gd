extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Console.add_command("noclip", console_noclip)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func console_noclip():
	Console.print_line("Not implamented yet.")
