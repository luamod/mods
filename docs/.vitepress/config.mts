import { defineConfig } from "vitepress";
import { tabsMarkdownPlugin } from "vitepress-plugin-tabs";
import { fileURLToPath } from "node:url";
import { copyOrDownloadAsMarkdownButtons } from "vitepress-plugin-llms";
import fs from "node:fs";
import path from "node:path";
import llmstxt from "vitepress-plugin-llms";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const modulesDir = path.resolve(__dirname, "..", "modules");
const isDev = process.argv.includes("dev");
const isProd = !isDev;
const repoUrl = "https://github.com/luamod/mods";
const siteOrigin = "https://luamod.github.io";
const siteBasePath = "/mods/";
const siteUrl = `${siteOrigin}${siteBasePath}`;
const assetBasePath = isProd ? siteBasePath : "/";
const siteTitle = "Mods";
const siteDescription = "Pure standalone Lua modules.";
const siteImage = `${siteUrl}og.svg`;
const siteImageAlt = "Mods documentation";
const siteLocale = "en_US";
const websiteJsonLd = {
  "@context": "https://schema.org",
  "@type": "WebSite",
  name: siteTitle,
  url: siteUrl,
  description: siteDescription,
};

// Build nav/sidebar modules list from docs/modules at build time.
const moduleItems = fs
  .readdirSync(modulesDir)
  .filter((name) => name.endsWith(".md") && name !== "index.md")
  .map((name) => name.replace(/\.md$/, ""))
  .sort((a, b) => a.localeCompare(b))
  .map((name) => ({
    text:
      name === "list" || name === "set"
        ? name[0].toUpperCase() + name.slice(1)
        : name,
    link: `/modules/${name}`,
  }));

export default defineConfig({
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
    ["meta", { property: "og:locale", content: siteLocale }],
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
      pattern: `${repoUrl}/edit/main/docs/:path`,
      text: "Edit this page",
    },
  },
  markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin);
      md.use(copyOrDownloadAsMarkdownButtons);
    },
  },
  vite: {
    plugins: [llmstxt({ excludeIndexPage: false })],
  },
});
