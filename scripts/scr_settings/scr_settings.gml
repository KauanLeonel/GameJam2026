function settings_load() {
    var _settings = { master_volume: 0.8, fullscreen: false, show_hints: true };
    if (file_exists("settings.ini")) {
        ini_open("settings.ini");
        _settings.master_volume = clamp(ini_read_real("audio", "master_volume", 0.8), 0, 1);
        _settings.fullscreen = ini_read_real("display", "fullscreen", 0) != 0;
        _settings.show_hints = ini_read_real("accessibility", "show_hints", 1) != 0;
        ini_close();
    }
    return _settings;
}

function settings_apply() {
    audio_master_gain(global.settings.master_volume);
    window_set_fullscreen(global.settings.fullscreen);
}

function settings_save() {
    ini_open("settings.ini");
    ini_write_real("audio", "master_volume", global.settings.master_volume);
    ini_write_real("display", "fullscreen", global.settings.fullscreen);
    ini_write_real("accessibility", "show_hints", global.settings.show_hints);
    ini_close();
}
