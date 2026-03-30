extends Node2D

@onready var camera_animacao: Camera2D = $Camera2D
@onready var camera_default: Camera2D = $"../Guga/CharacterBody2D/Camera2D"

signal finalizar_cut_scene

var play = true

func _on_area_body_entered(_body: Node2D) -> void:
	if play:
		play = false
		inicia_camera()
	
	
func inicia_camera():
	camera_animacao.enabled = true
	camera_default.enabled = false


func finaliza_camera():
	camera_animacao.enabled = false
	camera_default.enabled = true
	finalizar_cut_scene.emit()
