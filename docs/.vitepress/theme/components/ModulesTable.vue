<script setup lang="ts">
import { computed } from "vue";
import { useData, withBase } from "vitepress";

type ModuleRow = {
  text: string;
  link: string;
  desc: string;
};

type SiteThemeConfig = {
  moduleTableRows?: ModuleRow[];
};

const { site } = useData();

const rows = computed(() => {
  const theme = site.value.themeConfig as SiteThemeConfig;
  return theme.moduleTableRows ?? [];
});
</script>

<template>
  <table v-if="rows.length > 0">
    <thead>
      <tr>
        <th>Module</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="row in rows" :key="row.link">
        <td>
          <a :href="withBase(row.link)"><code>{{ row.text }}</code></a>
        </td>
        <td>{{ row.desc }}</td>
      </tr>
    </tbody>
  </table>
</template>
