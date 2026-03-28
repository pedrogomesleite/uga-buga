extends CharacterBody2D

const SPEED = 500.0
@export var forca_impacto: float = 15
var impulso_max: float = 200
var empurrao_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		#atrito
		velocity.x = lerp(velocity.x, 0.0, 15.0 * delta)
		
	move_and_slide()

func _on_pau_objeto_tocado(movimento_bloqueado: Vector2, delta: float) -> void:
	var vetor_impulso = -movimento_bloqueado * forca_impacto
	vetor_impulso = vetor_impulso.limit_length(impulso_max)
	velocity += vetor_impulso * delta * forca_impacto
	velocity = velocity.limit_length(SPEED)
	print(velocity)
