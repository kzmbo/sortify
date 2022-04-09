import logo from './logo.svg';
import './App.css';

function App() {
  onPageLoad();
  return (
      <button onClick = {() => requestAuth()}> try to authorize </button>
  );
}

const redirect_uri = "http://localhost:3000";
const client_id = "8405c732c9e44daf81d6a21cb5a0e8fc";
const client_secret = "c33d9877c3a04803b131247f31644d23";
const TOKEN = "https://accounts.spotify.com/api/token";

function onPageLoad(){
  if (window.location.search.length > 0){
    handleRedirect();
  }
}

function handleRedirect(){
  let code = getCode();
  fetchAccessToken(code);
  window.history.pushState("", "", redirect_uri);
}

function getCode(){
  let code = null;
  const queryString = window.location.search;
  if (queryString.length > 0){

    const urlParams = new URLSearchParams(queryString);
    code = urlParams.get('code');

  }
  return code;
}


function fetchAccessToken(code){

  let body = "grant_type=authorization_code";
  body += "&code=" + code;
  body += "&redirect_uri=" + encodeURI(redirect_uri);
  body += "&client_id=" + client_id;
  body += "&client_secret=" + client_secret;
  callAuthorizationApi(body);

}

function callAuthorizationApi(body){

  let xhr = new XMLHttpRequest();
  xhr.open("POST", TOKEN, true);
  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xhr.setRequestHeader("Authorization", "Basic " + btoa(client_id + ":" + client_secret));
  xhr.send(body);
  xhr.onload = handleAuthorizationResponse;
}

function handleAuthorizationResponse(){
  if (this.status == 200){
    var data = JSON.parse(this.responseText);
    console.log(data);
    if (data.access_token != undefined){
      let access_token = data.access_token;
      localStorage.setItem("access_token", access_token);
    }
    if (data.refresh_token != undefined){
      let refresh_token = data.refresh_token;
      localStorage.setItem("refresh_token", refresh_token);
    }
    onPageLoad();
  }
  else{
    console.log(this.responseText);
    alert(this.responseText);
  }
}

function requestAuth(){
  let url = "https://accounts.spotify.com/authorize";
  url += "?client_id=" + client_id;
  url += "&response_type=code";
  url += "&redirect_uri=" + encodeURI(redirect_uri);
  url += "&showdialog=true";
  url += "&scope=playlist-modify-public playlist-read-private playlist-modify-private";
  window.location.href = url;
}

export default App;
