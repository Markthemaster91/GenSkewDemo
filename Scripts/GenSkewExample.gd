extends Node2D

var exampleChoice = 0
var prevInput = 0

var islandSkew = Vector2.ZERO

var skewTimer = 0.0
var shipSkew = Vector2.ZERO

var cheshireSkew = Vector2.ZERO
var cheshireOff = Vector2.ZERO
var cheshireAmp:float = 0.0
@onready var cheshireOrigin = $CheshireCat.position



func _physics_process(delta: float) -> void:
	
	#Move Camera
	var inputSign = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if (prevInput != inputSign):
		exampleChoice += inputSign
		exampleChoice = clamp(exampleChoice, 0, 3)
		$Camera2D.position.x = 320 * exampleChoice
		prevInput = inputSign
		pass
	
	
	
	#General Movement
	skewTimer += delta * 60
	skewTimer = wrap(skewTimer, 0, 360)
	
	#EXAMPLE MOVEMENTS
	#Angel Island
	islandSkew.x = -sin(deg_to_rad(skewTimer)) * (9.5 / 256.0)
	islandSkew.y = sin(deg_to_rad(skewTimer)) * (12.5 / 128.0)
	$AngelIsland.material.set_shader_parameter("skewOffX", islandSkew.x)
	$AngelIsland.material.set_shader_parameter("skewOffY", islandSkew.y)
	
	#Polly Pirate's Ship
	shipSkew.x = -sin(deg_to_rad(skewTimer * 4)) * (40.0 / 512.0)
	shipSkew.y = sin(deg_to_rad(skewTimer * 4)) * (48.0 / 240.0)
	
	$PollyPirateShip.material.set_shader_parameter("skewOffX", shipSkew.x)
	$PollyPirateShip.material.set_shader_parameter("skewOffY", shipSkew.y)
	
	#Treasure Map
	$TreasureMap.material.set_shader_parameter("waveOffX", deg_to_rad(skewTimer) )
	$TreasureMap.material.set_shader_parameter("waveOffY", deg_to_rad(skewTimer * 8))
	
	#Chesire Cat
	cheshireSkew.x = -sin(deg_to_rad(skewTimer * 2)) * (40 / 320.0)
	cheshireSkew.y = sin(deg_to_rad(skewTimer * 2)) * (40 / 240.0)
	$CheshireCat.material.set_shader_parameter("skewOffX", cheshireSkew.x)
	$CheshireCat.material.set_shader_parameter("skewOffY", cheshireSkew.y)
	
	cheshireAmp = sin(deg_to_rad(skewTimer * 12)) * 4
	$CheshireCat.material.set_shader_parameter("waveAmpY", cheshireAmp)
	$CheshireCat.position.x = cheshireOrigin.x - (cheshireAmp * cheshireSkew.y)
	$CheshireCat.position.y = cheshireOrigin.y - cheshireAmp
	
	pass
