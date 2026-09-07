extends Node

var screenSize:int = 3

func _ready() -> void:
	get_window().size = get_viewport().get_visible_rect().size * screenSize
	DisplayServer.window_set_position(Vector2(DisplayServer.screen_get_position()) + DisplayServer.screen_get_size() * 0.5 - DisplayServer.window_get_size() * 0.5)
	pass
