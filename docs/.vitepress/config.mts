import { defineConfig } from "vitepress";
import { tabsMarkdownPlugin } from "vitepress-plugin-tabs";

export default defineConfig({
  title: "Mods",
  description: "Pure standalone Lua modules.",
  base: "/mods/",
  head: [
    ["meta", { property: "og:type", content: "website" }],
    ["meta", { property: "og:title", content: "Mods" }],
    ["meta", { property: "og:description", content: "Pure standalone Lua modules." }],
    ["meta", { property: "og:image", content: "https://luamod.github.io/mods/og.svg" }],
    ["meta", { name: "twitter:card", content: "summary_large_image" }],
    ["meta", { name: "twitter:image", content: "https://luamod.github.io/mods/og.svg" }],
  ],
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
        items: [{ text: "Getting Started", link: "/getting-started" }],
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
    socialLinks: [{ icon: "github", link: "https://github.com/luamod/mods" }],
  },
  markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin);
    },
  },
});
