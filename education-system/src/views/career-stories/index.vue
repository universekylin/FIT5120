<template>
  <div class="career-stories">
    <nav
      class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top"
    >
      <div class="container">
        <router-link class="navbar-brand d-flex align-items-center" to="/">
          <span class="fw-bold">Education System</span>
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
              <router-link class="nav-link" to="/">Main</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/test">Test</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/career">Career</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link active" to="/career-stories">Career Stories</router-link>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="container py-5">
      <div class="text-center mb-5">
        <h1 class="fw-bold mb-3">Career Stories</h1>
        <p class="text-muted fs-5">
          Explore experiences and real stories shared by professionals!
        </p>
      </div>

      <!-- Category Section (Card Style) -->
      <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
          <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4">
              <h5 class="text-center fw-semibold mb-4">Browse Career Categories</h5>
              <div class="d-grid gap-3">
                <button 
                  v-for="category in categories" 
                  :key="category"
                  class="btn btn-outline-primary fw-semibold py-2 rounded-pill"
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

    <!-- Story modal -->
    <div
      class="modal fade"
      id="storyModal"
      tabindex="-1"
      aria-labelledby="storyModalLabel"
      aria-hidden="true"
      ref="storyModalRef"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="storyModalLabel">{{ selectedStory.title }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p>{{ selectedStory.description }}</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { Modal } from 'bootstrap';

const categories = [
  'Healthcare',
  'Technology',
  'Engineering',
  'Business',
  'Creative Arts',
  'Education',
];

const stories = [
  {
    id: 1,
    title: 'Life as a Software Engineer',
    category: 'Technology',
    description: 'I transitioned from a physics background into tech. It was a big leap but one I don’t regret. I now work in an AI startup...'
  },
  {
    id: 2,
    title: 'Nursing on the Frontlines',
    category: 'Healthcare',
    description: 'During the pandemic, my role in emergency care changed drastically. Here’s what it taught me about resilience...'
  },
  {
    id: 3,
    title: 'Teaching in Rural Schools',
    category: 'Education',
    description: 'Teaching Year 10 English in rural Victoria has its challenges, but it also brings deep rewards...'
  },
];

const selectedStory = ref({});
const filteredStories = ref([...stories]);
const storyModalRef = ref(null);

const filterByCategory = (category) => {
  filteredStories.value = stories.filter(s => s.category === category);
};

const viewStory = (story) => {
  selectedStory.value = story;
  const modal = new Modal(storyModalRef.value);
  modal.show();
};
</script>

<style scoped>
.card-title {
  font-size: 1.2rem;
  font-weight: 600;
}
.card-text {
  font-size: 0.95rem;
}
.btn-outline-primary {
  border-width: 2px;
}
</style>