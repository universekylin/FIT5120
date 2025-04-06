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
      <h2 class="section-title">🎯 Interactive Career Cluster</h2>
      <p class="subtitle">Choose a path to explore. Hover for a surprise!</p>
      <div class="cluster-grid">
        <div
          v-for="(item, index) in clusters"
          :key="index"
          class="cluster-box"
          @click="handleClick(item.label)"
        >
          <div :class="['icon', item.animationClass]">{{ item.icon }}</div>
          <span class="cluster-label">{{ item.label }}</span>
        </div>
      </div>
    </section>

    <!-- Trending Careers -->
    <section class="trending-careers">
      <h2 class="section-title">🔥 Today’s Trending Careers</h2>
      <p class="subtitle">Discover what's trending – don't miss out!</p>
      <div class="career-carousel">
        <div
          class="career-card"
          v-for="(career, index) in careers"
          :key="index"
        >
          <div class="icon">{{ career.icon }}</div>
          <h3 class="career-title">{{ career.title }}</h3>
          <p class="desc">{{ career.desc }}</p>
        </div>
      </div>
    </section>

    <!-- Featured Major  -->
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
  font-size: 1.8rem;
  margin-bottom: 30px;
  text-align: center;
}
.section-title {
  font-size: 2.2rem;
  font-weight: 700;
  margin-bottom: 24px;
}
.cluster-label {
  font-size: 1.3rem;
  font-weight: 500;
  text-align: center;
}
.btn {
  background-color: #6366f1;
  color: white;
  padding: 14px 32px;
  font-size: 1.2rem;
  font-weight: bold;
  border: none;
  border-radius: 12px;
  cursor: pointer;
  transition: background-color 0.3s;
}
.btn:hover {
  background-color: #4f46e5;
  transform: scale(1.05);
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
  width: 180px;
  height: 180px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  cursor: pointer;
  transition: transform 0.3s;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: 1.3rem;
}
.cluster-box:hover {
  transform: translateY(-6px);
}
.icon {
  font-size: 3rem;
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
  gap: 2rem;
  flex-wrap: wrap;
  padding-bottom: 10px;
}
.career-card {
  width: 240px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
  padding: 28px;
  transition: transform 0.3s ease;
  text-align: center;
}
.career-card:hover {
  transform: translateY(-6px);
}
.career-card h3.career-title {
  font-size: 1.4rem;
  font-weight: 700;
  margin-bottom: 10px;
}
.desc {
  font-size: 1.3rem;
  color: #555;
}

.featured-container {
  background: linear-gradient(135deg, #f8fcfe, #f7f7f905);
  color: #1e293b; 
  padding: 80px 20px;
}

.featured-major {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 3rem;
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px;
  background: white;
  border-radius: 20px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
}

.featured-major .image img {
  height: 280px;
  border-radius: 16px;
  object-fit: cover;
}

.featured-major .info {
  max-width: 400px;
  text-align: left;
}

.featured-major .info h3 {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 12px;
}

.featured-major .info p {
  font-size: 1.5rem;
  margin-bottom: 24px;
  color: #334155;
}

.featured-major .btn {
  background-color: #6366f1;
  color: white;
  padding: 12px 24px;
  border-radius: 12px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.featured-major .btn:hover {
  background-color: #4f46e5;
  transform: scale(1.05);
}

.footer {
  background-color: #0f172a;
  color: white;
  padding: 60px 20px; 
  font-size: 1rem;
  line-height: 1.8;
}

.footer p {
  margin: 0;
  font-weight: 400;
}
</style>
