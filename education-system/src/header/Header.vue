<script setup>
import { RouterLink } from 'vue-router'
</script>

<template>
  <nav class="main-nav">
    <div class="nav-brand">
      <RouterLink to="/">CoursePath Finder</RouterLink>
    </div>
    <div class="nav-links">
      <RouterLink to="/">Home</RouterLink>
      <router-link to="/career-quiz">Career Quiz</router-link>
      <RouterLink to="/#features">Career Clusters</RouterLink>
      <RouterLink to="/#teachers">Course Details</RouterLink>
      <RouterLink to="/#requirement">Course Entry Requirement</RouterLink>
    </div>
  </nav>
</template>

<style scoped>
.main-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 5%;
  background: white;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.nav-brand {
  font-size: 3rem; 
  font-weight: bold;
  margin-left: 0; 
}

.nav-brand a {
  color: #2c3e50;
  text-decoration: none;
}

.nav-links {
  display: flex;
  gap: 2.2rem; 
  align-items: center;
}

.nav-links a {
  font-size: 1.6rem; 
  font-weight: 500;
  color: #2c3e50;
  text-decoration: none;
  transition: color 0.3s ease, transform 0.2s;
}

.nav-links a:hover,
.nav-links a.router-link-active {
  color: #4a90e2;
  transform: scale(1.05); 
}

.nav-links a.router-link-exact-active {
  color: #4a90e2;
  font-weight: 600;
}
</style>