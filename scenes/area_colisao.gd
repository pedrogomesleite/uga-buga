extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("rachadores"):
		$GPUParticles2D.emitting = true
		$CollisionShape2D.set_deferred("disabled", true) # Desativa colisão com segurança
		$CollisionShape2D/Sprite2D.hide() # Esconde o visual

		# Espera o tempo das partículas (ex: 2 segundos) ou o sinal 'finished'
		await get_tree().create_timer(1.0).timeout 
		self.queue_free()
