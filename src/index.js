import 'bootstrap';
import CodeMirror from 'codemirror';
import { Program } from 'witheve';

import { Elm } from './Main'

import 'bootstrap/dist/css/bootstrap.min.css';
import 'codemirror/lib/codemirror.css'
import '../public/app.css'

let app = Elm.Main.init({
  node: document.getElementById("app"),
})

let program = new Program("my program")
let htmlWatcher = program.attach("html")

// program.load(`
// bind @browser
//   [#div text: "hello, world!"] 
// `)


program.commit("Initialize records", function(eve) {
  let { find, record } = eve
  console.log("initialized records")
  return [
    record("actor", { name: "Elenor Shelstrop", age: 34, hair: "blonde", eyes: "blue" })
  , record("actor", { name: "Chidi Anagonye", age: 35, hair: "block", eyes: "brown" })
  ];
});

program.bind("Display records in table", function(eve) {
  let { find, record } = eve
  let actor = find("actor")
  let my_root = find("my-root")
  console.log("records", actor)
  console.log("record name", actor.name)
  return [
    my_root.add("children", [
      record("html/element", "", { tagname: "div", text: `Hello ${actor.name}`})
    ])
  ]
})

program.bind("render into #eve-wrapper", function(eve) {
  let { find, record } = eve
  let my_root = find("my-root");
  return [
    my_root.add("children", [
      record("html/element", "", { tagname: "div", text: "hello, world!" })
    ])
  ];
})

let eveElement = document.getElementById("eve-wrapper")
htmlWatcher.addExternalRoot("my-root", eveElement)

// app.ports.cache.subscribe(function(data) {
//   localStorage.setItem('cache', JSON.stringify(data));
// });

let codeMirror = CodeMirror(document.getElementById('code-block'), {
  value: "search\n\t[#actors age > 28 gender: female eyes hair]",
  mode:  "eve"
})