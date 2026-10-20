/// Shared identifiers. Resource names and code stay in English; UI text stays in pt-BR.
enum GameMode { Solo, LocalCoop, NetworkCoop }
enum WasteType { Paper, Plastic, Glass, Metal }
enum NetworkState { Disconnected, Hosting, Connecting, Connected }

#macro GUI_WIDTH 1280
#macro GUI_HEIGHT 720
#macro PLAYER_SPEED 220
#macro INTERACTION_RADIUS 64
#macro NETWORK_PORT 6510
#macro NETWORK_PROTOCOL_VERSION 1

function game_mode_name(_mode) {
    switch (_mode) {
        case GameMode.Solo: return "Solo";
        case GameMode.LocalCoop: return "Co-op Local";
        case GameMode.NetworkCoop: return "Co-op Rede";
    }
    return "Solo";
}

/// Recycling is counted only after a delivery, never when moving waste between containers.
function level_star_count(_delivered, _thresholds, _failed) {
    if (_failed) return 0;
    var _stars = 0;
    for (var _i = 0; _i < array_length(_thresholds); ++_i) {
        if (_delivered >= _thresholds[_i]) _stars += 1;
    }
    return _stars;
}
