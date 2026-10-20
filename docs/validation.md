# Verificação desta entrega

Validado com GameMaker LTS 2026, runtime `2026.0.0.23`, em Windows.

- Compilação VM concluída pelo Igor, sem erros de GML ou de leitura dos recursos.
- Verificador local: 40 recursos registrados, 31 categorias e 11 rooms, com referências, eventos, imagens e glifos em português válidos.
- Execução real: tela inicial, seleção de modos, preparação Solo e Local, seleção de Lê e da segunda fase, apresentação da fase e aviso de Rede.
- Navegação por teclado, retorno, volume, visibilidade das dicas, cancelamento e confirmação de saída conferidos em execução.
- Tela cheia acionou a troca de estado no runner; a captura em segundo plano não pôde conferir o resultado visual desse modo.
- As capturas em `docs/images` mostram telas do executável.

O ambiente de verificação restringe escrita fora do projeto. Por isso o runner não conseguiu criar sua pasta padrão em `%LOCALAPPDATA%/GameJam2026`; a persistência de `settings.ini` entre execuções precisa ser confirmada com **F5** no GameMaker fora desse ambiente. A aplicação das opções na sessão foi conferida.

Gamepads físicos, rede e gameplay não foram testados. A leitura de gamepad é uma base de entrada; a conexão LAN e as mecânicas de fase ainda não estão implementadas.
