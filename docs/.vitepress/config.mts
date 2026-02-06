import { defineConfig } from "vitepress";
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'

export default defineConfig({
  title: "Mods",
  description: "Pure standalone Lua modules.",
  themeConfig: {
    outline: [2, 4], // show h2-h4
    nav: [
      { text: "🏠 Home", link: "/" },
      { text: "Modules", link: "/modules/" },
    ],
    logo: "/logo.svg",
    sidebar: [
      {
        text: "Modules",
        items: [
          { text: "Overview", link: "/modules/" },
          { text: "List", link: "/modules/list" },
          { text: "Set", link: "/modules/set" },
          { text: "tbl", link: "/modules/tbl" },
        ],
      },
    ],
    editLink: {
      pattern: "https://github.com/luamod/mods/edit/main/docs/:path",
      text: "Edit this page",
    },
    search: {
      provider: "local",
    },
  },
    markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin)
    },
  },
});
