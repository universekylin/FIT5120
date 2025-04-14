<template>
  <div class="home">
    <!-- Hero Section -->
    <section class="hero">
      <img src="@/assets/hero-illustration.png" alt="Students in library" class="hero-banner" />
      <div class="hero-overlay">
        <div class="hero-text-box">
          <h1>Not sure what to study after high school?</h1>
          <p>
            Explore careers, find matching uni courses, and check if your school offers the subjects you need.
          </p>
          <button @click="scrollToStart">Start Your Path</button>
        </div>
      </div>
    </section>

    <!-- How It Works -->
    <section class="how-it-works">
      <h2>How It Works</h2>
      <div class="steps">
        <div class="step">
          <img src="@/assets/career-search.png" alt="Career search" />
          <p>Discover your career interests</p>
        </div>
        <div class="step">
          <img src="@/assets/university-match.png" alt="University courses" />
          <p>Match university courses</p>
        </div>
        <div class="step">
          <img src="@/assets/subject-check.png" alt="Subject checker" />
          <p>Check your school subject options</p>
        </div>
      </div>
    </section>

    <!-- Features -->
    <section class="features" id="start">
      <h2>Feature Highlights</h2>
      <div class="feature-cards">
        <div class="feature-card">
          <img src="@/assets/subject-availability.png" alt="Subject checker" />
          <h3>Subject Availability Checker</h3>
          <p>See if your school offers the VCE subjects you need, and get suggestions.</p>
          <router-link to="/subject-checker">Check Now</router-link>
        </div>

        <div class="feature-card">
          <img src="@/assets/career-stories.png" alt="Career stories" />
          <h3>Career Stories</h3>
          <p>Read real-life stories to learn about different jobs.</p>
          <router-link to="/stories">Explore Stories</router-link>
        </div>

        <div class="feature-card">
          <img src="@/assets/chatbot.png" alt="Chatbot" />
          <h3>AI Chatbot</h3>
          <p>Have questions? Get answers about ATAR, subjects, and more.</p>
          <router-link to="/chatbot">Chat Now</router-link>
        </div>
      </div>
    </section>

    <!-- Quiz Section -->
    <section class="quiz-call">
      <img src="@/assets/quiz.png" alt="Quiz" class="quiz-img" />
      <h2>Explore Your Future</h2>
      <p>Not sure where to start? Take our quick quiz to find your interests!</p>
      <router-link to="/quiz" class="quiz-btn">Take the Quiz</router-link>
    </section>

    <!-- Footer -->
    <footer class="site-footer">
      <div class="footer-content">
        <p>&copy; 2025 CareerPath Finder. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: "HomeView",
  methods: {
    scrollToStart() {
      const el = document.getElementById("start");
      if (el) el.scrollIntoView({ behavior: "smooth" });
    }
  }
};
</script>

<style scoped>
.home {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}

.hero {
  position: relative;
  width: 100%;
  height: 520px;
  overflow: hidden;
}

.hero-banner {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center 15%;
  display: block;
}

.hero-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  padding: 1rem;
  display: flex;
  flex-direction: column;
  justify-content: flex-end; 
  align-items: center;
  text-align: center;
  background: rgba(0, 0, 0, 0.3);
  color: white;
  padding-bottom: 2rem;
}

.hero-text-box {
  background: rgba(0, 0, 0, 0.55);
  padding: 2rem 2.5rem;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(6px);
  max-width: 680px;
  width: 90%;
  transition: transform 0.3s ease;
}

.hero-text-box:hover {
  transform: translateY(-4px);
}

.hero-overlay h1 {
  font-size: 2.3rem;
  font-weight: bold;
  margin-bottom: 1rem;
}

.hero-overlay p {
  font-size: 1.1rem;
  margin: 0 1rem 1.5rem;
  max-width: 660px;
  line-height: 1.5;
  color: #eee;
}

.hero-overlay button {
  padding: 0.75rem 1.5rem;
  background-color: #00b894;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.hero-overlay button:hover {
  background-color: #009e7d;
}

.how-it-works,
.features {
  text-align: center;
  padding: 4rem 1rem;
  background-color: #f9f9f9;
  border-radius: 20px;
  margin-bottom: 3rem;
}

.how-it-works h2,
.features h2 {
  font-size: 2rem;
  margin-bottom: 2rem;
}

.steps,
.feature-cards {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 2rem;
}

.step,
.feature-card {
  background: white;
  border-radius: 12px;
  padding: 2rem;
  width: 480px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  transition: transform 0.3s ease;
}

.step:hover,
.feature-card:hover {
  transform: translateY(-6px);
}

.step img,
.feature-card img {
  max-width: 400px;
  margin-bottom: 1rem;
}

.step p,
.feature-card p {
  font-size: 1.2rem;
  line-height: 1.5;
  color: #333;
}

.quiz-call {
  text-align: center;
  padding: 3rem 1rem;
}

.quiz-img {
  width: 100%;
  max-width: 620px;
  height: auto;
  margin-bottom: 1rem;
  border-radius: 10px;
}

.quiz-call h2 {
  font-size: 1.6rem;
}

.quiz-call p {
  font-size: 1.2rem;
  margin-bottom: 1rem;
  color: #444;
}

.quiz-btn {
  display: inline-block;
  margin-top: 0.5rem;
  padding: 0.6rem 1.25rem;
  background-color: #ffc107;
  border-radius: 16px;
  color: #000;
  text-decoration: none;
  font-weight: bold;
  transition: background-color 0.3s;
}

.quiz-btn:hover {
  background-color: #e0a900;
}

.site-footer {
  background-color: #2f2f2f;
  color: #ddd;
  padding: 4rem 1rem;
  text-align: center;
  margin-top: 6rem;
  border-top: 4px solid #00b894;
}

.footer-content {
  max-width: 960px;
  margin: 0 auto;
}

.footer-content p {
  margin-bottom: 0;
  font-size: 1.2rem;
}
</style>
