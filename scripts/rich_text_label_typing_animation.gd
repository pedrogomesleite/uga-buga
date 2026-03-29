extends RichTextLabel

# Velocidade da animação (caracteres por segundo)
@export var speed: float = 20.0

func _ready():
	# Começa com o texto invisível
	visible_ratio = 0.0
	aparecer_texto()

func aparecer_texto():
	# Calcula a duração baseada no tamanho do texto e na velocidade
	var duracao = text.length() / speed
	
	# Cria a interpolação (Tween)
	var tween = get_tree().create_tween()
	
	# Anima a propriedade 'visible_ratio' de 0 até 1
	tween.tween_property(self, "visible_ratio", 1.0, duracao)
