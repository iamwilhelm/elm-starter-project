import CodeMirror from 'codemirror';
import { Elm } from './Main'

let app = Elm.Main.init({
  node: document.getElementById("app"),
})

// app.ports.cache.subscribe(function(data) {
//   localStorage.setItem('cache', JSON.stringify(data));
// });

let codeMirror = CodeMirror(document.getElementById('code-block'), {
 value: "function myScript(){return 100;}\n",
 mode:  "javascript"
})