<template>
  <div class="home">
    <nav
      class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top"
    >
      <div class="container">
        <router-link class="navbar-brand d-flex align-items-center" to="/">
          <span class="fw-bold">CoursePathFinder</span>
        </router-link>

        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <router-link class="nav-link active" to="/">Home</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/test">Career Quiz</router-link>
            </li>
            <!-- <li class="nav-item">
              <router-link class="nav-link" to="/career">Career</router-link>
            </li> -->
            <li class="nav-item">
              <router-link class="nav-link" to="/career-stories">Career Stories</router-link>
            </li>
            <li class="nav-item">
                <router-link class="nav-link" to="/subject">VCE Subject Check</router-link>
            </li>
            <li class="nav-item">
                <router-link class="nav-link" to="/secondary-college">Alternative Schools</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/chatbot">AI ChatBot</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/three">Uni Virtual Explore</router-link>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
      <video autoplay muted loop class="video-bg">
        <source src="@/assets/hero-bg.mp4" type="video/mp4" />
      </video>
      <div class="overlay">
        <h1 class="main-title">
          Not Sure About Your Future? <br />Let’s Explore It Together!
        </h1>
        <p class="subtitle">
          Interactive quizzes, real stories, and smart career advice — made just
          for you.
        </p>
        <router-link to="/test" class="btn">Start Quiz</router-link>
      </div>
    </section>

    <!-- Career Cluster -->
    <section class="career-cluster">
      <h2 class="section-title">🎯 Interactive Career Cluster</h2>
      <p class="subtitle">Choose a path to explore. Hover for a surprise!</p>
      <div class="cluster-grid">
        <div
          v-for="(item, index) in clusters"
          :key="index"
          class="cluster-box"
          @click="handleClick(item)"
        >
          <div :class="['icon', item.animationClass]">{{ item.icon }}</div>
          <span class="cluster-label">{{ item.label }}</span>
        </div>
      </div>
    </section>

     <!-- Features -->
    <section class="features" id="start">
      <h2 class="section-title">Feature Highlights</h2>
      <div class="feature-cards">
        <div class="feature-card">
          <img src="@/assets/subject-availability.png" alt="Subject checker" />
          <h3>Subject Availability Checker</h3>
          <p>See if your school offers the VCE subjects you need, and get suggestions.</p>
          <router-link to="/subject" class="link-btn">Check Now</router-link>
        </div>

        <div class="feature-card">
          <img src="@/assets/career-stories.png" alt="Career stories" />
          <h3>Career Stories</h3>
          <p>Read real-life stories to learn about different jobs.</p>
          <router-link to="/career-stories" class="link-btn">Explore Stories</router-link>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
      <p>&copy; 2025 CareerPath Finder. All rights reserved.</p>
    </footer>
  </div>
</template>

<script setup>
import { useRouter } from "vue-router";
const router = useRouter();
const clusters = [
  { label: 'Agriculture, Environment & Natural Sciences', value: "Agriculture Environment And Natural Sciences", icon: '🌱', animationClass: 'hover-draw' },
  { label: 'Business & Management', value:"Business And Management", icon: '💼', animationClass: 'hover-code' },
  { label: 'Creative Arts, Media, Communication & Journalism', value: "Creative Arts Media Communication and Journalism",  icon: '🎨', animationClass: 'hover-draw' },
  { label: 'Education & Social Sciences', value:"Education And Social Sciences", icon: '📚', animationClass: 'hover-flipbook' },
  { label: 'Engineering & Science', value:"Engineering And Science", icon: '🔬', animationClass: 'hover-code' },
  { label: 'Health & Human Services', value:"Health And Human Services", icon: '❤️', animationClass: 'hover-heartbeat' },
  { label: 'IT & Data', value:"IT And Data", icon: '💻', animationClass: 'hover-code' },
  { label: 'Law & Public Services', value:"Law And Public Services", icon: '⚖️', animationClass: 'hover-flipbook' },
  { label: 'Math & Theoretical Sciences', value:"Math And Theoretical Sciences", icon: '📐', animationClass: 'hover-draw' }
];

function handleClick(item) {
  router.push({
    name: 'career',
    query: { careers: item.value, type:"job" }
  });
}
</script>

<style scoped>
.home {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  color: #111;
  line-height: 1.6;
  background-color: #f0f2f5;
}

.hero {
  position: relative;
  height: 85vh;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  background-color: #000;
}

.video-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  z-index: 1;
}

.overlay {
  position: relative;
  z-index: 2;
  text-align: center;
  max-width: 800px;
  padding: 20px;
  background-color: rgba(0, 0, 0, 0.45);
  border-radius: 16px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
}

.main-title {
  font-size: 2.7rem;
  font-weight: 700;
  margin-bottom: 16px;
}

.subtitle {
  font-size: 1.4rem;
  margin-bottom: 24px;
}

.section-title {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.btn {
  background-color: #4f46e5;
  color: white;
  padding: 12px 28px;
  font-size: 1rem;
  font-weight: bold;
  border: none;
  border-radius: 10px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.btn:hover {
  background-color: #4338ca;
}

.career-cluster {
  text-align: center;
  padding: 4rem 2rem;
  background-color: white;
  border-radius: 20px;
  margin: 2rem 0;
  width: 100%; /* 改为全宽 */
  max-width: 100%; /* 移除限制 */
}

.cluster-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem 0.8rem; /* 适当保留间距 */
  padding: 1.5rem;
  max-width: 1000px; /* 放大整体布局区域 */
  margin: 0 auto;
  justify-items: center;
}


.cluster-box {
  width: 100%;
  max-width: 280px;  /* 放大每个卡片的宽度 */
  height: 200px;     /* 可选：显式设置高度更统一 */
  background-color: #ffffff;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  cursor: pointer;
  transition: transform 0.2s ease;
  text-align: center;
}


.cluster-box:hover {
  transform: translateY(-5px);
  background-color: #f3f4f6;
}

.icon {
  font-size: 3.5rem;
  margin-bottom: 0.75rem;
}

.cluster-label {
  font-size: 1.05rem;
}

.features {
  padding: 4rem 2rem;
  background-color: #f8fafc;
  border-radius: 20px;
  margin-top: 3rem;
}

.features h2 {
  font-size: 2rem;
  margin-bottom: 2rem;
  text-align: center;
}

.feature-cards {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 2rem;
}

.feature-card {
  background: white;
  border-radius: 14px;
  padding: 2rem;
  width: 440px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  transition: transform 0.3s ease;
  text-align: center;
}

.feature-card:hover {
  transform: translateY(-8px);
}

.feature-card img {
  width: 100%;
  max-height: 220px;
  object-fit: cover;
  border-radius: 10px;
  margin-bottom: 1rem;
}

.link-btn {
  display: inline-block;
  margin-top: 1rem;
  padding: 10px 20px;
  background-color: #6366f1;
  color: #fff;
  border-radius: 10px;
  text-decoration: none;
  font-weight: 500;
  transition: background-color 0.3s;
}

.link-btn:hover {
  background-color: #4f46e5;
}

.footer {
  background-color: #0f172a;
  color: white;
  padding: 3rem 1rem;
  text-align: center;
  font-size: 1rem;
  margin-top: 4rem;
  border-top: 3px solid #6366f1;
}
</style>
