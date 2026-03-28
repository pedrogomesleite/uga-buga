extends CharacterBody2D


signal objeto_tocado(corpo, direcao)

@export var velocidade_rotacao: float = 2
@export var raio_maximo: float = 100.0
@export var velocidade_movimento: float = 4.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var vel_mouse = Input.get_last_mouse_velocity()
	var mouse_relativo = get_parent().get_local_mouse_position()
	# ir em direcao ao mouse
	var alvo_limitado = mouse_relativo.limit_length(raio_maximo)
	position = position.lerp(alvo_limitado, velocidade_movimento * delta)
	
	# girar em direcao ao mouse
	var angulo_alvo = mouse_relativo.angle()
	rotation = lerp_angle(rotation, angulo_alvo + PI/2, velocidade_rotacao * delta)
	
	checar_colisoes()

func checar_colisoes():
	var colisao = move_and_collide(Vector2.ZERO)
	if colisao:
		var corpo = colisao.get_collider()
		var direcao = (corpo.global_position - global_position).normalized()
		objeto_tocado.emit(corpo, direcao)
