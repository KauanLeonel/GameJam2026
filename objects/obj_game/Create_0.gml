if (instance_number(obj_game) > 1) {
    instance_destroy();
    exit;
}

display_set_gui_size(GUI_WIDTH, GUI_HEIGHT);
window_set_caption("Ciência que Recicla");
randomize();

global.settings = settings_load();
global.characters = game_create_characters();
global.levels = game_create_levels();
global.waste_types = game_create_waste_types();
global.session = { mode: GameMode.Solo, character_index: 0, level_index: 0, player_count: 1 };

// Baked font resources include the accented characters used by the Portuguese UI.
global.fonts = {
    small: fnt_ui_small,
    body: fnt_ui_body,
    button: fnt_ui_button,
    heading: fnt_ui_heading,
    title: fnt_ui_title
};
global.theme = {
    paper: make_color_rgb(247, 244, 231), ink: make_color_rgb(30, 66, 62),
    muted: make_color_rgb(83, 109, 99), green: make_color_rgb(41, 117, 89),
    mint: make_color_rgb(221, 233, 216), gold: make_color_rgb(235, 183, 76),
    line: make_color_rgb(204, 217, 201), white: make_color_rgb(255, 253, 245)
};
settings_apply();
room_goto(rm_main_menu);
