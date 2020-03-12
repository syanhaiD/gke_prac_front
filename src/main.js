import Vue from 'vue'
import App from './App'
import router from './router'

import firebase from 'firebase/app'
const fbConfig = {
  apiKey: '[[firebase api key]]',
  authDomain: '[[firebase app url]]'
}
firebase.initializeApp(fbConfig)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
