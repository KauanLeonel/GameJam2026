// These rooms are planning previews until the gameplay milestone is implemented.
for (var _i = 0; _i < array_length(global.levels); ++_i) {
    if (global.levels[_i].room_asset == room) global.session.level_index = _i;
}
level_config = global.levels[global.session.level_index];
delivered_count = 0;
overflow_time = 0;
failed = false;
event_inherited();
