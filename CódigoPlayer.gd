extends CharacterBody2D

const SPEED = 300.0
var JUMP_VELOCITY = -400.0
var tempo_pulo = 0
var limite = 1.5


func _physics_process(delta: float) -> void:
	calcular_gravidade()
	
	global_position = global_position.clamp(Vector2.ZERO, Vector2(1152, 648))
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("pular") and is_on_floor():
		tempo_pulo+=delta
		if calcular_proporcao()<limite: get_parent().proporcao = calcular_proporcao()
		else: get_parent().proporcao = limite
	else:
		if tempo_pulo>0.05:
			var proporcao_pulo = calcular_proporcao()
			if proporcao_pulo>limite: proporcao_pulo = limite
			velocity.y = JUMP_VELOCITY*proporcao_pulo
			tempo_pulo=0
		elif tempo_pulo!=0:
			velocity.y = JUMP_VELOCITY
			tempo_pulo = 0

	var direction := Input.get_axis("andar_trás", "andar_frente")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x<0: $AnimatedSprite2D.flip_h = true
	elif velocity.x>0: $AnimatedSprite2D.flip_h = false

	if tempo_pulo<0.1:
		move_and_slide()


func calcular_gravidade():
	var vel = get_parent().pontuacao*5-425
	if vel<-400: JUMP_VELOCITY=-400.0
	elif vel>-200: JUMP_VELOCITY=-200.0
	else: JUMP_VELOCITY=vel


func calcular_proporcao():
	return (tempo_pulo+0.668)/0.684
