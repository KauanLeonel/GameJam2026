function ui_panel(_left, _top, _right, _bottom, _color, _outline = false) {
    draw_set_color(_color);
    draw_roundrect_ext(_left, _top, _right, _bottom, 14, 14, _outline);
}

function ui_text(_x, _y, _text, _font, _color, _width = -1) {
    draw_set_font(_font);
    draw_set_color(_color);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    if (_width > 0) draw_text_ext(_x, _y, _text, -1, _width);
    else draw_text(_x, _y, _text);
}

function ui_header(_eyebrow, _title, _subtitle) {
    ui_text(64, 42, _eyebrow, global.fonts.small, global.theme.green);
    ui_text(64, 76, _title, global.fonts.heading, global.theme.ink);
    ui_text(64, 136, _subtitle, global.fonts.body, global.theme.muted);
}

function ui_scientist(_x, _y, _scale, _color, _variant) {
    // Geometric placeholder portrait; replace with animated sprites during the art milestone.
    draw_set_color(global.theme.ink);
    draw_circle(_x, _y - 22 * _scale, 23 * _scale, false);
    draw_set_color(make_color_rgb(181 + _variant * 13, 117 + _variant * 12, 83 + _variant * 10));
    draw_circle(_x, _y - 17 * _scale, 16 * _scale, false);
    draw_set_color(global.theme.ink);
    draw_circle(_x - 11 * _scale, _y - 36 * _scale, 12 * _scale, false);
    ui_panel(_x - 29 * _scale, _y + 6 * _scale, _x + 29 * _scale, _y + 58 * _scale, global.theme.white);
    draw_set_color(_color);
    draw_triangle(_x - 10 * _scale, _y + 7 * _scale, _x + 10 * _scale, _y + 7 * _scale, _x, _y + 43 * _scale, false);
    draw_set_color(global.theme.ink);
    draw_rectangle(_x - 23 * _scale, _y - 24 * _scale, _x - 2 * _scale, _y - 11 * _scale, true);
    draw_rectangle(_x + 2 * _scale, _y - 24 * _scale, _x + 23 * _scale, _y - 11 * _scale, true);
    draw_line(_x - 2 * _scale, _y - 18 * _scale, _x + 2 * _scale, _y - 18 * _scale);
}

function ui_coastal_scene(_time) {
    var _ink = global.theme.ink;
    ui_panel(646, 118, 1220, 604, make_color_rgb(221, 236, 223));
    draw_set_color(global.theme.gold);
    draw_circle(1100, 206, 47, false);
    draw_set_color(make_color_rgb(172, 199, 173));
    draw_triangle(650, 370, 799, 211, 983, 370, false);
    draw_set_color(make_color_rgb(144, 182, 160));
    draw_triangle(810, 370, 971, 251, 1150, 370, false);
    draw_set_color(make_color_rgb(127, 186, 186));
    draw_rectangle(648, 350, 1218, 445, false);
    draw_set_color(make_color_rgb(215, 235, 220));
    for (var _i = 0; _i < 6; ++_i) {
        var _wx = 681 + _i * 89 + sin(_time + _i) * 5;
        draw_line_width(_wx, 386 + (_i mod 2) * 24, _wx + 42, 386 + (_i mod 2) * 24, 2);
    }
    ui_panel(648, 434, 1218, 602, make_color_rgb(235, 220, 180));
    // Shared collection truck.
    ui_panel(1036, 371, 1141, 432, global.theme.green);
    ui_panel(1140, 392, 1183, 432, global.theme.green);
    ui_panel(1148, 397, 1176, 414, global.theme.mint);
    draw_set_color(_ink);
    draw_circle(1063, 436, 13, false);
    draw_circle(1157, 436, 13, false);
    ui_text(1051, 382, "COLETA", global.fonts.small, global.theme.white);
    // Four labeled bins: color is never the only identifier.
    for (var _i = 0; _i < 4; ++_i) {
        var _bx = 697 + _i * 107;
        var _type = global.waste_types[_i];
        ui_panel(_bx, 482, _bx + 82, 563, _type.color);
        ui_panel(_bx - 4, 475, _bx + 86, 487, _ink);
        draw_sprite_ext(_type.sprite, 0, _bx + 41, 515, 0.65, 0.65, 0, c_white, 1);
        ui_text(_bx + 8, 541, _type.label, global.fonts.small, global.theme.white);
    }
    ui_scientist(784, 402 + sin(_time * 2) * 2, 1, global.characters[0].color, 0);
    ui_scientist(922, 402 + sin(_time * 2 + 1) * 2, 1, global.characters[1].color, 1);
    // Friendly robot assistant.
    ui_panel(1130, 500, 1182, 550, global.theme.white);
    ui_panel(1127, 472, 1185, 507, _ink);
    draw_set_color(global.theme.gold);
    draw_circle(1144, 489, 5, false);
    draw_circle(1168, 489, 5, false);
    draw_set_color(_ink);
    draw_line_width(1156, 472, 1156, 459, 3);
    draw_circle(1156, 457, 4, false);
    draw_circle(1140, 557, 8, false);
    draw_circle(1173, 557, 8, false);
    ui_text(670, 141, "FEITO DE CIÊNCIA E COOPERAÇÃO", global.fonts.small, _ink);
}

function ui_draw_button(_button, _focused, _index) {
    var _selected = false;
    if (room == rm_game_setup) {
        _selected = _button.action == "character_" + string(global.session.character_index)
            || _button.action == "level_" + string(global.session.level_index);
    }
    var _large = room == rm_mode_select && _index < 3;
    var _character = room == rm_game_setup && _index < 4;
    var _phase = room == rm_game_setup && _index >= 4 && _index < 9;
    var _active = _focused || _selected;
    var _fill = _active ? global.theme.green : global.theme.white;
    var _text = _active ? global.theme.white : global.theme.ink;
    ui_panel(_button.left, _button.top + 4, _button.right, _button.bottom + 4, global.theme.line);
    ui_panel(_button.left, _button.top, _button.right, _button.bottom, _fill);
    if (_focused) ui_panel(_button.left - 4, _button.top - 4, _button.right + 4, _button.bottom + 4, global.theme.gold, true);
    if (_large) {
        var _cx = (_button.left + _button.right) * 0.5;
        ui_scientist(_cx - (_index == 1 ? 22 : 0), _button.top + 63, 0.65, global.characters[_index].color, _index);
        if (_index == 1) ui_scientist(_cx + 30, _button.top + 65, 0.65, global.characters[3].color, 3);
        ui_text(_button.left + 24, _button.top + 130, _button.label, global.fonts.button, _text);
        ui_text(_button.left + 24, _button.top + 178, _button.detail, global.fonts.body, _text, 320);
        ui_text(_button.left + 24, _button.bottom - 35, _index == 2 ? "EM DESENVOLVIMENTO" : (_index == 0 ? "1 JOGADORA" : "2 JOGADORAS"), global.fonts.small, _text);
    } else if (_character) {
        ui_scientist((_button.left + _button.right) * 0.5, _button.top + 47, 0.65, global.characters[_index].color, _index);
        ui_text(_button.left + 18, _button.bottom - 35, _button.label, global.fonts.button, _text);
    } else if (_phase) {
        ui_text(_button.left + 18, _button.top + 12, _button.label, global.fonts.heading, _text);
        ui_text(_button.left + 18, _button.top + 70, _button.detail, global.fonts.small, _text, 182);
    } else {
        var _offset = _button.detail == "" ? 15 : 7;
        ui_text(_button.left + 24, _button.top + _offset, _button.label, global.fonts.button, _text);
        if (_button.detail != "") ui_text(_button.left + 24, _button.top + 44, _button.detail, global.fonts.small, _text);
    }
}

function menu_draw_screen() {
    draw_set_alpha(1);
    draw_clear(global.theme.paper);
    switch (room) {
        case rm_main_menu:
            ui_text(80, 64, "CARAGUATATUBA  /  CIÊNCIA EM EQUIPE", global.fonts.small, global.theme.green);
            ui_text(76, 130, "Ciência que\nRecicla", global.fonts.title, global.theme.ink);
            ui_text(80, 286, "Grandes ideias. Uma cidade mais limpa.", global.fonts.body, global.theme.muted);
            ui_coastal_scene(elapsed);
            ui_text(80, 617, "Juntas, a gente transforma o futuro.", global.fonts.small, global.theme.muted);
            break;
        case rm_mode_select:
            ui_header("VAMOS CUIDAR DA CIDADE", "Como vamos jogar?", "Escolha como reunir sua equipe de cientistas.");
            break;
        case rm_options:
            ui_header("DO SEU JEITO", "Opções", "As alterações são salvas automaticamente.");
            ui_panel(770, 218, 1216, 574, global.theme.mint);
            ui_text(802, 250, "Poucos comandos,\nmuitas possibilidades.", global.fonts.button, global.theme.ink);
            ui_text(802, 350, "No jogo, cada cientista vai precisar apenas de movimento e um botão de ação.", global.fonts.body, global.theme.muted, 370);
            ui_text(802, 464, "O volume já fica salvo para quando os sons forem adicionados.", global.fonts.small, global.theme.muted, 370);
            break;
        case rm_game_setup:
            ui_header(game_mode_name(global.session.mode) + "  /  PREPARAÇÃO", "Conheça a equipe", "Explore as cientistas e os locais da nossa jornada.");
            var _character = global.characters[global.session.character_index];
            ui_panel(718, 206, 1216, 392, global.theme.mint);
            ui_text(742, 222, _character.name + "  /  " + _character.field, global.fonts.button, global.theme.ink);
            ui_text(742, 271, _character.bio, global.fonts.small, global.theme.muted, 450);
            ui_text(64, 376, "Comandos previstos: " + (global.session.mode == GameMode.Solo ? "WASD + E" : "WASD + E  /  Setas + Enter"), global.fonts.small, global.theme.muted);
            ui_text(64, 415, "CINCO LUGARES, UMA MISSÃO", global.fonts.small, global.theme.green);
            var _level = global.levels[global.session.level_index];
            ui_text(294, 626, "Selecionada: " + _level.title, global.fonts.small, global.theme.muted);
            break;
        case rm_network_lobby:
            ui_header("CO-OP REDE", "A ciência conecta", "Uma equipe em computadores diferentes, na mesma rede local.");
            ui_panel(80, 222, 1200, 508, global.theme.mint);
            ui_text(112, 252, "Conexão em desenvolvimento", global.fonts.heading, global.theme.ink);
            ui_text(112, 328, "Este modo terá criação de sala e entrada pelo endereço da anfitriã. A conexão e a sincronização das jogadoras serão implementadas em uma próxima etapa.", global.fonts.body, global.theme.muted, 990);
            ui_text(112, 442, "Por enquanto, conheça a equipe e as fases nas opções Solo e Co-op Local.", global.fonts.body, global.theme.ink, 990);
            break;
        default:
            var _level = global.levels[global.session.level_index];
            ui_header("FASE " + string(global.session.level_index + 1) + "  /  " + _level.location, _level.title, "Cenário em preparação");
            ui_panel(80, 212, 770, 552, global.theme.white);
            ui_text(108, 236, _level.mechanic, global.fonts.button, global.theme.ink);
            ui_text(108, 292, _level.summary, global.fonts.body, global.theme.muted, 620);
            ui_text(108, 418, "A coleta, os robôs e o caminhão serão construídos na próxima etapa. Esta tela apresenta o planejamento da fase.", global.fonts.body, global.theme.green, 620);
            ui_panel(800, 212, 1200, 552, global.theme.mint);
            ui_text(828, 240, "METAS PREVISTAS", global.fonts.small, global.theme.green);
            ui_text(828, 285, "1 estrela: " + string(_level.star_thresholds[0]) + " resíduos\n2 estrelas: " + string(_level.star_thresholds[1]) + " resíduos\n3 estrelas: " + string(_level.star_thresholds[2]) + " resíduos", global.fonts.button, global.theme.ink);
            ui_text(828, 420, "Duração: " + string(_level.duration) + " s\nCaminhão: " + string(_level.truck_capacity) + " resíduos\nRetorno: " + string(_level.truck_return_time) + " s", global.fonts.body, global.theme.muted);
            break;
    }

    for (var _i = 0; _i < array_length(buttons); ++_i) ui_draw_button(buttons[_i], focus_index == _i, _i);
    if (global.settings.show_hints) ui_text(64, 688, "MOUSE ou SETAS / WASD: navegar     ENTER / ESPAÇO: selecionar     ESC: voltar", global.fonts.small, global.theme.muted);

    if (exit_dialog) {
        draw_set_alpha(0.65);
        draw_set_color(global.theme.ink);
        draw_rectangle(0, 0, GUI_WIDTH, GUI_HEIGHT, false);
        draw_set_alpha(1);
        ui_panel(374, 242, 906, 488, global.theme.paper);
        ui_text(416, 275, "Encerrar por agora?", global.fonts.heading, global.theme.ink);
        ui_text(418, 343, "A cidade espera por você na próxima.", global.fonts.body, global.theme.muted);
        var _yes = menu_button(418, 391, 184, 58, "Sair", "", "");
        var _no = menu_button(626, 391, 236, 58, "Continuar", "", "");
        ui_draw_button(_yes, dialog_focus == 0, -1);
        ui_draw_button(_no, dialog_focus == 1, -1);
    }
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_alpha(1);
}
