@JS()
library app;

import 'dart:js';
import 'dart:js_util';

import 'package:js/js.dart';

@JS('requestAuth')
external void requestAuth();

@JS('onPageLoad')
external void onPageLoad();

@JS('setCurrentPlaylist')
external void setCurrentPlaylist(String playlistId);

@JS('tempStorage')
external JsObject getTemp();

@JS('getUsername')
external String getUsername();

@JS('getProfilePicture')
external String getProfilePicture();

@JS('getPlaylists')
external JsObject getPlaylists();

@JS('setAttribute')
external void setAttribute(String attr, double minRange, double maxRange);
// attr = "danceability", "energy", "artist", or "genre". min and maxrange are used for danceability and energy

@JS('getValue')
external dynamic getValue();
