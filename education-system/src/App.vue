<script setup>
import { RouterView } from 'vue-router'
// If header folder is at the root level
import Header from './header/Header.vue'
</script>

<template>
  <Header />
  <RouterView />
</template>

<style>
body {
  margin: 0;
  font-family: 'Segoe UI', sans-serif;
}
</style>