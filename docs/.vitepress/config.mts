import { defineConfig } from "vitepress";
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'

export default defineConfig({
  title: "Mods",
  description: "Pure standalone Lua modules.",
  themeConfig: {
    outline: [2, 3], // show h2 and h3
    nav: [
      { text: "Home", link: "/" },
      { text: "Modules", link: "/modules/" },
    ],
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
    
  },
    markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin)
    },
  },
});
