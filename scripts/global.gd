extends Node

signal cenaCarregada

var loadingPath: String = ""

func _ready() -> void:
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		var velocidade_mouse = event.velocity
		
