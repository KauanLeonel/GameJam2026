/// Original fictional characters. Biographies are editable narrative proposals.
function game_create_characters() {
    return [
        { id: "ju", name: "Ju", field: "Engenharia ambiental", color: make_color_rgb(236, 171, 72),
          bio: "Ju transforma desafios ambientais em soluções para a cidade. Ela projeta sistemas de coleta e acredita que toda grande invenção começa com uma comunidade cuidando do lugar onde vive." },
        { id: "le", name: "Lê", field: "Robótica", color: make_color_rgb(111, 173, 188),
          bio: "Lê constrói robôs que tornam a limpeza mais acessível. No laboratório, ela recupera motores e sensores descartados para criar novas ferramentas ao lado de outras mulheres na ciência." },
        { id: "manu", name: "Manu", field: "Ciência dos materiais", color: make_color_rgb(195, 133, 161),
          bio: "Manu enxerga possibilidades no que foi descartado. Ela pesquisa como reaproveitar materiais e transforma peças recuperadas em componentes para os robôs da equipe." },
        { id: "maria", name: "Maria", field: "Computação", color: make_color_rgb(145, 166, 104),
          bio: "Maria cria programas que ajudam a cuidar de Caraguatatuba. Com criatividade e trabalho em equipe, ela desenvolve o sistema que vai ensinar os robôs a separar os resíduos." }
    ];
}

/// Initial balancing proposals. No level simulation is enabled in the menu milestone.
function game_create_levels() {
    return [
        { id: "beach", title: "Primeiros passos", location: "Praia do Centro", room_asset: rm_level_01_beach,
          summary: "Aprenda a andar, pegar resíduos e escolher a lixeira certa. Leve a coleta ao caminhão e envie para reciclagem.",
          mechanic: "Tutorial guiado", duration: 180, spawn_interval: 6, dispenser_capacity: 8,
          overflow_grace: 15, bin_capacity: 5, truck_capacity: 20, truck_return_time: 12,
          star_thresholds: [10, 20, 30], robots_enabled: false, split_workspaces: false, solo_bridge: false },
        { id: "workshop", title: "Ideias em movimento", location: "Oficina no Centro", room_asset: rm_level_02_workshop,
          summary: "Recupere peças na reciclagem e monte a primeira robô ajudante. Divida o tempo entre a coleta e a bancada.",
          mechanic: "Peças e construção de robôs", duration: 210, spawn_interval: 5, dispenser_capacity: 8,
          overflow_grace: 14, bin_capacity: 6, truck_capacity: 22, truck_return_time: 15,
          star_thresholds: [15, 30, 45], robots_enabled: true, split_workspaces: false, solo_bridge: false },
        { id: "neighborhood", title: "De mão em mão", location: "Bairro Indaiá", room_asset: rm_level_03_neighborhood,
          summary: "Bancadas separadas pedem cooperação: passe os materiais para a outra cientista. No solo, uma passagem conecta as áreas.",
          mechanic: "Bancadas e passagem de itens", duration: 210, spawn_interval: 4.5, dispenser_capacity: 9,
          overflow_grace: 12, bin_capacity: 6, truck_capacity: 24, truck_return_time: 16,
          star_thresholds: [20, 35, 50], robots_enabled: true, split_workspaces: true, solo_bridge: true },
        { id: "square", title: "Cidade em ação", location: "Praça Cândido Mota", room_asset: rm_level_04_square,
          summary: "Organize uma operação de limpeza na praça. Combine rotas de coleta, robôs ajudantes e viagens do caminhão.",
          mechanic: "Rotas e automação em conjunto", duration: 240, spawn_interval: 4, dispenser_capacity: 10,
          overflow_grace: 10, bin_capacity: 7, truck_capacity: 26, truck_return_time: 18,
          star_thresholds: [25, 45, 65], robots_enabled: true, split_workspaces: false, solo_bridge: false },
        { id: "recycling_center", title: "O futuro é coletivo", location: "Central de reciclagem", room_asset: rm_level_05_recycling_center,
          summary: "Encare o maior fluxo de resíduos e reúna as últimas peças. A equipe está perto de concluir seu sistema de separação automática!",
          mechanic: "Desafio final de automação", duration: 240, spawn_interval: 3, dispenser_capacity: 10,
          overflow_grace: 8, bin_capacity: 8, truck_capacity: 30, truck_return_time: 20,
          star_thresholds: [30, 55, 80], robots_enabled: true, split_workspaces: false, solo_bridge: false }
    ];
}

function game_create_waste_types() {
    return [
        { id: WasteType.Paper, label: "Papel", color: make_color_rgb(64, 135, 200), sprite: spr_waste_paper },
        { id: WasteType.Plastic, label: "Plástico", color: make_color_rgb(207, 91, 86), sprite: spr_waste_plastic },
        { id: WasteType.Glass, label: "Vidro", color: make_color_rgb(66, 155, 118), sprite: spr_waste_glass },
        { id: WasteType.Metal, label: "Metal", color: make_color_rgb(222, 174, 56), sprite: spr_waste_metal }
    ];
}
