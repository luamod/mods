import { defineConfig } from "vitepress";
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'

export default defineConfig({
  title: "Mods",
  description: "Pure standalone Lua modules.",
  themeConfig: {
    outline: [2, 4], // show h2-h4
    nav: [
      { text: "Home", link: "/" },
      { text: "Get Started", link: "/getting-started" },
      { text: "Modules", link: "/modules/" },
    ],
    logo: "/logo.svg",
    sidebar: [
      {
        text: "Start",
        items: [
          { text: "Getting Started", link: "/getting-started" },
        ],
      },
      {
        text: "Modules",
        items: [
          { text: "Overview", link: "/modules/" },
          { text: "List", link: "/modules/list" },
          { text: "Set", link: "/modules/set" },
          { text: "tbl", link: "/modules/tbl" },
        ],
      },
      {
        text: "🇵🇸 Free Palestine",
      },
    ],
    editLink: {
      pattern: "https://github.com/luamod/mods/edit/main/docs/:path",
      text: "Edit this page",
    },
    search: {
      provider: "local",
    },
    socialLinks: [
      { icon: "github", link: "https://github.com/luamod/mods" },
    ],
  },
    markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin)
    },
  },
});
