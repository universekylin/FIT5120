<!-- 在 src/views/three/index.vue -->
<template>
  <div class="education-page">
    <!--header-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
      <div class="container">
        <router-link class="navbar-brand d-flex align-items-center" to="/">
          <span class="fw-bold">Education System</span>
        </router-link>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <router-link class="nav-link" to="/">Main</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/test">Test</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/career">Career</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/career-stories">Career Stories</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/subject">Subject</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/secondary-college">College</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/chat-bot">Chat Bot</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link active" to="/three">Our University</router-link>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="container mt-4">
      <div class="row">
        <div class="col-12">
          <h1 class="display-4 mb-4">Our University in 3D</h1>
          <p class="lead mb-4">Explore our university campus in an interactive 3D environment. Move around to discover different buildings.</p>
          
          <div class="three-container">
            <!-- 替换 ThreeScene 为 UniversityExplorer -->
            <UniversityExplorer />
          </div>
          
          <div class="mt-4">
            <h2>How to interact</h2>
            <ul>
              <li>Use <strong>W/A/S/D</strong> keys or <strong>↑/←/↓/→</strong> arrow keys to move your character around</li>
              <li>Click on university buildings to view information about them</li>
              <li>Mouse drag to rotate the camera view</li>
              <li>Explore different buildings and learn about their programs</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import UniversityExplorer from '@/components/UniversityExplorer.vue';
</script>

<style scoped>
.education-page {
  background-color: #f8f9fa;
  min-height: 100vh;
}

.three-container {
  background-color: white;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  height: 600px;
  position: relative;
}

h1, h2 {
  color: #0d6efd;
}

.nav-link.active {
  font-weight: bold;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 4px;
}
</style>