import { defineConfig } from "vitepress";
import { tabsMarkdownPlugin } from "vitepress-plugin-tabs";
import { moduleNav, moduleSidebar } from "./mods.mts";

export default defineConfig({
  title: "Mods",
  description: "Pure standalone Lua modules.",
  base: "/mods/",
  // prettier-ignore
  head: [
    ["link", { rel: "preconnect", href: "https://fonts.googleapis.com" }],
    ["link", { rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "" }],
    ["link", { rel: "stylesheet", href: "https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;500;600;700&display=swap" }],
    ["link", { rel: "icon", type: "image/svg+xml", href: "/mods/logo.svg" }],
    ["link", { rel: "icon", type: "image/png", sizes: "512x512", href: "/mods/logo.png" }],
    ["meta", { property: "og:type", content: "website" }],
    ["meta", { property: "og:site_name", content: "Mods" }],
    ["meta", { property: "og:title", content: "Mods" }],
    ["meta", { property: "og:description", content: "Pure standalone Lua modules." }],
    ["meta", { property: "og:url", content: "https://luamod.github.io/mods/" }],
    ["meta", { property: "og:image", content: "https://luamod.github.io/mods/og.svg" }],
    ["meta", { name: "twitter:card", content: "summary_large_image" }],
    ["meta", { name: "twitter:image", content: "https://luamod.github.io/mods/og.svg" }],
  ],
  themeConfig: {
    logo: "/logo.svg",
    outline: [2, 4], // show h2-h4
    search: { provider: "local" },
    socialLinks: [{ icon: "github", link: "https://github.com/luamod/mods" }],
    nav: [
      { text: "Home", link: "/" },
      { text: "Get Started", link: "/getting-started" },
      moduleNav,
    ],
    sidebar: [
      {
        text: "Start",
        items: [{ text: "Getting Started", link: "/getting-started" }],
      },
      moduleSidebar,
      { text: "🇵🇸 Free Palestine" },
    ],
    editLink: {
      pattern: ({ filePath, frontmatter }) => {
        const repoEditBase = "https://github.com/luamod/mods/edit/main";
        if (!filePath) {
          return `${repoEditBase}/docs`;
        }
        const target = frontmatter?.editLinkTarget;
        if (typeof target === "string" && target.length > 0) {
          return `${repoEditBase}/${target}`;
        }
        return `${repoEditBase}/${filePath}`;
      },
      text: "Edit this page",
    },
  },
  markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin);
    },
  },
});
