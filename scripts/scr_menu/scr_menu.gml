function menu_button(_left, _top, _width, _height, _label, _detail, _action) {
    return { left: _left, top: _top, right: _left + _width, bottom: _top + _height,
        label: _label, detail: _detail, action: _action };
}

function menu_build_buttons() {
    buttons = [];
    switch (room) {
        case rm_main_menu:
            buttons = [
                menu_button(80, 354, 380, 66, "Jogar", "", "play"),
                menu_button(80, 434, 380, 66, "Opções", "", "options"),
                menu_button(80, 514, 380, 66, "Sair", "", "exit")
            ];
            break;
        case rm_mode_select:
            buttons = [
                menu_button(64, 234, 368, 290, "Solo", "Uma cientista, muitas ideias.\nOrganize a coleta no seu ritmo.", "solo"),
                menu_button(456, 234, 368, 290, "Co-op Local", "Duas cientistas no mesmo PC.\nDividam as tarefas e os desafios.", "local"),
                menu_button(848, 234, 368, 290, "Co-op Rede", "Cooperação na mesma rede.\nConexão em desenvolvimento.", "network"),
                menu_button(64, 574, 190, 56, "Voltar", "", "back")
            ];
            break;
        case rm_options:
            buttons = [
                menu_button(80, 218, 620, 74, "Volume geral: " + string(round(global.settings.master_volume * 100)) + "%", "Setas para ajustar; clique para aumentar.", "volume"),
                menu_button(80, 306, 620, 74, "Tela cheia: " + (global.settings.fullscreen ? "Ligada" : "Desligada"), "", "fullscreen"),
                menu_button(80, 394, 620, 74, "Dicas de navegação: " + (global.settings.show_hints ? "Ligadas" : "Desligadas"), "", "hints"),
                menu_button(80, 514, 240, 60, "Voltar", "", "back")
            ];
            break;
        case rm_game_setup:
            for (var _i = 0; _i < array_length(global.characters); ++_i) {
                array_push(buttons, menu_button(64 + _i * 154, 214, 138, 142, global.characters[_i].name, "", "character_" + string(_i)));
            }
            for (var _i = 0; _i < array_length(global.levels); ++_i) {
                array_push(buttons, menu_button(64 + _i * 234, 452, 216, 130, "0" + string(_i + 1), global.levels[_i].location, "level_" + string(_i)));
            }
            array_push(buttons, menu_button(64, 610, 190, 56, "Voltar", "", "back"));
            array_push(buttons, menu_button(948, 610, 268, 56, "Ver fase", "", "preview"));
            break;
        case rm_network_lobby:
            buttons = [menu_button(80, 558, 250, 60, "Voltar aos modos", "", "back")];
            break;
        default:
            buttons = [menu_button(80, 592, 280, 60, "Voltar à preparação", "", "back")];
            break;
    }
}

function menu_adjust_volume(_change) {
    global.settings.master_volume = clamp(round((global.settings.master_volume + _change) * 10) / 10, 0, 1);
    settings_apply();
    settings_save();
    menu_build_buttons();
}

function menu_back() {
    switch (room) {
        case rm_main_menu: exit_dialog = true; dialog_focus = 1; break;
        case rm_options: settings_save(); room_goto(rm_main_menu); break;
        case rm_mode_select: room_goto(rm_main_menu); break;
        case rm_game_setup:
        case rm_network_lobby: room_goto(rm_mode_select); break;
        default: room_goto(rm_game_setup); break;
    }
}

function menu_activate(_action) {
    switch (_action) {
        case "play": room_goto(rm_mode_select); break;
        case "options": room_goto(rm_options); break;
        case "exit": exit_dialog = true; dialog_focus = 1; break;
        case "back": menu_back(); break;
        case "solo":
            global.session.mode = GameMode.Solo;
            global.session.player_count = 1;
            room_goto(rm_game_setup);
            break;
        case "local":
            global.session.mode = GameMode.LocalCoop;
            global.session.player_count = 2;
            room_goto(rm_game_setup);
            break;
        case "network":
            global.session.mode = GameMode.NetworkCoop;
            room_goto(rm_network_lobby);
            break;
        case "volume": menu_adjust_volume(global.settings.master_volume >= 1 ? -1 : 0.1); break;
        case "fullscreen":
            global.settings.fullscreen = !global.settings.fullscreen;
            settings_apply(); settings_save(); menu_build_buttons();
            break;
        case "hints":
            global.settings.show_hints = !global.settings.show_hints;
            settings_save(); menu_build_buttons();
            break;
        case "preview": room_goto(global.levels[global.session.level_index].room_asset); break;
        default:
            if (string_pos("character_", _action) == 1) global.session.character_index = real(string_delete(_action, 1, 10));
            if (string_pos("level_", _action) == 1) global.session.level_index = real(string_delete(_action, 1, 6));
            break;
    }
}
