# Planejamento do jogo

Uma equipe de cientistas desenvolve robôs para ajudar a manter Caraguatatuba limpa. Todos os personagens são mulheres. Ju, Lê, Manu e Maria têm áreas de pesquisa complementares; os nomes, especialidades e textos podem ser ajustados em `scr_game_data`.

## Ciclo principal previsto

1. O dispenser recebe resíduos em intervalos definidos pela fase.
2. A cientista pega um resíduo e o leva à lixeira do tipo correto.
3. As lixeiras têm capacidade: seu conteúdo deve ser transferido ao caminhão compartilhado.
4. O caminhão tem capacidade limitada. Uma ação de despacho o envia à reciclagem.
5. A viagem converte a carga em reciclagem contabilizada; o caminhão fica indisponível até retornar.
6. Materiais recuperados fornecem peças para construir robôs nas bancadas.

O botão contextual deve pegar, depositar, transferir, fabricar ou despachar conforme o alvo próximo e o item carregado. Os detalhes de carregamento, prioridades e duração da fabricação ainda serão definidos durante o protótipo.

Dispenser cheio bloqueia novas entradas. Enquanto permanecer cheio, um temporizador de acúmulo avança; ao liberar espaço ele volta a zero. Exceder a tolerância encerra a fase com zero estrelas. Lixeira cheia e caminhão cheio bloqueiam depósitos, sem apagar resíduos. Caminhão ausente bloqueia carga e despacho.

Para o primeiro protótipo, propõe-se contar a carga como reciclada na conclusão da viagem. Transferências internas nunca geram pontos. Ao terminar o tempo, a quantidade entregue define 0–3 estrelas. A função `level_star_count` já expressa os limiares e garante zero em caso de derrota.

## Progressão proposta

| Fase | Local | Introdução |
| --- | --- | --- |
| 1 | Praia do Centro | Tutorial de movimento, ação, separação, capacidades e caminhão |
| 2 | Oficina no Centro | Recuperar peças e fabricar a primeira robô |
| 3 | Bairro Indaiá | Bancadas separadas e passagem de itens; passagem acessível no solo |
| 4 | Praça Cândido Mota | Coordenar rotas, robôs e viagens do caminhão |
| 5 | Central de reciclagem | Fluxo intenso e montagem do sistema automático |

Os locais são propostas de ambientação. A oficina e a central são cenários ficcionais; não representam estabelecimentos reais. Os valores de duração, capacidades, fluxo e estrelas em `scr_game_data` são pontos de partida para testes.

Ao concluir a jornada, as cientistas combinam o que desenvolveram em um programa capaz de separar os resíduos automaticamente. Essa sequência final ainda será implementada.

## Próximas entregas

1. Protótipo solo da fase 1 com personagem, colisões, ação contextual, coleta e caminhão.
2. Condições de derrota, cronômetro, estrelas, resultado e progresso salvo.
3. Segunda jogadora local e seleção completa da equipe.
4. Peças, bancadas e robôs ajudantes.
5. Layouts das fases 2–5 e adaptação solo das bancadas separadas.
6. Cooperação LAN e sincronização pela anfitriã.
7. Artes, animações, áudio e final narrativo.
