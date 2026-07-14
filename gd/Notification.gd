extends Node

@onready var panel = $CanvasLayer/Panel
@onready var label = $CanvasLayer/Panel/Label

func show_message(text):
	label.text = text
	panel.visible = true

	await get_tree().create_timer(3).timeout

	panel.visible = false
	
"""
~ go_home
do SaveManager.set_checkpoint("go_home")
do SceneController.fade_to_black()
-- Home animation

Você deixou sua chave cair após abrir lentamente a porta. E com uma brecha Felix fugiu. 
{{GameData.player_name}}: Porque isso, Felix? Isso nunca havia acontecido. ele foi para a floresta, um perigo. Vou atras dele antes que anoiteça.

Você entra na floresta, mas não há muitas pistas de por onde o Felix foi, nenhum barulho estranho ou miados.

Então, você continua andando por uma trilha e se depara com um ser brilhante. 

-- img da fada

???: Fuja, ele está vindo!

O ser que brilha parece estar assutado e cançado.

- Fugir sem perguntar
=> fugir

- Questionar sobre
=> questionar

~ fugir
Você se afasta do ser e busca retornar por onde veio e se questiona se Felix está bem

~ questionar
{{GameData.player_name}}: Fugir do quem? O que é você? 

-- som de uivo ou barulho de animal selvagem

-- A besta aparece

[shake rate=20 level=10]
Seu coração acelera e você começa a tremer.
[/shake]

A besta tenta capturar o ser de luz. O ser de luz escapa e vai em sua direção. 

???: Corra!!!

Ambos fogem em direção a estrada e você entra em casa desesperado. O ser de luz te seguiu.

{{GameData.player_name}}: Isso só pode ser um grande pesadelo... Ou estou ficando louco

???: Obrigada pelo regufio, breve sonhador. 

{{GameData.player_name}}: ??? 
{{GameData.player_name}}: Pela Deusa... O QUE FOI TUDO ISSO???

???: Me chamo Ello
Ello: Sou um protetor/ guardião dos sonhos. Meu dever é proteger os sonhos das pessoas

--- animação

Ello: Eu estava monitorando os sonhos das pessoas, mas com o tempo não haviam mais sonhos para cuidar...
Ello: Então, pensei que poderia ser bom conseguir restaurar os sonhos das pessoas e o jeito mais fácil é vir para cá...Mas infelizmente as bestas vinda dos pesadelos tambem tomaram forma

{{GameData.player_name}}: Espera...tipo os contos que eu ouvia quando criança...?
	
Ello: Acho que sim...Frequentemente os povos tem formas e formas de representar os seres que trabalham para a manutenção dos sonhos
Ello: A besta que me perseguia queria meus poderes e não vai deixar de tentar devorar os sonhos que ainda restam...imagino que aqui estejamos seguros, eles gostam da escuridão é mais facil de manipular o que está diante de seus olhos, assim deixam os vivos pertubados para atormenta-los em seus pesadelos
Ello: Temo pela vida dos animais na floresta...

{{GameData.player_name}}: [shake rate=20 level=10] E meu gato? Meu Felix está em perigo!? E agora? [/shake]

Ello: Acho melhor não voltarmos a floresta, é perigoso demais...Posso tentar proteger os sonhos dele e ele estará seguro

{{GameData.player_name}}: Não sei não... Qual a pior coisa que aquela besta pode fazer?

Ello:...Talvez, corromper o resto do mundo, enchendo todos de loucuras e pertubações

Ello: Preciso descansar... Ser quase devorado e tentar sobreviver não é fácil

Ello vai descansar na sala. Você retorna ao seu quarto esperando que o Felix, esteja bem

if GameData.last_person_texted & var morning_route := "sleep_more" == "mary"
	Your phone lights up.

	Mary: Sorry, I was working earlier.
	- Respodender a mensagem
	=> reply
	
	- Não responder 
	=> no_reply

if GameData.last_person_texted & var morning_route := "breakfast" == "gio"
	Your phone lights up.
	Gio: I found something interesting in that old book.
	
	- Respodender a mensagem
	=> reply
	
	- Não responder 
	=> no_reply
	
	~ reply
if GameData.last_person_texted & var morning_route := "breakfast" == "gio"
{{GameData.player_name}}: Eu descobri algo que você não vai acreditar...

	=> sonhar

	~ no reply
	Você fica no celular e acaba no sono 
	=> sonhar
	
	~ sonhar
	A tela fica escura
	
	Você aparece em algum lugar desconhecido, parece um cassino...
	
	-- animação começa...
	-- som começa parecendo de vegas ou mario odissey
	
	{{GameData.player_name}}: Onde estou? Como vim parar aqui?? 
	
	Besta: Seja bem-vindo...caro visitante sonhador
	Besta: Se aproxime, aposte, aposte...Quanto deseja alçancar?
	
	
"""
