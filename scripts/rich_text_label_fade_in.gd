extends RichTextLabel

@export var frases: Array[String] = [
	"A very long time ago 
	A man named Guga 
	Found himself very [shake]hungry[/shake]
	So he did the most sensible
	Shing that came to his mind
	[wave]Steal[/wave] some food
	From the tribe [i]leader Bunga[/i]",
	"The security wasn't very good..
	Guga maneged to get in
	And eat [rainbow]all the food[/rainbow]
	That was gathered
	To last the whole [tornado]winter[/tornado]
	Leaving just the bone
	To all the [i]betas[/i]",
	"Guga was caught
	They cut his legs out
	And threw him
	In a dark cave
	Very dark
	And cavernous"
]

@export var next_scene: String = "res://scenes/cenarios/Caverna.tscn"

var indice_atual: int = 0
var ja_mudou: bool = false
var pulando_frase: bool = false

func _ready() -> void:
	executar_ciclo_de_texto()

func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventMouseButton) and event.is_pressed():
		pulando_frase = true
		indice_atual += 1

func executar_ciclo_de_texto():
	while indice_atual < frases.size():
		text = frases[indice_atual]
		modulate.a = 0.0
		pulando_frase = false
		
		var tween = get_tree().create_tween()
		
		tween.tween_property(self, "modulate:a", 1.0, 5.0)
		await tween.finished
		if not pulando_frase:
			var tween_out = get_tree().create_tween()
			tween_out.tween_property(self, "modulate:a", 0.0, 4.0)
			await tween_out.finished
		
		indice_atual += 1
	
	ir_para_proxima_cena()

func ir_para_proxima_cena():
	if not ja_mudou:
		ja_mudou = true
		Controller.trocar_cena(next_scene)
