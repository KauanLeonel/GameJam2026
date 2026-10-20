# Arquitetura

## Inicialização e navegação

`rm_boot` cria `obj_game`, que é persistente e único. Ele carrega preferências, dados das cientistas, fases, tipos de resíduos, sessão e fontes. Em seguida abre `rm_main_menu`.

```text
rm_boot -> rm_main_menu
              |-- Jogar -> rm_mode_select
              |               |-- Solo ---------|
              |               |-- Co-op Local --|-> rm_game_setup -> rm_level_01...05
              |               |-- Co-op Rede ------> rm_network_lobby
              |-- Opções -> rm_options
              |-- Sair -> confirmação
```

`obj_menu` mantém foco, mouse e modal. A entrada é lida no Step; o Draw GUI apenas desenha. As coordenadas são lógicas, em 1280 × 720, e o mouse é convertido para o mesmo espaço. Teclado e controle mantêm o foco quando o mouse está parado.

`scr_menu` cria os botões e executa ações. `scr_ui` reúne os componentes visuais e as telas. Ao adicionar um menu, crie sua room e registre seu comportamento nesses dois scripts.

As rooms de fase usam `obj_level_controller`, que herda de `obj_menu` apenas nesta etapa de apresentação. Ao implementar o gameplay, remova essa herança e substitua a apresentação pelos eventos próprios de simulação e HUD.

## Estado

- `global.settings`: preferências persistidas por INI.
- `global.session`: modo, quantidade de jogadoras, cientista em consulta e fase selecionada. A escolha da equipe completa ainda será implementada.
- `global.characters`, `global.levels`, `global.waste_types`: definições, criadas em `scr_game_data`.
- `global.theme`, `global.fonts`: desenho da interface; fontes bitmap são recursos gerenciados pelo GameMaker.

## Objetos reservados para o gameplay

| Objeto | Contrato inicial |
| --- | --- |
| `obj_actor` | Velocidade, direção e item carregado |
| `obj_player` | Índice da jogadora, controle e personagem |
| `obj_robot` | Estação designada e estado de montagem |
| `obj_interactable` | Alcance e método `interact(player)` |
| `obj_dispenser` | Fila, capacidade, intervalo e tolerância ao acúmulo |
| `obj_bin` | Tipo aceito, capacidade e quantidade |
| `obj_truck` | Capacidade compartilhada, viagem e retorno |
| `obj_workbench` | Peças e progresso da fabricação |
| `obj_transfer_counter` | Item apoiado e passagem para solo |
| `obj_waste` | Tipo, portadora e peças recuperáveis |
| `obj_network_controller` | Estado, porta, versão de protocolo e pares |

Os filhos de `obj_interactable` herdam `interact`, que retorna `false` até ser implementado. Nenhum desses objetos, além do controlador, é colocado nas apresentações das fases.

`input_player_read` já define movimento normalizado e uma ação: jogadora 1 usa WASD/E e jogadora 2 usa setas/Enter; também aceita um índice de gamepad. Ainda não existe movimentação de personagens.

## Multiplayer na mesma rede

A próxima implementação deve usar uma anfitriã autoritativa para filas, inventários, caminhão, tempo e pontuação. As clientes enviam intenções; a anfitriã valida interações e transmite o estado. Não contar reciclagem nas clientes de forma independente.

Antes de ativar esse modo, implementar sala, entrada por IP, validação do protocolo, identificação das jogadoras, desconexão e sincronização. O objeto atual não abre sockets e a tela não oferece conexão fictícia.
