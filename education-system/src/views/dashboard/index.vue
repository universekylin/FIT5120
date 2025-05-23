<template>
  <div class="home">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
      <div class="container">
        <router-link class="navbar-brand d-flex align-items-center" to="/">
          <span class="fw-bold">CoursePathFinder</span>
        </router-link>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item"><router-link class="nav-link active" to="/">Home</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/test">Career Quiz</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/career-stories">Career Stories</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/subject">VCE Subject Check</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/secondary-college">Alternative Schools</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/chatbot">AI ChatBot</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/three">Uni Virtual Explore</router-link></li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Hero -->
    <section class="hero">
      <video autoplay muted loop class="video-bg">
        <source src="@/assets/hero-bg.mp4" type="video/mp4" />
      </video>
      <div class="overlay">
        <h1 class="main-title">Who is this platform for?</h1>
        <p class="subtitle">
          This platform is designed for <strong>Year 11 and Year 12 students</strong> in <strong>regional Victoria</strong> to help choose VCE subjects, explore universities, and discover career paths.
        </p>
        <div class="d-flex justify-content-center gap-4 mt-3 flex-wrap">
          <div>🎓 Year 11–12 students</div>
          <div>📍 Regional Victoria</div>
          <div>🧱 Subject & career planning</div>
          <div>🏫 University and school insights</div>
        </div>
      </div>
    </section>

    <!-- Career Cluster -->
    <section class="career-cluster">
      <h2 class="section-title">🎯 Interactive Career Cluster</h2>
      <p class="subtitle">Choose a path to explore. Hover for a surprise!</p>
      <div class="cluster-grid">
        <div v-for="(item, index) in clusters" :key="index" class="cluster-box" @click="handleClick(item)">
          <div :class="['icon', item.animationClass]">{{ item.icon }}</div>
          <span class="cluster-label">{{ item.label }}</span>
        </div>
      </div>
    </section>

    <!-- Quiz CTA -->
    <section class="quiz-cta-section">
      <div class="quiz-cta-content text-center">
        <div class="quiz-title-wrapper">
          <span class="quiz-title-accent">✨</span>
          <h3 class="quiz-title">Not sure where to start?</h3>
        </div>
        <p class="quiz-subtitle">
          Take a 1-minute quiz to unlock study paths and career ideas that suit you best!
        </p>
        <router-link to="/test" class="quiz-btn">🎯 Start the Quiz</router-link>
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
  color: white;
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
  text-align: center;
}

.career-cluster {
  text-align: center;
  padding: 4rem 2rem;
  background-color: white;
  border-radius: 20px;
  margin: 2rem 0;
  width: 100%;
}

.cluster-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem 0.8rem;
  padding: 1.5rem;
  max-width: 1000px;
  margin: 0 auto;
  justify-items: center;
}

.cluster-box {
  width: 100%;
  max-width: 280px;
  height: 200px;
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

.quiz-cta-section {
  width: 100%;
  background: linear-gradient(135deg, #ede9fe, #eef2ff);
  padding: 3rem 1rem;
  border-top: 1px solid #e0e7ff;
  border-bottom: 1px solid #e0e7ff;
  margin-bottom: -1rem;
  margin-top: -1rem;
  transition: all 0.3s ease;
}

.quiz-cta-content {
  max-width: 860px;
  margin: 0 auto;
  background: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(12px);
  padding: 2.5rem 2rem;
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.3);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
}

.quiz-title-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.6rem;
  margin-bottom: 1rem;
}

.quiz-title-accent {
  font-size: 1.8rem;
  color: #8b5cf6;
}

.quiz-title {
  font-size: 2rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0;
}

.quiz-subtitle {
  font-size: 1.2rem;
  color: #4b5563;
  margin-bottom: 2rem;
}

.quiz-btn {
  background: linear-gradient(90deg, #6366f1, #8b5cf6);
  padding: 12px 30px;
  font-size: 1.1rem;
  color: #ffffff;
  font-weight: bold;
  border-radius: 12px;
  text-decoration: none;
  box-shadow: 0 4px 10px rgba(139, 92, 246, 0.3);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.quiz-btn:hover {
  transform: scale(1.05);
  box-shadow: 0 6px 14px rgba(99, 102, 241, 0.3);
}

.features {
  padding: 4rem 2rem;
  background-color: #f8fafc;
  border-radius: 20px;
  margin-top: 2rem;
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

