<template>
  <div class="home">
    <!-- Navigation -->
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
            <li class="nav-item">
              <router-link class="nav-link active" to="/">Home</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/test">Career Quiz</router-link>
            </li>
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
      <div class="video-carousel">
        <!-- Video slides -->
        <div 
          v-for="(video, index) in videos" 
          :key="index"
          :class="['video-slide', { active: currentVideoIndex === index }]"
        >
          <video 
            v-if="video.src"
            :ref="el => setVideoRef(el, index)"
            autoplay 
            muted 
            loop 
            playsinline
            class="video-bg"
            @loadeddata="onVideoLoaded(index)"
            @error="onVideoError(index)"
          >
            <source :src="video.src" type="video/mp4">
          </video>
          
          <div 
            v-if="!videoLoaded[index]" 
            class="fallback-bg"
            :style="{ background: video.fallback }"
          ></div>
        </div>

        <!-- Navigation arrows -->
        <button 
          class="carousel-btn prev-btn" 
          @click="previousVideo" 
          :disabled="isTransitioning"
        >
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="15,18 9,12 15,6"></polyline>
          </svg>
        </button>
        
        <button 
          class="carousel-btn next-btn" 
          @click="nextVideo" 
          :disabled="isTransitioning"
        >
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9,18 15,12 9,6"></polyline>
          </svg>
        </button>

        <!-- Indicators -->
        <div class="carousel-indicators">
          <button 
            v-for="(video, index) in videos" 
            :key="index"
            :class="['indicator', { active: currentVideoIndex === index }]"
            @click="goToVideo(index)"
            :disabled="isTransitioning"
          ></button>
        </div>
      </div>

      <!-- Content Overlay -->
      <div class="overlay">
        <div 
          v-for="(video, index) in videos" 
          :key="`content-${index}`" 
          class="content-slide"
          :class="{ active: currentVideoIndex === index }"
        >
          <h1 class="main-title">{{ video.title }}</h1>
          <h2 class="sub-title">{{ video.subtitle }}</h2>
          <p class="description">{{ video.description }}</p>
          
          <div class="features-grid">
            <div 
              v-for="(feature, featureIndex) in video.features" 
              :key="featureIndex" 
              class="feature-item"
            >
              {{ feature }}
            </div>
          </div>
          
          <div class="cta-buttons">
            <router-link to="/test" class="cta-btn primary">🎯 Take Career Quiz</router-link>
            <router-link to="/subject" class="cta-btn secondary">📚 Check Subjects</router-link>
          </div>
        </div>
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
          <img 
            :src="item.icon" 
            :alt="item.label"
            class="cluster-icon"
            @error="handleIconError($event, index)"
          />
          <span class="cluster-label">{{ item.label }}</span>
        </div>
      </div>
    </section>

    <!-- Features -->
    <section class="features" id="start">
      <div class="feature-hero">
        <div class="feature-content">
          <h2 class="feature-title">
            <span class="title-line">Subject Checker</span>
            <span class="title-line">Availability</span>
            <span class="title-line highlight">Checker</span>
          </h2>
          <p class="feature-description">
            See if your school offers the VCE subjects you need, and get suggestions.
          </p>
          <router-link to="/subject" class="feature-btn">Check Now</router-link>
        </div>
        <div class="feature-images">
          <img src="@/assets/subject-availability.png" alt="Subject checker" class="main-image">
          <img src="@/assets/career-stories.png" alt="Career stories" class="secondary-image">
        </div>
      </div>
      
      <!-- Career Stories Section -->
      <div class="career-stories-section">
        <img src="@/assets/career-stories-design.png" alt="Career Stories" class="career-stories-image">
        <div class="stories-cta">
          <router-link to="/career-stories" class="story-btn">Explore Stories</router-link>
        </div>
      </div>
      
      <!-- Uni Virtual Explorer Section -->
      <div class="uni-explorer-section">
        <img src="@/assets/uni-virtual-explorer.png" alt="Uni Virtual Explorer" class="uni-explorer-image">
        <div class="explorer-cta">
          <router-link to="/three" class="explorer-btn">See how it Works</router-link>
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
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Video carousel data
const videos = ref([
  { 
    src: '/src/assets/hero-bg.mp4', 
    title: 'VCE Subject Selection',
    subtitle: 'Your Pathway to Success',
    description: 'Choose the right VCE subjects that align with your career goals. Our platform helps you understand prerequisite requirements and make informed decisions for your future university studies.',
    features: ['📚 Subject Prerequisites', '🎯 Career Alignment', '📊 ATAR Calculations', '🏫 School Availability'],
    fallback: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'
  },
  { 
    src: '/src/assets/hero-bg2.mp4', 
    title: 'Career Exploration',
    subtitle: 'Discover Your Dream Job',
    description: 'Explore diverse career paths across nine industry clusters. From healthcare to technology, find careers that match your interests and learn about the subjects you need to get there.',
    features: ['💼 9 Career Clusters', '❤️ Interest Matching', '📈 Job Market Insights', '💰 Salary Information'],
    fallback: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)'
  },
  { 
    src: '/src/assets/hero-bg3.mp4', 
    title: 'University Pathways',
    subtitle: 'Plan Your Higher Education',
    description: 'Navigate university entrance requirements and explore study options. Connect your VCE subject choices to specific university courses and understand alternative pathways to your chosen career.',
    features: ['🎓 University Requirements', '🔄 Alternative Pathways', '📍 Regional Opportunities', '💡 Course Recommendations'],
    fallback: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)'
  }
])

// State
const currentVideoIndex = ref(0)
const isTransitioning = ref(false)
const videoRefs = ref([])
const autoPlayTimer = ref(null)
const videoLoaded = ref([])

// Career clusters with image icons
const clusters = [
  { 
    label: 'Agriculture, Environment & Natural Sciences', 
    value: "Agriculture Environment And Natural Sciences", 
    icon: '/src/assets/icons/agriculture.png', // 或者使用 .png/.jpg
    animationClass: 'hover-draw' 
  },
  { 
    label: 'Business & Management', 
    value: "Business And Management", 
    icon: '/src/assets/icons/business.png',
    animationClass: 'hover-code' 
  },
  { 
    label: 'Creative Arts, Media, Communication & Journalism', 
    value: "Creative Arts Media Communication and Journalism", 
    icon: '/src/assets/icons/creative-arts.png',
    animationClass: 'hover-draw' 
  },
  { 
    label: 'Education & Social Sciences', 
    value: "Education And Social Sciences", 
    icon: '/src/assets/icons/education.png',
    animationClass: 'hover-flipbook' 
  },
  { 
    label: 'Engineering & Science', 
    value: "Engineering And Science", 
    icon: '/src/assets/icons/engineering.png',
    animationClass: 'hover-code' 
  },
  { 
    label: 'Health & Human Services', 
    value: "Health And Human Services", 
    icon: '/src/assets/icons/health.png',
    animationClass: 'hover-heartbeat' 
  },
  { 
    label: 'IT & Data', 
    value: "IT And Data", 
    icon: '/src/assets/icons/it-data.png',
    animationClass: 'hover-code' 
  },
  { 
    label: 'Law & Public Services', 
    value: "Law And Public Services", 
    icon: '/src/assets/icons/law.png',
    animationClass: 'hover-flipbook' 
  },
  { 
    label: 'Math & Theoretical Sciences', 
    value: "Math And Theoretical Sciences", 
    icon: '/src/assets/icons/math.png',
    animationClass: 'hover-draw' 
  }
]

// Methods
function setVideoRef(el, index) {
  if (el) {
    videoRefs.value[index] = el
  }
}

function nextVideo() {
  if (isTransitioning.value) return
  
  isTransitioning.value = true
  currentVideoIndex.value = (currentVideoIndex.value + 1) % videos.value.length
  
  setTimeout(() => {
    isTransitioning.value = false
  }, 500)
  
  resetAutoPlay()
}

function previousVideo() {
  if (isTransitioning.value) return
  
  isTransitioning.value = true
  currentVideoIndex.value = currentVideoIndex.value === 0 
    ? videos.value.length - 1 
    : currentVideoIndex.value - 1
  
  setTimeout(() => {
    isTransitioning.value = false
  }, 500)
  
  resetAutoPlay()
}

function goToVideo(index) {
  if (isTransitioning.value || index === currentVideoIndex.value) return
  
  isTransitioning.value = true
  currentVideoIndex.value = index
  
  setTimeout(() => {
    isTransitioning.value = false
  }, 500)
  
  resetAutoPlay()
}

function startAutoPlay() {
  if (videos.value.length > 1) {
    autoPlayTimer.value = setInterval(() => {
      nextVideo()
    }, 3000)
  }
}

function stopAutoPlay() {
  if (autoPlayTimer.value) {
    clearInterval(autoPlayTimer.value)
    autoPlayTimer.value = null
  }
}

function resetAutoPlay() {
  stopAutoPlay()
  startAutoPlay()
}

function onVideoLoaded(index) {
  console.log(`Video ${index + 1} loaded successfully`)
  videoLoaded.value[index] = true
  if (index === currentVideoIndex.value && videoRefs.value[index]) {
    videoRefs.value[index].play().catch(e => {
      console.error(`Error playing video ${index + 1}:`, e)
    })
  }
}

function onVideoError(index) {
  console.error(`Error loading video ${index + 1}:`, videos.value[index].src)
  videoLoaded.value[index] = false
}

function handleIconError(event, index) {
  console.error(`Icon failed to load for ${clusters[index].label}`)
  // 如果图片加载失败，可以设置一个默认图片或者隐藏
  event.target.style.display = 'none'
}

function handleClick(item) {
  router.push({
    name: 'career',
    query: { careers: item.value, type: "job" }
  })
}

// Lifecycle
onMounted(() => {
  videoLoaded.value = new Array(videos.value.length).fill(false)
  startAutoPlay()
  
  const handleKeydown = (event) => {
    if (event.key === 'ArrowLeft') {
      previousVideo()
    } else if (event.key === 'ArrowRight') {
      nextVideo()
    }
  }
  
  window.addEventListener('keydown', handleKeydown)
  
  onUnmounted(() => {
    window.removeEventListener('keydown', handleKeydown)
    stopAutoPlay()
  })
})

onUnmounted(() => {
  stopAutoPlay()
})
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

.video-carousel {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.video-slide {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
  transition: opacity 0.5s ease-in-out;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.video-slide.active {
  opacity: 1;
}

.video-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  z-index: 2;
}

.fallback-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  z-index: 1;
}

.carousel-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 3;
  background: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.carousel-btn:hover:not(:disabled) {
  background: rgba(255, 255, 255, 0.3);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-50%) scale(1.1);
}

.carousel-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.prev-btn {
  left: 2rem;
}

.next-btn {
  right: 2rem;
}

.carousel-indicators {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  z-index: 3;
  display: flex;
  gap: 0.8rem;
}

.indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: 2px solid rgba(255, 255, 255, 0.5);
  background: rgba(255, 255, 255, 0.3);
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(5px);
}

.indicator.active {
  background: rgba(255, 255, 255, 0.9);
  border-color: rgba(255, 255, 255, 0.9);
  transform: scale(1.2);
}

.indicator:hover:not(:disabled) {
  background: rgba(255, 255, 255, 0.6);
  transform: scale(1.1);
}

.indicator:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.overlay {
  position: relative;
  z-index: 4;
  text-align: center;
  max-width: 900px;
  padding: 2.5rem;
  background: rgba(0, 0, 0, 0.6);
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
  color: white;
  backdrop-filter: blur(15px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.content-slide {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease-in-out;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
}

.content-slide.active {
  opacity: 1;
  transform: translateY(0);
  position: relative;
}

.main-title {
  font-size: 3.2rem;
  font-weight: 800;
  margin-bottom: 0.5rem;
  background: linear-gradient(135deg, #ff6b6b, #4ecdc4, #45b7d1);
  background-size: 200% 200%;
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: gradientShift 3s ease-in-out infinite;
}

@keyframes gradientShift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

.sub-title {
  font-size: 1.6rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  color: #e0e6ed;
  opacity: 0.9;
}

.description {
  font-size: 1.3rem;
  line-height: 1.6;
  margin-bottom: 2rem;
  color: #f1f5f9;
  max-width: 700px;
  margin-left: auto;
  margin-right: auto;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  margin-bottom: 2.5rem;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

.feature-item {
  background: rgba(255, 255, 255, 0.1);
  padding: 0.8rem 1.2rem;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 500;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
}

.feature-item:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-2px);
}

.cta-buttons {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

.cta-btn {
  padding: 12px 24px;
  border-radius: 12px;
  text-decoration: none;
  font-weight: 600;
  font-size: 1.1rem;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.cta-btn.primary {
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.cta-btn.primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
}

.cta-btn.secondary {
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border-color: rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
}

.cta-btn.secondary:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-2px);
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
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
  justify-items: center;
}

.cluster-box {
  width: 100%;
  max-width: 320px;
  background: #ffffff;
  border-radius: 20px;
  padding: 0;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
  cursor: pointer;
  transition: all 0.4s ease;
  text-align: center;
  overflow: hidden;
  border: 1px solid rgba(0, 0, 0, 0.04);
}

.cluster-box:hover {
  transform: translateY(-12px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
  border-color: rgba(102, 126, 234, 0.2);
}

.cluster-icon {
  width: 100%;
  height: 200px;
  object-fit: cover;
  border-radius: 0;
  margin-bottom: 0;
  transition: all 0.4s ease;
}

.cluster-box:hover .cluster-icon {
  transform: scale(1.08);
}

.cluster-label {
  font-size: 1.1rem;
  line-height: 1.4;
  color: #1f2937;
  font-weight: 600;
  padding: 1.5rem;
  background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
  margin: 0;
  border-radius: 0 0 20px 20px;
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
  padding: 6rem 2rem;
  background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
  margin-top: 0;
}

.feature-hero {
  display: flex;
  align-items: center;
  gap: 4rem;
  max-width: 1400px;
  margin: 0 auto;
  min-height: 500px;
}

.feature-content {
  flex: 1;
  max-width: 500px;
}

.feature-title {
  font-size: 4rem;
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 2rem;
  color: #1f2937;
}

.title-line {
  display: block;
}

.title-line.highlight {
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

.feature-description {
  font-size: 1.4rem;
  color: #6b7280;
  line-height: 1.6;
  margin-bottom: 3rem;
}

.feature-btn {
  display: inline-block;
  padding: 1rem 2.5rem;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  text-decoration: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1.2rem;
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
  transition: all 0.3s ease;
}

.feature-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
}

.feature-images {
  flex: 1;
  position: relative;
  display: flex;
  gap: 1.5rem;
  align-items: flex-start;
}

.main-image {
  width: 280px;
  height: 380px;
  object-fit: cover;
  border-radius: 20px;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.secondary-image {
  width: 240px;
  height: 320px;
  object-fit: cover;
  border-radius: 20px;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
  margin-top: 2rem;
  transition: all 0.3s ease;
}

.main-image:hover,
.secondary-image:hover {
  transform: translateY(-8px);
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
}

.career-stories-section {
  margin-top: 4rem;
  background: rgba(255, 255, 255, 0.6);
  border-radius: 20px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  overflow: hidden;
  text-align: center;
  padding: 2rem;
}

.career-stories-image {
  width: 100%;
  max-width: 1200px;
  height: auto;
  border-radius: 16px;
  margin-bottom: 2rem;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.stories-cta {
  margin-top: 2rem;
}

.story-btn {
  display: inline-block;
  padding: 1rem 2.5rem;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  text-decoration: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1.2rem;
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
  transition: all 0.3s ease;
}

.uni-explorer-section {
  margin-top: 4rem;
  background: rgba(255, 255, 255, 0.6);
  border-radius: 20px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  overflow: hidden;
  text-align: center;
  padding: 2rem;
}

.uni-explorer-image {
  width: 100%;
  max-width: 1200px;
  height: auto;
  border-radius: 16px;
  margin-bottom: 2rem;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.explorer-cta {
  margin-top: 2rem;
}

.explorer-btn {
  display: inline-block;
  padding: 1rem 2.5rem;
  background: linear-gradient(135deg, #8b5cf6, #ec4899);
  color: white;
  text-decoration: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1.2rem;
  box-shadow: 0 8px 25px rgba(139, 92, 246, 0.3);
  transition: all 0.3s ease;
}

.explorer-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 35px rgba(139, 92, 246, 0.4);
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

@media (max-width: 768px) {
  .carousel-btn {
    width: 40px;
    height: 40px;
  }
  
  .prev-btn {
    left: 1rem;
  }
  
  .next-btn {
    right: 1rem;
  }
  
  .carousel-indicators {
    bottom: 1rem;
  }
  
  .cluster-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
    padding: 1rem;
  }
  
  .cluster-box {
    max-width: 100%;
  }
  
  .cluster-icon {
    height: 160px;
  }
  
  .overlay {
    max-width: 95%;
    padding: 1.5rem;
  }
  
  .main-title {
    font-size: 2.2rem;
  }
  
  .sub-title {
    font-size: 1.3rem;
  }
  
  .description {
    font-size: 1.1rem;
  }
  
  .features-grid {
    grid-template-columns: 1fr;
    gap: 0.8rem;
  }
  
  .cta-buttons {
    flex-direction: column;
    align-items: center;
  }
  
  .cta-btn {
    width: 200px;
  }
  
  .feature-hero {
    flex-direction: column;
    gap: 2rem;
    text-align: center;
    padding: 0 1rem;
  }
  
  .feature-title {
    font-size: 2.8rem;
  }
  
  .career-stories-image {
    max-width: 100%;
  }
}

@media (max-width: 480px) {
  .overlay {
    padding: 1rem;
    margin: 0 10px;
  }
  
  .main-title {
    font-size: 1.8rem;
  }
  
  .sub-title {
    font-size: 1.1rem;
  }
  
  .description {
    font-size: 1rem;
  }
  
  .carousel-indicators {
    gap: 0.5rem;
  }
  
  .indicator {
    width: 10px;
    height: 10px;
  }
  
  .cluster-icon {
    height: 140px;
  }
  
  .cluster-label {
    font-size: 1rem;
    padding: 1rem;
  }
  
  .feature-title {
    font-size: 2.2rem;
  }
  
  .feature-description {
    font-size: 1.1rem;
  }
  
  .feature-images {
    flex-direction: column;
    align-items: center;
  }
  
  .main-image {
    width: 280px;
    height: 300px;
  }
  
  .secondary-image {
    width: 240px;
    height: 260px;
    margin-top: 1rem;
  }
  
  .career-stories-section {
    padding: 1rem;
  }
  
  .career-stories-image {
    max-width: 100%;
  }
  
  .uni-explorer-section {
    padding: 1rem;
  }
  
  .uni-explorer-image {
    max-width: 100%;
  }
}
</style>