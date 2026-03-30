extends MarginContainer


@export_multiline var texto_da_instancia: String = "Texto padrão aqui..."

@onready var label: RichTextLabel = %Text

@export var delay_time = 7

signal fim_dialogo

var started = false

func _ready() -> void:
	hide()

func iniciar_dialogo(conteudo: String, time = 10.0):
	if not started:
		show()
		started = true
		_animar_texto(conteudo)
		var tween_out = get_tree().create_tween()
		tween_out.tween_property(self, "modulate:a", 0.0, time)
		await tween_out.finished
		fim_dialogo.emit()
		queue_free()

func _animar_texto(text: String):
	label.text = text
	label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, 2.0).set_trans(Tween.TRANS_LINEAR).finished

func _on_area_2d_body_entered(_body: Node2D) -> void:
	iniciar_dialogo(texto_da_instancia)

func _on_dispear() -> void:
	queue_free()


func start_cut_scene_dialog(_body: Node2D):
	print("comecou")
	iniciar_dialogo(texto_da_instancia, delay_time)
	
func start_cut_scene_dialog_empty():
	print("comecou")
	iniciar_dialogo(texto_da_instancia, delay_time)
