import 'bootstrap'
import CodeMirror from 'codemirror'

import { Elm } from './Main'

import 'bootstrap/dist/css/bootstrap.min.css'
import 'codemirror/lib/codemirror.css'
import '../public/app.css'

let app = Elm.Main.init({
  node: document.getElementById('app'),
})

// app.ports.cache.subscribe(function(data) {
//   localStorage.setItem('cache', JSON.stringify(data));
// });

let codeMirror = CodeMirror(document.getElementById('code-block'), {
  value: 'search\n\t[#actors age > 28 gender: female eyes hair]',
  mode: 'eve',
})
