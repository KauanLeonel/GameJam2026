/// Menu input is separate from player input so the future game can share one action key.
function input_menu_read() {
    var _input = {
        next: keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")),
        previous: keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")),
        left: keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")),
        right: keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")),
        confirm: keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space),
        back: keyboard_check_pressed(vk_escape)
    };
    for (var _pad = 0; _pad < 12; ++_pad) {
        if (!gamepad_is_connected(_pad)) continue;
        _input.next = _input.next || gamepad_button_check_pressed(_pad, gp_padd);
        _input.previous = _input.previous || gamepad_button_check_pressed(_pad, gp_padu);
        _input.left = _input.left || gamepad_button_check_pressed(_pad, gp_padl);
        _input.right = _input.right || gamepad_button_check_pressed(_pad, gp_padr);
        _input.confirm = _input.confirm || gamepad_button_check_pressed(_pad, gp_face1);
        _input.back = _input.back || gamepad_button_check_pressed(_pad, gp_face2);
    }
    return _input;
}

/// Reserved gameplay bindings: WASD + E / arrows + Enter, or stick + A/cross.
function input_player_read(_player_index, _gamepad_index = -1) {
    var _second = _player_index == 1;
    var _horizontal = keyboard_check(_second ? vk_right : ord("D")) - keyboard_check(_second ? vk_left : ord("A"));
    var _vertical = keyboard_check(_second ? vk_down : ord("S")) - keyboard_check(_second ? vk_up : ord("W"));
    var _action = keyboard_check_pressed(_second ? vk_enter : ord("E"));
    if (_gamepad_index >= 0 && gamepad_is_connected(_gamepad_index)) {
        var _axis_x = gamepad_axis_value(_gamepad_index, gp_axislh);
        var _axis_y = gamepad_axis_value(_gamepad_index, gp_axislv);
        _horizontal += abs(_axis_x) > 0.2 ? _axis_x : 0;
        _vertical += abs(_axis_y) > 0.2 ? _axis_y : 0;
        _horizontal += gamepad_button_check(_gamepad_index, gp_padr) - gamepad_button_check(_gamepad_index, gp_padl);
        _vertical += gamepad_button_check(_gamepad_index, gp_padd) - gamepad_button_check(_gamepad_index, gp_padu);
        _action = _action || gamepad_button_check_pressed(_gamepad_index, gp_face1);
    }
    var _length = max(1, sqrt(sqr(_horizontal) + sqr(_vertical)));
    return { move_x: _horizontal / _length, move_y: _vertical / _length, action_pressed: _action };
}
