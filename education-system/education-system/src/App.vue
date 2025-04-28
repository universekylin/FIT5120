<script setup>
import { RouterLink, RouterView } from 'vue-router'
import ChatBot from './views/chat-bot/ChatBot.vue';
import FullProtect from './components/FullProtect.vue'
</script>

<template>
  <RouterView />
  <ChatBot/>
  <FullProtect />

</template>

