import { defineConfig } from "vitepress";

export default defineConfig({
  title: "Mods",
  description: "Pure standalone Lua modules.",
  themeConfig: {
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
});
