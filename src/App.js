import React, { useState, useEffect } from 'react';
import axios from 'axios'

function App() {
  const CLIENT_ID = '4b3522cfc2e94e13adbabba2436f012d';
  const RESPONSE_TYPE = 'token';
  const REDIRECT_URI = 'https://spotcleaner.netlify.app/';
  const AUTH_URI = 'http://accounts.spotify.com/en/authorize'

  //Stores the token that is given from Spotify
  const [userToken, setUserToken] = useState('');
  //Stores a list of the user's playlist.
  const [listOfPlaylist, setListOfPlaylist] = useState({});
  //Stores the selected playlist that is clicked by the the user
  const [currentPlaylistName, setCurrentPlaylistName] = useState('')
  //Stores the JSON data of the selected playlist
  const [currentPlaylistSongList, setCurrentPlaylistSongList] = useState({})
  //Stores an array of song uris that is added to the merged playlist section
  const [newSongList, setSongList] = useState([])
  //Stores a list of songs from the selected playlist
  const [listOfCurrentSongs, setListOfCurrentSongs] = useState([])
  //Stores a list of merged playlist added to the list.
  const [listOfMergePlaylist, setListOfMergePlaylist] = useState([])
  const [userPFP, setUserPFP] = useState('')
  const [username, setUsername] = useState('')
  //Status Message will appear when a user merges a playlist. 
  const [statusMessage, setStatusMessage] = useState('')
  
  //Sets document title 
  // useEffect(() => {
  //   document.title = "SpotCleaner"
  // }, []);

  //Retrieves the token, stores the token into userToken, gets list of playlists and user's spotify info such as username and profile picture
  useEffect(() => {
    const hash = window.location.hash
    let token = window.localStorage.getItem("token")

    if (!token && hash) {
      token = hash.substring(1).split("&").find(elem => elem.startsWith("access_token")).split("=")[1]
      window.location.hash = ""
      window.localStorage.setItem("token", token)
    }
    setUserToken(localStorage.getItem("token"))
    GetListOfPlaylist(token)
    GetUserInfo(token)
  }, [])

  //Gets User's username and profile picture
  const GetUserInfo = async (token) => {
    await axios.get('https://api.spotify.com/v1/me', {
      headers: {Authorization: `Bearer ${token}`}
    })
    .then((response) => {
      setUserPFP(response.data.images[0].url)
      setUsername(response.data.display_name)
    })
    .catch((error) => {
      console.log(error)
    })
  }

  //Gets a list of playlist from the user
  const GetListOfPlaylist = async (token) => {
    axios.get("https://api.spotify.com/v1/me/playlists", {
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json"
      },
    })
    .then((response) => {
      setListOfPlaylist(response.data)
    }).catch((error) => {
      console.log(error)
    })
  }

  //Gets the playlist's items whether the user clicks on a playlist. Displays all of the songs in the playlist in "Song List"
  const GetPlaylistItems = (PLAYLIST_ID) => {
    axios.get(`https://api.spotify.com/v1/playlists/${PLAYLIST_ID}/tracks`, {
      headers: {
        Authorization: `Bearer ${userToken}`,
        "Content-Type": "application/json"
      },
      params: {
        fields: 'items(track(name, uri, artists(name))), name',
        market: 'US',
        limit: '20',
      }
    })
    .then((response) => {
      let tempURI = []
      response.data.items.map((item) =>
        tempURI.push(item.track.uri),
      )
      setListOfCurrentSongs(tempURI)
      setCurrentPlaylistSongList(response.data)
    }).catch((error) => {
      console.log(error)
    })

    axios.get(`https://api.spotify.com/v1/playlists/${PLAYLIST_ID}`, {
      headers: {
        Authorization: `Bearer ${userToken}`,
        "Content-Type": "application/json"
      },
      params: {
        fields: 'name',
      }
    })
    .then((response) => {
      setCurrentPlaylistName(response.data.name)
    }).catch((error) => {
      console.log(error)
    })
  }

  //adds songs to newSongList whether user clicks the add button.
  const addSongsToNewPlaylist = () => {
    setListOfMergePlaylist([...listOfMergePlaylist, currentPlaylistName])
    setSongList([...newSongList, listOfCurrentSongs])
  }

  //Display user's playlist from spotify
  const displayPlaylist = () => {
    return (
      <div>
        {listOfPlaylist?.items ? listOfPlaylist.items.map((playlist, i) => 
          <button onClick={() => GetPlaylistItems(playlist.id)} className='w-full'>
            <h2 className='text-white text-4xl px-5 py-10 border-b-2'>{`${i+1}. ${playlist.name}`}</h2>
          </button>
            
          ) : null
        }
        
      </div>
    )
  }

  //Display songs from selected playlist
  const displaySongs = () => {
    return (
      <div>
        {currentPlaylistSongList?.items ? currentPlaylistSongList.items.map((song, i) =>
          <h2 className='text-white text-4xl px-5 py-10 border-b-2'>{i+1}. {song.track.artists[0].name} - {song.track.name}</h2>
        ) : null}
      </div>
    )
  }

  //Display list of merging playlist when user pressed the add button
  const displayMergingPlaylist = () => {
    return (
      <div>
        {listOfMergePlaylist ? listOfMergePlaylist.map((name, i) => 
          <h2 className='text-white text-4xl px-5 py-10 border-b-2'>{i+1}. {name}</h2>
        ) : null}
      </div> 
    )
  }

  //Creates a new playlist from all the songs from the merged playlist section
  let USER_ID = ''
  let NEWPLAYLIST_ID = ''
  const mergePlaylist = async () => {
    await axios.get('https://api.spotify.com/v1/me', {
      headers: {
        Authorization: `Bearer ${userToken}`,
        "Content-Type": "application/json"
      },
    })
    .then((response) => {
      console.log(response.data)
      USER_ID = response.data.id
    }).catch((error) => {
      console.log(error)
    })

    console.log("USER_ID: " + USER_ID)
    await axios.post(`https://api.spotify.com/v1/users/${USER_ID}/playlists`, {name: 'Merged Playlist', public: true, description: 'Created from SpotCleaner'}, {
      headers: {
        Authorization: `Bearer ${userToken}`,
        "Content-Type": "application/json"
      },
    })
    .then((response) => {
      console.log(response.data)
      NEWPLAYLIST_ID = response.data.id
    })
    .catch((error) => {
      console.log(error)
    })
    console.log("Newplaylist id: " + NEWPLAYLIST_ID)
    console.log("Song List: " + newSongList.join(','))

    await axios.put(`https://api.spotify.com/v1/playlists/${NEWPLAYLIST_ID}/tracks`, {
      uris: newSongList
    },
    {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${userToken}`,
      },
      params: {
        uris: newSongList.join(',')
      }
    },
    )
    .then((response) => {
      console.log(response)
    })
    .catch((error) => {
      console.log("Newplaylist id: " + NEWPLAYLIST_ID)
      console.log("Song List: " + newSongList.join(','))
      console.log(error)
    })
    setStatusMessage('Created A New Playlist! Check Your Spotify Dashboard.')
    setTimeout(() =>{
      setStatusMessage('')
    }, 5000)
  }

  //Clears the Song List and Merged Playlist section
  const revomeMergedPlaylist = () => {
    setSongList([])
    setCurrentPlaylistSongList({})
    setListOfCurrentSongs([])
    setListOfMergePlaylist([])  
  }

  //Logs user out by clearing token and all the states.
  const logout = () => {
    setUserToken('')
    setSongList([])
    setListOfPlaylist({})
    setCurrentPlaylistSongList({})
    setListOfCurrentSongs([])
    setListOfMergePlaylist([])
    window.localStorage.removeItem("token")
  }

  //Display the dashboard when there's a user token, if not display the login screen
  if (userToken){
    return(
      <div className='bg-grey w-screen h-screen flex justify-center place-items-center gap-20'>
        <h1 className='absolute left-0 top-0 text-white text-4xl font-bold p-5'>SpotCleaner</h1>
        {statusMessage ? (<p className='absolute inset-x-50 top-20 text-white text-lg'>{statusMessage}</p>) : null}
        <div className='bg-black w-96 h-4/6 text-center rounded-lg overflow-auto'>
          <h1 className='text-white text-4xl font-bold py-5 border-b-4'>My Playlists</h1>
          {displayPlaylist()}
        </div>
        <div className='bg-black w-96 h-4/6 text-center rounded-lg overflow-auto'>
          <h1 className='text-white text-4xl font-bold py-5 border-b-4'>Song List</h1>
          {displaySongs()}
        </div>
        <div className='bg-black w-96 h-4/6 text-center rounded-lg overflow-auto'>
          <h1 className='text-white text-3xl font-bold py-5 border-b-4'>Merging Playlist with...</h1>
          {displayMergingPlaylist()}
        </div>
        <div className='absolute inset-x-50 bottom-7'>
          <button onClick={revomeMergedPlaylist} className='text-white bg-red rounded-full px-6 py-2 mx-2 mb-2 hover:cursor-pointer hover:bg-black hover:animate-pulse'>Remove All Merged Playlist</button>
          <button onClick={addSongsToNewPlaylist} className='text-white bg-light-grey rounded-full px-6 py-2 mx-5 mb-2 hover:cursor-pointer hover:bg-black hover:animate-pulse'>Add</button>
          <button onClick={mergePlaylist} className='text-white bg-green rounded-full px-6 py-2 mb-2 hover:cursor-pointer hover:bg-dark-green hover:animate-pulse'>Merge!</button>
        </div>
        <div className='absolute top-0 right-0 flex gap-5 my-2'>
          <p className='text-white text-lg self-center'>Logged in as {username}</p>
          <img src={userPFP} alt="spotify pfp" className='rounded-full w-14 h-14 mr-5'></img>
          <button className='text-white font-bold text-lg mr-5' onClick={logout}>logout</button>
        </div>      
      </div>
    )
  } else{
    return (
      <div className="bg-grey w-screen h-screen grid place-content-center">
        <div className=' text-white'>
          <div className='text-center'>
            <h1 className='text-5xl font-bold pb-3'>SpotCleaner</h1>
            <p className='pb-10'>A tool for creating playlist by merging playlists into one playlist!</p>
          </div>
          <div className='text-center'>
            <a href={`${AUTH_URI}?client_id=${CLIENT_ID}&redirect_uri=${REDIRECT_URI}&response_type=${RESPONSE_TYPE}&scope=playlist-modify-public playlist-modify-private`}>
              <button className='text-white bg-green rounded-full px-6 py-2 mb-2 hover:cursor-pointer hover:bg-dark-green hover:animate-pulse'>Login with Spotify</button>
            </a>
            <p className='text-light-grey text-xs'>This will redirect you to a new page.</p>
          </div>
        </div>
        <h4 className='absolute bottom-0 right-0 text-white px-6 py-4'>Want to see our repo! Click <a href='https://github.com/kzmbo/sortify' className='text-blue'>here</a></h4>
      </div>
    );
  }
}

export default App;
