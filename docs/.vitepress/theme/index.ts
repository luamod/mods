// .vitepress/theme/index.ts
import type { Theme } from "vitepress";
import { useRoute } from "vitepress";
import DefaultTheme from "vitepress/theme";
import CopyOrDownloadAsMarkdownButtons from "vitepress-plugin-llms/vitepress-components/CopyOrDownloadAsMarkdownButtons.vue";
import { enhanceAppWithTabs } from "vitepress-plugin-tabs/client";
import { defineComponent, h } from "vue";
import "./style.css";

// Hide copy/download buttons on home until root-route markdown URL handling is customized.
const CopyButtonsExceptHome = defineComponent({
  name: "CopyButtonsExceptHome",
  setup() {
    const route = useRoute();
    return () => {
      if (route.path === "/" || route.path === "/index.html") {
        return null;
      }
      return h(CopyOrDownloadAsMarkdownButtons);
    };
  },
});

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component("CopyOrDownloadAsMarkdownButtons", CopyButtonsExceptHome);
    enhanceAppWithTabs(app);
  },
} satisfies Theme;
