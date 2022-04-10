const get_user_prof = "https://api.spotify.com/v1/users/";
const get_track_audio_features = "https://api.spotify.com/v1/audio-features/";
const remove_playlist = "https://api.spotify.com/v1/playlists/";
const post_delete_to_playlist = "https://api.spotify.com/v1/playlists/";
const post_new_playlist = "https://api.spotify.com/v1/users/";
const get_current_user_id = "https://api.spotify.com/v1/me";
const get_playlist_items = "https://api.spotify.com/v1/playlists/";
const get_playlists_uri = "https://api.spotify.com/v1/me/playlists"
const redirect_uri = "http://localhost:3000";
const client_id = config.id;
const client_secret = config.secret;
const TOKEN = "https://accounts.spotify.com/api/token";
var temp = {
  attribute: {},
  new_playlist_id: "",
  song_stack: [],
  current_playlist_id: "",
  display_name: "",
  profile_picture: "",
  track_features: [],
}

var access_token;
var refresh_token;
var user_id;

function getValue(value) {
  return Function("temp." + value);
}

function getTemp() {
  temp.display_name = localStorage.getItem("display_name");
  temp.profile_picture = localStorage.getItem("profile_picture");

  return temp;
}

function onPageLoad() {
  if (window.location.search.length > 0) {
    handleRedirect();
  }
}

function handleRedirect() {
  let code = getCode();
  fetchAccessToken(code);
  window.history.pushState("", "", redirect_uri);
}

//parses spotify auth code
function getCode() {
  let code = null;
  const queryString = window.location.search;
  if (queryString.length > 0) {

    const urlParams = new URLSearchParams(queryString);
    code = urlParams.get('code');

  }
  return code;
}

function setAttribute(attr, minRange, maxRange) {
  temp.attribute[0] = attr;
  temp.attribute[1] = minRange;
  temp.attribute[2] = maxRange;
}

//gets access token using auth code
function fetchAccessToken(code) {

  let body = "grant_type=authorization_code";
  body += "&code=" + code;
  body += "&redirect_uri=" + encodeURI(redirect_uri);
  body += "&client_id=" + client_id;
  body += "&client_secret=" + client_secret;
  callAuthorizationApi(body);

}
//refreshes token when expired
function refreshAccessToken() {
  refresh_token = localStorage.getItem("refresh_token");
  let body = "grant_type=refresh_token";
  body += "&refresh_token=" + refresh_token;
  body += "&client_id=" + client_id;
  callAuthorizationApi(body);
}

//calls for authorization
function callAuthorizationApi(body) {

  let xhr = new XMLHttpRequest();
  xhr.open("POST", TOKEN, true);
  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xhr.setRequestHeader("Authorization", "Basic " + btoa(client_id + ":" + client_secret));
  xhr.send(body);
  xhr.onload = handleAuthorizationResponse;
}
//handles response
function handleAuthorizationResponse() {
  if (this.status == 200) {
    var data = JSON.parse(this.responseText);
    console.log(data);
    if (data.access_token != undefined) {
      access_token = data.access_token;
      localStorage.setItem("access_token", access_token);
    }
    if (data.refresh_token != undefined) {
      refresh_token = data.refresh_token;
      localStorage.setItem("refresh_token", refresh_token);
    }
    getCurrentUserID();
  }
  else {
    //send back to dart for error message and handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}

//initial request for authorization
//have dart call this with "Login to Spotify" Button
function requestAuth() {
  let url = "https://accounts.spotify.com/authorize";
  url += "?client_id=" + client_id;
  url += "&response_type=code";
  url += "&redirect_uri=" + encodeURI(redirect_uri);
  url += "&showdialog=true";
  url += "&scope=playlist-modify-public playlist-read-private playlist-modify-private";
  window.location.href = url;
}
//general function for calling api
function callApi(method, endpoint, body, responseHandler) {
  let url = endpoint;
  let xhr = new XMLHttpRequest();
  xhr.open(method, url, true);
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.setRequestHeader("Authorization", "Bearer " + access_token);
  xhr.send(body);
  xhr.onload = responseHandler;
}
//gets playlists
//dart will call this to display playlists on sidebar
function getPlaylists() {
  callApi("GET", get_playlists_uri, null, handleGetPlaylistResponse);
}
//handles response for getplaylists
function handleGetPlaylistResponse() {
  if (this.status == 200) {
    var response = JSON.parse(this.responseText);
    //call dart to create dart objects with passed response.attribute parameters
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //return false to dart, have dart call getPlaylists again
  }
  else {
    //return to dart for error display and handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}
//getsPlaylistItems
//dart will use this whenever displaying tracks in a playlist
function getPlaylistItems(playlist_id) {
  callApi("GET", get_playlist_items +
    playlist_id + "/tracks?fields=items(track)",
    null, playlistItemResponseHandler);
}
//handles above function
function playlistItemResponseHandler() {
  if (this.status == 200) {
    var response = JSON.parse(this.responseText);
    console.log(response);
    response.items.forEach(element => {
      //call dart function createPlaylistItem(element.attribute1, element.attribute2, etc)
    })
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //have dart call getPlaylistItems again
  }
  else {
    console.log(this.responseText);
    alert(this.responseText);
  }
}
//used only internally
function getCurrentUserID() {
  callApi("GET", get_current_user_id, null, getCurrentUserIDResponseHandler);
}

function getCurrentUserIDResponseHandler() {
  if (this.status == 200) {
    var response = JSON.parse(this.responseText);
    console.log(response);
    if (response.id != undefined) {
      user_id = response.id;
      localStorage.setItem("user_id", user_id);
    }
    getUserProf(user_id);
  }
  else if (this.status == 401) {
    refreshAccessToken();
    getCurrentUserID();
  }
  else {
    //send back to dart for error handling
    console.log(this.message);
    alert(this.message);
  }
}

function setCurrentPlaylist(playlist_id) {
  temp.current_playlist_id = playlist_id;
}

function getUsername() {
  pass
}

function getProfilePicture() {
  pass
}

//called internally by this same file and by user when creating empty playlist
function postNewPlaylist(name, description, is_public) {
  if (user_id == undefined) {
    user_id = localStorage.getItem("user_id")
  }
  if (user_id == undefined) {
    getCurrentUserID();
  }
  let body = {
    name: name,
    description: description,
    public: is_public
  };
  callApi("POST", post_new_playlist + user_id + "/playlists", JSON.stringify(body), postNewPlaylistResponseHandler);
}

function postNewPlaylistResponseHandler() {
  if (this.status == 201) {
    //have dart update its UI elements to reflect change
    var response = JSON.parse(this.responseText);
    temp.new_playlist_id = response.id;
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //return to dart to retry playlist creation
  }
  else {
    //return to dart for error handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}

function postSongToPlaylist(songs_to_add_arr, playlist_id) {
  songs_to_add_arr.forEach((element, index) =>
    songs_to_add_arr[index] = "spotify:track:" + element);
  callApi("POST", post_delete_to_playlist + playlist_id + "/tracks?uris=" + encodeURI(songs_to_add_arr), null, postSongToPlaylistHandler);
}

function postSongToPlaylistHandler() {
  if (this.status == 201) {
    //have dart update its UI elements to reflect change
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //return to dart to retry
  }
  else {
    console.log(this.responseText);
    alert(this.responseText);
  }
}

function deleteItemFromPlaylist(songs_to_delete_arr, playlist_id) {
  let body = { tracks: [] }
  songs_to_delete_arr.forEach(element =>
    body.tracks.push({ uri: "spotify:track:" + element })
  );
  alert(JSON.stringify(body));
  callApi("DELETE", post_delete_to_playlist + playlist_id + "/tracks", JSON.stringify(body), deleteItemFromPlaylistResponseHandler);
}

function deleteItemFromPlaylistResponseHandler() {
  if (this.status == 200) {
    //have dart update its UI elements to reflect change
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //return to dart to retry delete
  }
  else {
    //return to dart for error handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}

function removePlaylist(playlist_id) {
  callApi("DELETE", remove_playlist + playlist_id + "/followers", null, removePlaylistResponseHandler);
}

function removePlaylistResponseHandler() {
  if (this.status == 200) {
    //have dart update its UI elements to reflect change
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //return to dart to retry delete
  }
  else {
    //return to dart for error handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}

function stackByAttribute() {
  if (this.status == 200) {
    var response = JSON.parse(this.responseText);
    console.log(response);
    let attribute = temp.attribute;
    //enumeration / if case statement, check for which attribute you need to check for
    //attribute[0] = "popularity", case(element.id), element.popularity, attribute[1] = value
    switch (attribute[0]) {
      case "energy":
        response.items.forEach(element => {
          getTrackAttributes(element.id);
          if (attribute[1] <= temp.track_features.energy <= attribute[2]) {
            temp.song_stack.push(element.id);
          }
        })
        break;
      case "danceability":
        response.items.forEach(element => {
          getTrackAttributes(element.id);
          if (attribute[1] <= temp.track_features.danceability <= attribute[2]) {
            temp.song_stack.push(element.id);
          }
        })
        break;
      case "artist":
        response.items.forEach(element => {
          if (attribute[1] == element.artists.id) {
            temp.song_stack.push(element.id);
          }
        })
        break;
      case "genre":
        response.items.forEach(element => {
          if (element.artists[0].genres.includes(attribute[1])) {
            temp.song_stack.push(element.id);
          }
        })
      default:
        // Impossible selection of attribute?
        console.log("oopsie woopsie we made a fucky wucky! bad attribute[0]")
      }
      return temp.song_stack
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //have dart call getPlaylistItems again
  }
  else {
    console.log(this.responseText);
    alert(this.responseText);
  }
}

function newPlaylistByAttribute(playlist_name, playlist_desc, is_public, playlist_id, attribute) {
  postNewPlaylist(playlist_name, playlist_desc, is_public);
  temp.attribute = attribute;
  temp.current_playlist_id = playlist_id;
  callApi("GET", get_playlist_items + playlist_id + "/tracks?fields=items(track)",
    null, newPlaylistByAttributeResponseHandler);
}

function newPlaylistByAttributeResponseHandler() {
  let songStack = stackByAttribute();
  postSongToPlaylist(songStack, temp.current_playlist_id);
  temp.song_stack = [];
}

function removeByAttribute(playlist_id, attribute) {
  temp.attribute = attribute;
  temp.current_playlist_id = playlist_id;
  callApi("GET", get_playlist_items +
    playlist_id + "/tracks?fields=items(track)",
    null, removeByAttrResponseHandler());
}

function removeByAttrResponseHandler() {
  let songStack = stackByAttribute();
  deleteItemFromPlaylist(songStack, temp.current_playlist_id);
  temp.song_stack = [];
}

function getTrackAttributes(track_id){
  callApi("GET", get_track_audio_features + track_id, null, trackAttributeResponseHandler);
}

function trackAttributeResponseHandler(){
  if (this.status == 200){
    var response = JSON.parse(this.responseText);
    temp.track_features = {danceability:response.danceability, energy:response.energy};
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //return to dart to retry
  }
  else {
    //return to dart for error handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}

function getUserProf(user_id){
  callApi("GET", get_user_prof + user_id, null, userProfResponseHandler);
}

function userProfResponseHandler(){
    if (this.status == 200){
      var response = JSON.parse(this.responseText);
      localStorage.setItem("display_name", response.display_name);
      response.images.forEach(element => 
        localStorage.setItem("profile_picture", element.url));
  }
  else if (this.status == 401) {
    refreshAccessToken();
    //return to dart to retry
  }
  else {
    //return to dart for error handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}
