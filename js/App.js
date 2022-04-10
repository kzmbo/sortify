const get_playlist_items = "https://api.spotify.com/v1/playlists/";
const get_playlists_uri = "https://api.spotify.com/v1/me/playlists";
const redirect_uri = "http://localhost:3000";
const client_id = "8405c732c9e44daf81d6a21cb5a0e8fc";
const client_secret = "c33d9877c3a04803b131247f31644d23";
const TOKEN = "https://accounts.spotify.com/api/token";

var access_token;
var refresh_token;
function handleRedirect(){
  let code = getCode();
  fetchAccessToken(code);
  window.history.pushState("", "", redirect_uri);
}

//parses spotify auth code
function getCode(){
  let code = null;
  const queryString = window.location.search;
  if (queryString.length > 0){

    const urlParams = new URLSearchParams(queryString);
    code = urlParams.get('code');

  }
  return code;
}

//gets access token using auth code
function fetchAccessToken(code){

  let body = "grant_type=authorization_code";
  body += "&code=" + code;
  body += "&redirect_uri=" + encodeURI(redirect_uri);
  body += "&client_id=" + client_id;
  body += "&client_secret=" + client_secret;
  callAuthorizationApi(body);

}
//refreshes token when expired
function refreshAccessToken(){
  refresh_token = localStorage.getItem("refresh_token");
  let body = "grant_type=refresh_token";
  body += "&refresh_token=" + refresh_token;
  body += "&client_id=" + client_id;
  callAuthorizationApi(body);
}

//calls for authorization
function callAuthorizationApi(body){

  let xhr = new XMLHttpRequest();
  xhr.open("POST", TOKEN, true);
  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xhr.setRequestHeader("Authorization", "Basic " + btoa(client_id + ":" + client_secret));
  xhr.send(body);
  xhr.onload = handleAuthorizationResponse;
}
//handles response
function handleAuthorizationResponse(){
  if (this.status == 200){
    var data = JSON.parse(this.responseText);
    console.log(data);
    if (data.access_token != undefined){
      access_token = data.access_token;
      localStorage.setItem("access_token", access_token);
    }
    if (data.refresh_token != undefined){
      refresh_token = data.refresh_token;
      localStorage.setItem("refresh_token", refresh_token);
    }
  //send back to homepage with some uri like ?auth=true
  }
  else{
    //send back to dart for error message and handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}

//initial request for authorization
//have dart call this with "Login to Spotify" Button
function requestAuth(){
  let url = "https://accounts.spotify.com/authorize";
  url += "?client_id=" + client_id;
  url += "&response_type=code";
  url += "&redirect_uri=" + encodeURI(redirect_uri);
  url += "&showdialog=true";
  url += "&scope=playlist-modify-public playlist-read-private playlist-modify-private";
  window.location.href = url;
}
//general function for calling api
function callApi(method, endpoint, body, responseHandler){
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
function getPlaylists(){
  callApi("GET", get_playlists_uri + "?limit=1", null, handleGetPlaylistResponse);
}
//handles response for getplaylists
function handleGetPlaylistResponse(){
  if (this.status == 200){
    var response = JSON.parse(this.responseText);
    console.log(response);
    let i = 0;
    response.items.forEach(element=> {
      //send necessary info to dart, element.name, element.images, element.id etc. for it to list playlists and open them later
    });
  }
  else if (this.status == 401){
    refreshAccessToken();
    //return false to dart, have dart call getPlaylists again
  }
  else{
    //return to dart for error display and handling
    console.log(this.responseText);
    alert(this.responseText);
  }
}
//getsPlaylistItems
//dart will use this whenever displaying tracks in a playlist
function getPlaylistItems(playlist_id){
  callApi("GET", get_playlist_items +
      playlist_id + "/tracks?fields=items(track(id%2Cname%2Calbum(images)))",
      null, playlistItemResponseHandler);
}
//handles above function
function playlistItemResponseHandler(){
  if (this.status == 200){
    var response = JSON.parse(this.responseText);
    console.log(response);
    let i = 0;
    response.items.forEach(element=> {
      //send necessary info to dart to display and add/remove songs
      //yield keyword probably needed here 
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


export default App;
