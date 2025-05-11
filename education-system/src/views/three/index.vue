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
              <router-link class="nav-link" to="/">Home</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/test">Test</router-link>
            </li>
            <!-- <li class="nav-item">
              <router-link class="nav-link" to="/career">Career</router-link>
            </li> -->
            <li class="nav-item">
              <router-link class="nav-link" to="/career-stories">Career Stories</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/subject">High School</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/secondary-college">Subject</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/chatbot">Chat Bot</router-link>
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
          <p class="lead mb-4">Explore our university campus in an interactive 3D environment. Rotate and zoom to see different angles.</p>
          
          <div class="three-container">
            <ThreeScene />
          </div>
          
          <div class="mt-4">
            <h2>How to interact</h2>
            <ul>
              <li>The 3D model rotates automatically</li>
              <li>Explore different buildings and facilities on our campus</li>
              <li>This is just a demonstration of what's possible with 3D visualization</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import ThreeScene from '@/components/ThreeScene.vue'
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