extends CharacterBody2D

const SPEED = 5.0
@export var forca_impacto: float = .0625
var impulso_max: float = 200

var empurrao_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		#atrito
		velocity.x = lerp(velocity.x, 0.0, 5.0 * delta)
		
	move_and_slide()

func _on_pau_objeto_tocado(vel_martelo: Vector2, _normal: Vector2) -> void:
	var vetor_impulso = -vel_martelo * forca_impacto
	vetor_impulso = vetor_impulso.limit_length(impulso_max)
	var velocidade_max: float= SPEED * Input.get_last_mouse_velocity().length()
	velocity += vetor_impulso
	velocity = velocity.limit_length(velocidade_max)
	print(velocity)
