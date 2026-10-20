elapsed += min(delta_time / 1000000, 0.1);
var _input = input_menu_read();
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _mouse_moved = _mx != mouse_previous_x || _my != mouse_previous_y;
mouse_previous_x = _mx;
mouse_previous_y = _my;

if (exit_dialog) {
    if (_input.left || _input.right || _input.next || _input.previous) dialog_focus = 1 - dialog_focus;
    if (_mouse_moved && point_in_rectangle(_mx, _my, 418, 391, 602, 449)) dialog_focus = 0;
    if (_mouse_moved && point_in_rectangle(_mx, _my, 626, 391, 862, 449)) dialog_focus = 1;
    if (_input.back) { exit_dialog = false; exit; }
    var _clicked = mouse_check_button_pressed(mb_left);
    if (_clicked) {
        if (point_in_rectangle(_mx, _my, 418, 391, 602, 449)) { settings_save(); game_end(); }
        if (point_in_rectangle(_mx, _my, 626, 391, 862, 449)) exit_dialog = false;
    } else if (_input.confirm) {
        if (dialog_focus == 0) { settings_save(); game_end(); }
        else exit_dialog = false;
    }
    exit;
}

if (_input.back) { menu_back(); exit; }
var _volume_adjustment = room == rm_options && focus_index == 0 && (_input.left || _input.right);
if (_volume_adjustment) {
    menu_adjust_volume(_input.right ? 0.1 : -0.1);
} else {
    var _direction = (_input.next || _input.right) - (_input.previous || _input.left);
    if (_direction != 0) focus_index = (focus_index + _direction + array_length(buttons)) mod array_length(buttons);
}

var _hover_index = -1;
for (var _i = 0; _i < array_length(buttons); ++_i) {
    var _button = buttons[_i];
    if (point_in_rectangle(_mx, _my, _button.left, _button.top, _button.right, _button.bottom)) {
        _hover_index = _i;
        if (_mouse_moved) focus_index = _i;
        break;
    }
}
if (mouse_check_button_pressed(mb_left)) {
    if (_hover_index >= 0) { focus_index = _hover_index; menu_activate(buttons[focus_index].action); }
} else if (_input.confirm && !_volume_adjustment) {
    menu_activate(buttons[focus_index].action);
}
