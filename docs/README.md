# Website

The website is built using [VitePress](https://vitepress.dev/), a static site
generator.

## Installation

```bash
npm install
```

## Build and Test Locally

1. Run this command to build the docs:

```bash
npm run build
```

1. Once built, preview it locally by running:

```bash
npm run preview
```

The `preview` command will boot up a local static web server that will serve the
output directory `docs/.vitepress/dist` at `http://localhost:4173`. You can use
this to make sure everything looks good before pushing to production.

1. You can configure the port of the server by passing `--port` as an argument
   in `package.json`.

```json
{
  "scripts": {
    "preview": "vitepress preview --port 8080"
  }
}
```

Now the `preview` script will launch the server at `http://localhost:8080`.

## Local Development

```bash
npm run dev
```
