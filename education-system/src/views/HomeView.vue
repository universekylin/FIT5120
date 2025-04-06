<template>
  <div class="home">
    <!-- Hero Section -->
    <section class="hero">
      <video autoplay muted loop class="video-bg">
        <source src="@/assets/hero-bg.mp4" type="video/mp4" />
      </video>
      <div class="overlay">
        <h1 class="main-title">Not Sure About Your Future? <br />Let’s Explore It Together!</h1>
        <p class="subtitle">Interactive quizzes, real stories, and smart career advice — made just for you.</p>
        <button class="btn">Start Quiz</button>
      </div>
    </section>

    <!-- Career Cluster -->
    <section class="career-cluster">
      <h2>🎯 Interactive Career Cluster</h2>
      <p class="subtitle">Choose a path to explore. Hover for a surprise!</p>
      <div class="cluster-grid">
        <div
          v-for="(item, index) in clusters"
          :key="index"
          class="cluster-box"
          @click="handleClick(item.label)"
        >
          <div :class="['icon', item.animationClass]">{{ item.icon }}</div>
          <span>{{ item.label }}</span>
        </div>
      </div>
    </section>

    <!-- Trending Careers -->
    <section class="trending-careers">
      <h2>🔥 Today’s Trending Careers</h2>
      <p class="subtitle">Discover what's trending – don't miss out!</p>
      <div class="career-carousel">
        <div
          class="career-card"
          v-for="(career, index) in careers"
          :key="index"
        >
          <div class="icon">{{ career.icon }}</div>
          <h3>{{ career.title }}</h3>
          <p class="desc">{{ career.desc }}</p>
        </div>
      </div>
    </section>

    <!-- Featured Major (moved visually above footer) -->
    <div class="featured-container">
      <section class="featured-major">
        <div class="image">
          <img src="@/assets/student4.png" alt="Student" />
        </div>
        <div class="info">
          <h3>Found A Career You’re Interested In?</h3>
          <p>There’s More Than One Path to Get There.</p>
          <button class="btn">Learn More</button>
        </div>
      </section>
    </div>

    <!-- Footer -->
    <footer class="footer">
      <p>&copy; 2025 CareerPath Finder. All rights reserved.</p>
    </footer>
  </div>
</template>

<script setup>
const clusters = [
  { label: 'Agriculture, Environment & Natural Sciences', icon: '🌱', animationClass: 'hover-draw' },
  { label: 'Business & Management', icon: '💼', animationClass: 'hover-code' },
  { label: 'Creative Arts, Media, Communication & Journalism', icon: '🎨', animationClass: 'hover-draw' },
  { label: 'Education & Social Sciences', icon: '📚', animationClass: 'hover-flipbook' },
  { label: 'Engineering & Science', icon: '🔬', animationClass: 'hover-code' },
  { label: 'Health & Human Services', icon: '❤️', animationClass: 'hover-heartbeat' },
  { label: 'IT & Data', icon: '💻', animationClass: 'hover-code' },
  { label: 'Law & Public Services', icon: '⚖️', animationClass: 'hover-flipbook' },
  { label: 'Math & Theoretical Sciences', icon: '📐', animationClass: 'hover-draw' }
];

const careers = [
  { title: 'Cybersecurity Analyst', icon: '🛡️', desc: 'Protect digital spaces from threats.' },
  { title: 'Game Designer', icon: '🎮', desc: 'Design immersive gaming experiences.' },
  { title: 'Biomedical Engineer', icon: '🧪', desc: 'Innovate at the intersection of tech and health.' },
  { title: 'Content Creator', icon: '📸', desc: 'Create and share impactful content online.' },
  { title: 'Education Support Worker', icon: '🧑‍🏫', desc: 'Support student learning and development.' }
];

function handleClick(label) {
  alert(`You clicked: ${label}`);
}
</script>

<style scoped>
.home {
  font-family: Arial, sans-serif;
  color: #111;
  line-height: 1.6;
}
.hero {
  position: relative;
  height: 90vh;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  background-color: #000;
}
.video-bg {
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  object-fit: cover;
  z-index: 1;
}
.overlay {
  position: relative;
  z-index: 2;
  text-align: center;
  max-width: 800px;
  padding: 0 20px;
}
.main-title {
  font-size: 2.5rem;
  font-weight: bold;
  margin-bottom: 20px;
}
.subtitle {
  font-size: 1.25rem;
  margin-bottom: 30px;
  text-align: center;
}
.btn {
  background-color: #6366f1;
  color: white;
  padding: 12px 24px;
  font-weight: bold;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s;
}
.btn:hover {
  background-color: #4f46e5;
}

.career-cluster {
  text-align: center;
  padding: 60px 20px;
}
.cluster-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 2rem;
}
.cluster-box {
  background-color: #f9fafb;
  border-radius: 12px;
  width: 160px;
  height: 160px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  cursor: pointer;
  transition: transform 0.3s;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.cluster-box:hover {
  transform: translateY(-6px);
}
.icon {
  font-size: 2.5rem;
  margin-bottom: 10px;
  transition: all 0.3s ease;
}
.hover-code:hover { transform: rotate(-5deg) scale(1.2); }
.hover-draw:hover { animation: wiggle 0.6s ease-in-out; }
.hover-heartbeat:hover { animation: heartbeat 1s infinite; }
.hover-flipbook:hover { animation: flip 0.6s ease-in-out; }

@keyframes wiggle {
  0%, 100% { transform: rotate(0deg); }
  25% { transform: rotate(5deg); }
  50% { transform: rotate(-5deg); }
  75% { transform: rotate(3deg); }
}
@keyframes heartbeat {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.3); }
}
@keyframes flip {
  0% { transform: rotateY(0deg); }
  50% { transform: rotateY(180deg); }
  100% { transform: rotateY(0deg); }
}

.trending-careers {
  padding: 60px 20px;
  text-align: center;
  background: #f9fafb;
}
.career-carousel {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  flex-wrap: wrap;
  padding-bottom: 10px;
}
.career-card {
  width: 220px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
  padding: 20px;
  transition: transform 0.3s ease;
  text-align: center;
}
.career-card:hover {
  transform: translateY(-6px);
}
h3 {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 6px;
}
.desc {
  font-size: 0.9rem;
  color: #555;
}

.featured-container {
  background-color: #0f172a;
  color: white;
  padding: 60px 20px 0;
}
.featured-major {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 2rem;
  max-width: 1200px;
  margin: 0 auto;
  padding-bottom: 60px;
}
.featured-major .image img {
  height: 300px;
  border-radius: 1rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}
.featured-major .info {
  max-width: 400px;
}
.featured-major .info h3 {
  font-size: 1.8rem;
  font-weight: bold;
  margin-bottom: 10px;
}
.featured-major .info p {
  font-size: 1rem;
  margin-bottom: 20px;
}

.footer {
  background-color: #0f172a;
  color: white;
  text-align: center;
  padding: 20px;
  font-size: 0.9rem;
}
</style>
