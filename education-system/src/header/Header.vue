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
      <RouterLink to="/#courses">Career Quiz</RouterLink>
      <RouterLink to="/#features">Career Clusters</RouterLink>
      <RouterLink to="/#teachers">Course Details</RouterLink>
      <RouterLink to="/career-quiz">Course Entry Requirement</RouterLink>
    </div>
  </nav>
</template>

<style scoped>
.main-nav {
  display: flex;
  justify-content: space-between;
  padding: 1.5rem 5%;
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  max-width: 1440px;
  margin: 0 auto;
}

.nav-brand {
  font-size: 1.8rem;
  font-weight: bold;
}

.nav-brand a {
  color: #2c3e50;
  text-decoration: none;
}

.nav-links {
  display: flex;
  gap: 1.5rem;
  align-items: center;
}

.nav-links a {
  text-decoration: none;
  color: #2c3e50;
  font-weight: 500;
  transition: color 0.3s ease;
}

.nav-links a:hover,
.nav-links a.router-link-active {
  color: #4a90e2;
}

.nav-links a.router-link-exact-active {
  color: #4a90e2;
  font-weight: 600;
}
</style>