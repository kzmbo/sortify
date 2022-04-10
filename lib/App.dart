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
<<<<<<< Updated upstream
external Map<String, dynamic> getPlaylists();
=======
external JsObject getPlaylists();

@JS('setAttribute')
external void setAttribute(String attr, double minRange, double maxRange);
// attr = "danceability", "energy", "artist", or "genre". min and maxrange are used for danceability and energy

@JS()

/// A workaround to deep-converting an object from JS to a Dart Object.
Object jsToDart(jsObject) {
  if (jsObject is JsArray || jsObject is Iterable) {
    return jsObject.map(jsToDart).toList();
  }
  if (jsObject is JsObject) {
    return Map.fromIterable(
      getObjectKeys(jsObject),
      value: (key) => jsToDart(jsObject[key]),
    );
  }
  return jsObject;
}

List<String> getObjectKeys(JsObject object) => context['Object']
    .callMethod('getOwnPropertyNames', [object])
    .toList()
    .cast<String>();
>>>>>>> Stashed changes
