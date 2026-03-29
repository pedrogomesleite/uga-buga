extends RichTextLabel

func _ready():
	text = "" 
	visible_characters = 0

func _on_evento_de_texto_recebido(novo_texto: String):
	text = novo_texto
	_animar_texto()

func _animar_texto():
	visible_characters = 0
	var tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, 2.0).set_trans(Tween.TRANS_LINEAR)
