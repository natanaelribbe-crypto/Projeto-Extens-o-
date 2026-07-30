extends Node

@export var grama_scene: PackedScene
@export var lixo_scene: PackedScene
var pontuacao = 0
var proporcao = 0
var pos_plataformas = []

func _ready() -> void:
	for i in range(4):
		var grama = grama_scene.instantiate()
		grama.global_position += Vector2(160+280*i, 590)
		add_child(grama)
	for i in range(5):
		var grama = grama_scene.instantiate()
		grama.get_node("AnimatedSprite2D").scale = Vector2(0.2, 0.2)
		grama.get_node("CollisionShape2D").scale = Vector2(0.5, 0.5)
		grama.get_node("CollisionShape2D").position -= Vector2(0, 16.5)
		grama.num_horizontal = i
		grama.global_position = gerar_posicao(i)
		pos_plataformas.append(grama.global_position)
		add_child(grama)
	$Player.global_position = Vector2(30, 510)
	$Player.z_index = 100
	$Timer.start()


func _process(delta: float) -> void:
	$ScoreLabel.text = "Sacos de Lixo Coletados: "+str(pontuacao)
	$ScoreLabel.position.x = 1152-2*$ScoreLabel.size.x-10
	#$ProportionLabel.text = "Proporção: "+str(snapped(proporcao, 0.001))
	#$ProportionLabel.position.x = 1152-2*$ProportionLabel.size.x-10


func _on_timer_timeout() -> void:
	var lixo = lixo_scene.instantiate()
	var posicao = gerar_posicao_lixo()
	lixo.iniciar(posicao)
	add_child(lixo)


func gerar_posicao(num):
	var x = randf_range(80+200*num, 280+200*num)
	var y = randf_range(150, 450)
	for i in pos_plataformas:
		if abs(i[0]-x)<354 and abs(i[1]-y)<80:
			return gerar_posicao(num)
	return Vector2(x, y)


func gerar_posicao_lixo():
	var pos_base = pos_plataformas.pick_random()
	var valor_x = randf_range(pos_base[0]-120, pos_base[0]+120)
	var valor_y = randf_range(pos_base[1]-30, pos_base[1]-100)
	var posicao = Vector2(valor_x, valor_y)
	return posicao
