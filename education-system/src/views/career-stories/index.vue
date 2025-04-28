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
            <li class="nav-item">
              <router-link class="nav-link" to="/chatbot">Chat Bot</router-link>
            </li>
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

    <!-- Filter Section -->
    <div class="container mb-5">
      <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
          <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4">
              <!-- City Dropdown -->
              <label class="form-label fw-semibold">Select City</label>
              <select class="form-select mb-3" v-model="selectedCity">
                <option value="">All Cities</option>
                <option v-for="city in cities" :key="city" :value="city">{{ city }}</option>
              </select>

              <!-- Category Buttons -->
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

    <!-- Story List (Reddit Style) with Thumbnails -->
    <div v-if="stories.length > 0" class="container pb-5">
      <div class="row justify-content-center">
        <div class="col-lg-10">
          <div class="story-feed">
            <h4 class="mb-4">Stories from Reddit</h4>
            <div
              v-for="(story, index) in stories"
              :key="index"
              class="story-card"
            >
              <!-- With thumbnail layout -->
              <div class="d-flex" v-if="story.image">
                <!-- Thumbnail image -->
                <div class="story-thumbnail me-3">
                  <img :src="story.image" alt="Post thumbnail" class="rounded" style="width: 80px; height: 80px; object-fit: cover;" />
                </div>
                
                <!-- Story content -->
                <div class="story-content">
                  <a :href="story.url" target="_blank" class="story-title">
                    {{ story.title }}
                  </a>
                  <p class="story-preview">{{ story.preview }}</p>
                  <div class="story-meta">
                    <small class="text-muted"><i class="bi bi-arrow-up-short"></i> {{ story.score || 0 }} upvotes</small>
                  </div>
                </div>
              </div>
              
              <!-- Without thumbnail layout -->
              <div v-else>
                <a :href="story.url" target="_blank" class="story-title">
                  {{ story.title }}
                </a>
                <p class="story-preview">{{ story.preview }}</p>
                <div class="story-meta">
                  <small class="text-muted"><i class="bi bi-arrow-up-short"></i> {{ story.score || 0 }} upvotes</small>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div v-else class="container pb-5 text-center">
      <p class="text-muted">No stories found. Please select a different category or city.</p>
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

const cities = [
  'Melbourne', 'Sydney', 'Brisbane', 'Perth',
  'Adelaide', 'Canberra', 'Hobart', 'Darwin'
];

const selectedCity = ref('');
const userLocation = ref('Locating...');
const stories = ref([]);
const careerStories = ref(storyData);

const filteredCategories = computed(() => categories);

const filterByCategory = (category) => {
  const city = selectedCity.value;
  if (city && careerStories.value[city] && careerStories.value[city][category]) {
    stories.value = careerStories.value[city][category];
  } else {
    stories.value = [];
  }
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
      position => {
        getCityFromCoords(position.coords.latitude, position.coords.longitude);
      },
      () => {
        userLocation.value = 'Unable to retrieve location';
      }
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

/* Story card container */
.story-feed {
  background: #fff;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

/* Each story Reddit style card */
.story-card {
  padding: 20px 0;
  border-bottom: 1px solid #eee;
}
.story-card:last-child {
  border-bottom: none;
}

.story-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: #0d6efd;
  text-decoration: none;
  display: block;
}
.story-title:hover {
  text-decoration: underline;
}

.story-preview {
  font-size: 0.9rem;
  color: #666;
  margin-top: 6px;
  margin-bottom: 6px;
}

.story-meta {
  font-size: 0.8rem;
}

/* Thumbnail styles */
.story-thumbnail img {
  border: 1px solid #eee;
}

/* Overall background */
.bg-light {
  background-color: #f8f9fa;
}
</style>