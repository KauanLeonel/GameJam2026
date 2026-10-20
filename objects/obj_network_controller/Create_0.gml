// Data contract only. No socket is opened until LAN multiplayer is implemented.
connection_state = NetworkState.Disconnected;
socket_id = -1;
port = NETWORK_PORT;
protocol_version = NETWORK_PROTOCOL_VERSION;
peers = [];
