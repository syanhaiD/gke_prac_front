<template>
  <div id="app">
    <p>れんしゅう</p>
    <button class="button" @click="loginGoogle()">login</button>
    <button class="button" @click="goApp()">goApp</button>
  </div>
</template>

<script>
import firebase from 'firebase/app'
import 'firebase/auth'

export default {
  name: 'App',

  created: function () {
    firebase.auth().getRedirectResult()
      .then(result => {
        if (result.credential) {
          console.log(result.credential)
        }
      })
      .catch(error => {
        console.log(error)
      })
  },
  methods: {
    loginGoogle () {
      const fbProv = new firebase.auth.GoogleAuthProvider()
      firebase.auth().signInWithRedirect(fbProv)
        .catch((e) => {
          console.log(e)
        })
    },
    goApp () {
      const endpoint = '[[API URL]]'
      return firebase.auth().currentUser.getIdToken(false)
        .then(token => {
          const headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': `Bearer: ${token}`
          }
          return fetch(endpoint, { method: 'GET', headers: new Headers(headers) })
            .then(response => {
              if (response.ok) {
                return response.json()
              }
              throw response
            })
            .then(data => {
              console.log(data)
            })
        })
        .catch(error => {
          throw error
        })
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
