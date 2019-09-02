## Elm Starter Project

Elm react is great, but it quickly is an issue to run ports, add other js libs. Setting up webpack is a pain. So here's a repo that saves you a couple hours setting up Elm as a project.

### Getting started

Just clone this repo, but then delete `.git` . Then:

```bash
git init
yarn install
```

### Running

You can look in `package.json` for a full list, but all you need to do is run

```bash
yarn build:watch
```

and then run the server

```bash
yarn start:watch
```

### Workflow

1. edit the source files
2. alt tab to the app in browser and reload

Webpack will compile the Elm source files as they change. The server will reload when there's new build files.

### Content

Here's a description of all the different folders

- dist/ - the built frontend application lives here
- elm-stuff/ - modules for elm program, installed by `elm install`
- node_modules/ - modules for dev and js programming installed by `yarn install`
- public/ - static resources, like `index.html`, images, and other assets
- src/ - this is where the source files for Elm and Js get built from
- elm.json - configuration file for elm packages
- index.js - static file server that `yarn start` runs so you can see the ap in the browser
- package.json - configuration file for node packages
- README.md - meta
- webpack.config.js - configuration file for webpack
- yarn.lock - package versions for yarn package manager