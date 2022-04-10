@JS()
library app;

import 'package:js/js.dart';

@JS('requestAuth')
external void requestAuth();

@JS('onPageLoad')
external void onPageLoad();

@JS('setCurrentPlaylist')
external void setCurrentPlaylist(String playlistId);

@JS('tempStorage')
external dynamic temp;

@JS('getUsername')
external String getUsername();

@JS('getProfilePicture')
external String getProfilePicture();

@JS('getPlaylists')
external Map<String, dynamic> getPlaylists();
