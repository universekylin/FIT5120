<template>
  <div class="career-stories bg-light min-vh-100">
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
      <div class="container">
        <router-link class="navbar-brand fw-bold" to="/">Education System</router-link>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item"><router-link class="nav-link" to="/">Main</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/test">Test</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/career">Career</router-link></li>
            <li class="nav-item"><router-link class="nav-link active" to="/career-stories">Career Stories</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/subject">Subject</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/secondary-college">College</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/chatbot">Chat Bot</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/three">Our University</router-link></li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Page Header -->
    <div class="container py-5 text-center">
      <h1 class="fw-bold mb-3">Career Stories</h1>
      <p class="text-muted fs-5">Explore experiences and real stories shared by professionals</p>
      <p class="text-muted">📍 Your current location: {{ userLocation }}</p>
    </div>

    <!-- Category Buttons -->
    <div class="container mb-5">
      <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
          <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4">
              <h5 class="text-center fw-semibold mb-3">Browse Career Categories</h5>
              <div class="d-flex flex-wrap gap-2 justify-content-center">
                <button
                  v-for="category in filteredCategories"
                  :key="category"
                  class="btn btn-outline-primary category-btn"
                  @click="filterByCategory(category)"
                >
                  {{ category }}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Story List -->
    <div v-if="stories.length > 0" class="container pb-5">
      <div class="row justify-content-center">
        <div class="col-lg-10">
          <div class="story-feed-no-card">
            <h4 class="mb-0">Stories from Reddit</h4>
            <div class="story-feed-divider"></div>
            <div v-for="(story, index) in stories" :key="index" class="story-feed-item">
              <a :href="story.url" target="_blank" rel="noopener noreferrer" class="story-title-link">
                {{ story.title }}
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="container pb-5 text-center">
      <p class="text-muted">No stories found. Please select a different category.</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import storyData from '@/assets/data/career_stories.json';

const categories = [
  'Agriculture', 'Business', 'Creative Arts', 'Education',
  'Engineering', 'Health', 'IT & Data', 'Law', 'Math'
];

const userLocation = ref('Locating...');
const stories = ref([]);
const careerStories = ref(storyData);
const filteredCategories = computed(() => categories);

const filterByCategory = (category) => {
  // 直接从分类中获取故事
  stories.value = careerStories.value[category] || [];
};

const getCityFromCoords = async (lat, lon) => {
  try {
    const response = await fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}`);
    const data = await response.json();
    const city = data.address.city || data.address.town || data.address.village || data.address.state || 'Unknown';
    userLocation.value = city;
  } catch (error) {
    userLocation.value = 'Location fetch failed';
  }
};

onMounted(() => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      position => getCityFromCoords(position.coords.latitude, position.coords.longitude),
      () => userLocation.value = 'Unable to retrieve location'
    );
  }
});
</script>

<style scoped>
body {
  font-family: 'Inter', sans-serif;
}

/* Category button styles */
.category-btn {
  border-width: 2px;
  border-radius: 999px;
  padding: 8px 18px;
  font-weight: 600;
  transition: all 0.2s ease-in-out;
}
.category-btn:hover {
  background-color: #0d6efd;
  color: white;
}

/* Main container for stories */
.story-feed-no-card {
  background: #fff;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

/* Divider under 'Stories from Reddit' */
.story-feed-divider {
  border-bottom: 1px solid #e6e6e6;
  margin: 12px 0;
}

/* Each story row */
.story-feed-item {
  padding: 12px 0;
  border-bottom: 1px solid #e6e6e6;
}
.story-feed-item:last-child {
  border-bottom: none;
}

/* Link styling */
.story-title-link {
  font-size: 1.05rem;
  color: #0d6efd;
  font-weight: 600;
  text-decoration: none;
}
.story-title-link:hover {
  text-decoration: underline;
}

/* Background */
.bg-light {
  background-color: #f8f9fa;
}
</style>
