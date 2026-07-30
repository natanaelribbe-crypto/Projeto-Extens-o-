extends Area2D


func _ready() -> void:
	z_index = 50


func _process(delta: float) -> void:
	if $AnimatedSprite2D.animation=="sprite2":
		$AnimatedSprite2D.scale = Vector2(0.08, 0.108)
		$CollisionShape2D.position = Vector2(-1.75, -6.5)
		$CollisionShape2D.scale = Vector2(1.0, 1.0)
		$CollisionShape2D.rotation = 0.0
	else:
		$AnimatedSprite2D.scale = Vector2(0.3, 0.176)
		$CollisionShape2D.position = Vector2(-2.0, -4.0)
		$CollisionShape2D.scale = Vector2(1.15, 0.85)
		$CollisionShape2D.rotation = 90.0


func iniciar(posicao):
	global_position = posicao
	var sprites_lixo = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = sprites_lixo.pick_random()
	$AnimatedSprite2D.play()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_parent().pontuacao += 1
		queue_free()


func _on_life_timer_timeout() -> void:
	queue_free()
