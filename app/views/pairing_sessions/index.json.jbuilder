json.results json.partial!("results.html.erb", pairing_sessions: @pairing_sessions, pairing_request: @pairing_request, pairing_session: @pairing_session, pairing_sessions_for_map: @pairing_sessions_for_map)
json.map json.partial!("map.html.erb", markers: @markers)
