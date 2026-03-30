extends MarginContainer


@export_multiline var texto_da_instancia: String = "Texto padrão aqui..."

@onready var label: RichTextLabel = %Text

var started = false

func _ready() -> void:
	hide()

func iniciar_dialogo(conteudo: String):
	if not started:
		show()
		started = true
		_animar_texto(conteudo)
		var tween_out = get_tree().create_tween()
		tween_out.tween_property(self, "modulate:a", 0.0, 10.0)
		await tween_out.finished
		queue_free()

func _animar_texto(text: String):
	label.text = text
	label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, 2.0).set_trans(Tween.TRANS_LINEAR)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	iniciar_dialogo(texto_da_instancia)
