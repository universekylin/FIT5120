<template>
  <div class="homepage">
    <!-- Navigation Bar -->
    <nav class="main-nav">
      <div class="nav-brand">EduFuture</div>
      <div class="nav-links">
        <a href="#courses">Course System</a>
        <a href="#features">Platform Features</a>
        <a href="#teachers">Our Teachers</a>
      </div>
    </nav>

    <!-- Hero Banner -->
    <section class="hero-banner">
      <div class="hero-content">
        <h1>Start Your Future Learning Journey</h1>
        <p class="subtitle">Connect to world-class educational resources and create a personalized learning experience</p>
        <button class="cta-button">test your future career</button>
      </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
      <div class="stat-item">
        <h2>2000+</h2>
        <p>Quality Courses</p>
      </div>
      <div class="stat-item">
        <h2>98%</h2>
        <p>Learner Satisfaction</p>
      </div>
      <div class="stat-item">
        <h2>500+</h2>
        <p>Certified Instructors</p>
      </div>
    </section>

    <!-- Featured Courses -->
    <section id="courses" class="featured-courses">
      <h2 class="section-title">Popular Featured Courses</h2>
      <div class="course-grid">
        <div 
          v-for="course in featuredCourses" 
          :key="course.id"
          class="course-card"
        >
          <div class="course-badge" :class="course.category">
            {{ course.category }}
          </div>
          <h3>{{ course.title }}</h3>
          <p class="course-desc">{{ course.description }}</p>
          <div class="course-footer">
            <div class="rating">
              <span v-for="n in 5" :key="n">★</span>
              <span>({{ course.rating }})</span>
            </div>
            <button class="course-cta">View Details</button>
          </div>
        </div>
      </div>
    </section>

    <!-- Platform Features -->
    <section id="features" class="features-section">
      <div class="feature-card">
        <div class="feature-icon">🎯</div>
        <h3>Personalized Recommendations</h3>
        <p>AI-based algorithms suggest the best learning path for you</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">⏱️</div>
        <h3>Flexible Learning</h3>
        <p>Study anytime, anywhere with multi-device sync support</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🎓</div>
        <h3>Certification System</h3>
        <p>Earn industry-recognized certificates upon completion</p>
      </div>
    </section>

    <!-- Call to Action -->
    <section class="cta-section">
      <h2>Ready to level up?</h2>
      <p>Join millions of learners today</p>
      <div class="cta-buttons">
        <button class="secondary-cta">Browse Courses</button>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref } from 'vue'
const featuredCourses = ref([
  {
    id: 1,
    title: 'Practical AI Course',
    description: 'Master core AI technologies from theory to hands-on practice',
    category: 'AI',
    rating: 4.9
  },
  {
    id: 2,
    title: 'Full-Stack Development Bootcamp',
    description: 'Become a full-stack engineer from scratch',
    category: 'Programming',
    rating: 4.8
  },
  {
    id: 3,
    title: 'Digital Marketing Expert Course',
    description: 'Learn the latest digital marketing methodologies',
    category: 'Business',
    rating: 4.7
  }
])
</script>


<style scoped>
.homepage {
  max-width: 1440px;
  margin: 0 auto;
  font-family: 'Segoe UI', sans-serif;
}

.main-nav {
  display: flex;
  justify-content: space-between;
  padding: 1.5rem 5%;
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.nav-brand {
  font-size: 1.8rem;
  font-weight: bold;
  color: #2c3e50;
}

.hero-banner {
  display: flex;
  align-items: center;
  padding: 4rem 5%;
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.hero-content {
  flex: 1;
  padding-right: 3rem;
}

.hero-content h1 {
  font-size: 3.5rem;
  color: #2c3e50;
  margin-bottom: 1.5rem;
}

.subtitle {
  font-size: 1.5rem;
  color: #6c757d;
  margin-bottom: 2rem;
}

.cta-button {
  background: #4a90e2;
  color: white;
  padding: 1rem 2rem;
  border-radius: 30px;
  font-size: 1.1rem;
  transition: transform 0.3s ease;
}

.cta-button:hover {
  transform: translateY(-2px);
}

.stats-section {
  display: flex;
  justify-content: space-around;
  padding: 4rem 5%;
  background: white;
}

.stat-item {
  text-align: center;
}

.stat-item h2 {
  font-size: 2.5rem;
  color: #4a90e2;
}

.featured-courses {
  padding: 4rem 5%;
  background: #f8f9fa;
}

.course-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.course-card {
  background: white;
  padding: 2rem;
  border-radius: 15px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
  transition: transform 0.3s ease;
}

.course-card:hover {
  transform: translateY(-5px);
}

.features-section {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2rem;
  padding: 4rem 5%;
}

.feature-card {
  text-align: center;
  padding: 2rem;
  border-radius: 15px;
  background: white;
  box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}

.cta-section {
  text-align: center;
  padding: 6rem 5%;
  background: #2c3e50;
  color: white;
}

.cta-buttons {
  margin-top: 2rem;
  display: flex;
  gap: 1rem;
  justify-content: center;
}
</style>