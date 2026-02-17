import { defineConfig } from "vitepress";
import { tabsMarkdownPlugin } from "vitepress-plugin-tabs";
import {
  groupIconMdPlugin,
  groupIconVitePlugin,
  localIconLoader,
} from "vitepress-plugin-group-icons";
import { fileURLToPath } from "node:url";
import { copyOrDownloadAsMarkdownButtons } from "vitepress-plugin-llms";
import fs from "node:fs";
import path from "node:path";
import llmstxt from "vitepress-plugin-llms";

const repoUrl = "https://github.com/luamod/mods";
const siteOrigin = "https://luamod.github.io";
const siteBasePath = "/mods/";
const siteUrl = `${siteOrigin}${siteBasePath}`;
const assetBasePath = process.argv.includes("dev") ? "/" : siteBasePath;
const siteTitle = "Mods";
const siteDescription = "Pure standalone Lua modules.";
const siteImage = `${siteUrl}og.svg`;
const siteImageAlt = "Mods documentation";
const groupIcons = Object.fromEntries(
  [".lua", "luarocks"].map((iconName) => [
    iconName,
    localIconLoader(
      import.meta.url,
      `../src/assets/${iconName.replace(/^\./, "")}.svg`,
    ),
  ]),
);
const websiteJsonLd = {
  "@context": "https://schema.org",
  "@type": "WebSite",
  name: siteTitle,
  url: siteUrl,
  description: siteDescription,
};

// Build nav/sidebar modules list from docs/modules at build time.
const moduleNames = fs
  .readdirSync(
    path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..", "src", "modules"),
  )
  .filter((name) => name.endsWith(".md") && name !== "index.md")
  .map((name) => name.replace(/\.md$/, ""))
  .sort((a, b) => a.localeCompare(b));

const moduleText = (name: string): string =>
  name === "list" || name === "set"
    ? name[0].toUpperCase() + name.slice(1)
    : name;

const moduleItems = moduleNames.map((name) => ({
  text: moduleText(name),
  link: `/modules/${name}`,
}));

export default defineConfig({
  srcDir: "./src",
  title: siteTitle,
  description: siteDescription,
  base: assetBasePath,
  sitemap: { hostname: siteUrl },
  cleanUrls: true,
  // prettier-ignore
  head: [
    ["link", { rel: "preconnect", href: "https://fonts.googleapis.com" }],
    ["link", { rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "" }],
    ["link", { rel: "stylesheet", href: "https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;500;600;700&display=swap" }],
    ["link", { rel: "icon", type: "image/svg+xml", href: `${assetBasePath}logo.svg` }],
    ["link", { rel: "icon", type: "image/png", sizes: "512x512", href: `${assetBasePath}logo.png` }],
    ["meta", { property: "og:type", content: "website" }],
    ["meta", { property: "og:site_name", content: siteTitle }],
    ["meta", { property: "og:title", content: siteTitle }],
    ["meta", { property: "og:description", content: siteDescription }],
    ["meta", { property: "og:locale", content: "en_US" }],
    ["meta", { property: "og:url", content: siteUrl }],
    ["meta", { property: "og:image", content: siteImage }],
    ["meta", { property: "og:image:alt", content: siteImageAlt }],
    ["meta", { name: "twitter:card", content: "summary_large_image" }],
    ["meta", { name: "twitter:title", content: siteTitle }],
    ["meta", { name: "twitter:description", content: siteDescription }],
    ["meta", { name: "twitter:url", content: siteUrl }],
    ["meta", { name: "twitter:image", content: siteImage }],
    ["meta", { name: "twitter:image:alt", content: siteImageAlt }],
    ["meta", { name: "robots", content: "index,follow" }],
    ["link", { rel: "canonical", href: siteUrl }],
    ["script", { type: "application/ld+json" }, JSON.stringify(websiteJsonLd)],
  ],
  themeConfig: {
    logo: "/logo.svg",
    outline: [2, 5], // show h2-h5
    search: { provider: "local" },
    socialLinks: [{ icon: "github", link: repoUrl }],
    // prettier-ignore
    nav: [
      { text: "Home", link: "/" },
      { text: "Get Started", link: "/getting-started" },
      { text: "Modules", items: moduleItems },
      { text: "🇵🇸 Free Palestine", link: "https://techforpalestine.org/learn-more" },
    ],
    sidebar: [
      {
        text: "Start",
        items: [
          { text: "What Is Mods?", link: "/" },
          { text: "Getting Started", link: "/getting-started" },
        ],
      },
      { text: "Modules", items: moduleItems },
    ],
    editLink: {
      pattern: `${repoUrl}/edit/main/docs/src/:path`,
      text: "Edit this page",
    },
  },
  markdown: {
    config(md) {
      md.use(groupIconMdPlugin);
      md.use(tabsMarkdownPlugin);
      md.use(copyOrDownloadAsMarkdownButtons);
    },
  },
  vite: {
    plugins: [
      groupIconVitePlugin({ customIcon: groupIcons }),
      llmstxt({ excludeIndexPage: false }),
    ],
  },
});
