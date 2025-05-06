<template>
<<<<<<< HEAD
  <div class="major">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
      <div class="container">
        <router-link class="navbar-brand d-flex align-items-center" to="/">
          <span class="fw-bold">Education System</span>
        </router-link>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item"><router-link class="nav-link" to="/">Home</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/test">Test</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/career">Career</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/career-stories">Career Stories</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/subject">Subject</router-link></li>
            <li class="nav-item"><router-link class="nav-link active" to="/secondary-college">College</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/chatbot">Chat Bot</router-link></li>
          </ul>
=======
    <div class="major">
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
            <div class="container">
                <router-link class="navbar-brand d-flex align-items-center" to="/">
                    <span class="fw-bold">Education System</span>
                </router-link>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <router-link class="nav-link" to="/">Home</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/test">Test</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/career">Career</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/career-stories">Career Stories</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link active" to="/subject">Subject</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/secondary-college">College</router-link>
                        </li>
                        <li class="nav-item">
                        <router-link class="nav-link" to="/chatbot">Chat Bot</router-link>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="school-search-container">
            <!-- Search box -->
            <div class="search-box card shadow-sm mb-4">
                <div class="card-body">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-lg"
                            placeholder="Enter Secondary School name" v-model="searchQuery"
                            @keyup.enter="searchSchools">
                        <button class="btn btn-primary btn-lg" @click="searchSchools" :disabled="isLoading">
                            <span v-if="!isLoading">Search</span>
                            <span v-else>
                                <span class="spinner-border spinner-border-sm me-1"></span>
                                Searching...
                            </span>
                        </button>
                    </div>
                    <div v-if="errorMessage" class="alert alert-warning mt-3 mb-0">
                        {{ errorMessage }}
                    </div>
                </div>
            </div>

            <!-- Search results -->
            <div v-if="searchResults.length > 0" class="search-results">
                <div class="result-count mb-3">
                    Found <span class="badge bg-primary">{{ searchResults.length }}</span> matching schools
                </div>

                <!-- School list -->
                <div class="school-list">
                    <div v-for="school in searchResults" :key="school.id" class="school-card card mb-4">
                        <div class="card-header bg-light">
                            <h4 class="mb-0">
                                {{ school.name }}
                                <a :href="getLocationLink(school.name)" target="_blank" class="float-end text-muted ms-2">Location</a>
                            </h4>
                        </div>
                        <div class="card-body">
                            <!-- Major list -->
                            <h5 class="mb-3">Offered Subject ({{ school.subjects.length }})</h5>
                            <div class="subjects-container">
                                <div v-for="(major, index) in school.subjects" :key="index"
                                    class="major-item card mb-2">
                                    <div class="card-body py-2">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="mb-1">{{ major.name }}</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
>>>>>>> 5f1fac9a833b8d60c4919f3a4842d99a23e573ce
        </div>
      </div>
    </nav>

    <div class="school-search-container">
      <!-- Search box -->
      <div class="search-box card shadow-sm mb-4">
        <div class="card-body">
          <div class="input-group">
            <input type="text" class="form-control form-control-lg"
                   placeholder="Enter Secondary School name"
                   v-model="searchQuery" @keyup.enter="searchSchools">
            <button class="btn btn-primary btn-lg" @click="searchSchools" :disabled="isLoading">
              <span v-if="!isLoading">Search</span>
              <span v-else>
                <span class="spinner-border spinner-border-sm me-1"></span>
                Searching...
              </span>
            </button>
          </div>
          <div v-if="errorMessage" class="alert alert-warning mt-3 mb-0">
            {{ errorMessage }}
          </div>
        </div>
      </div>

      <!-- Search results -->
      <div v-if="searchResults.length > 0" class="search-results">
        <div class="result-count mb-3">
          Found <span class="badge bg-primary">{{ searchResults.length }}</span> matching schools
        </div>

        <!-- School list -->
        <div class="school-list">
          <div v-for="school in searchResults" :key="school.id" class="school-card card mb-4">
            <div class="card-header bg-light d-flex justify-content-between align-items-center">
              <h4 class="mb-0">
                {{ school.name }}
                <a :href="getLocationLink(school.name)" target="_blank" class="text-muted ms-3">Location</a>
              </h4>
              <button class="btn btn-outline-primary btn-sm" @click="toggleSubjects(school.id)">
                {{ expandedSchools[school.id] ? 'Hide Subjects' : 'Show Subjects' }}
              </button>
            </div>
            <div class="card-body" v-if="expandedSchools[school.id]">
              <h5 class="mb-3">Offered Subject ({{ school.subjects.length }})</h5>
              <div class="subjects-container">
                <div v-for="(major, index) in school.subjects" :key="index" class="major-item card mb-2">
                  <div class="card-body py-2">
                    <h6 class="mb-1">{{ major.name }}</h6>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script setup>
import { ref } from 'vue'

// State
const searchQuery = ref('')
const searchResults = ref([])
const isLoading = ref(false)
const errorMessage = ref('')
const expandedSchools = ref({})

// Search function
const searchSchools = async () => {
  if (!searchQuery.value.trim()) {
    errorMessage.value = 'Please enter a school name'
    searchResults.value = []
    return
  }

  isLoading.value = true
  errorMessage.value = ''

  try {
    const response = await fetch(`/api/secondary_colleges?college_name=${encodeURIComponent(searchQuery.value.trim())}`)
    if (!response.ok) throw new Error('Search failed, please try again later')

    const data = await response.json()
    if (data.error) throw new Error(data.error)

    searchResults.value = data.data || []
    if (searchResults.value.length === 0) {
      errorMessage.value = `No schools found containing "${searchQuery.value}"`
    }

    expandedSchools.value = {}
    searchResults.value.forEach(school => {
      expandedSchools.value[school.id] = false
    })

  } catch (err) {
    errorMessage.value = err.message
    searchResults.value = []
    expandedSchools.value = {}
  } finally {
    isLoading.value = false
  }
}

// Toggle subject visibility
const toggleSubjects = (schoolId) => {
  expandedSchools.value[schoolId] = !expandedSchools.value[schoolId]
}

// Get Google Maps location link
const getLocationLink = (location) => {
  return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(location)}`
}
</script>

<style scoped>
.school-search-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40px 16px;
}

.search-box {
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  border: 1px solid #e0e0e0;
  padding: 12px 20px;
  max-width: 900px; 
  width: 100%;
}

.search-results {
  width: 100%;
  max-width: 900px;
  margin-top: 24px;
  padding: 0 16px;
}



.input-group {
  display: flex;
  align-items: stretch;
}

.input-group .form-control {
  border-top-left-radius: 8px;
  border-bottom-left-radius: 8px;
  border-top-right-radius: 0;
  border-bottom-right-radius: 0;
  font-size: 16px;
  padding: 10px 16px;
  box-shadow: none;
}

.input-group .btn {
  border-top-left-radius: 0;
  border-bottom-left-radius: 0;
  border-top-right-radius: 8px;
  border-bottom-right-radius: 8px;
  padding: 10px 20px;
  font-size: 16px;
}

.result-count {
  font-size: 1.1rem;
  color: #6c757d;
  text-align: center;
  margin-bottom: 1rem;
}

.school-card {
  max-width: 900px;
  margin: 0 auto 1.5rem;
  transition: all 0.2s ease;
  border: 1px solid rgba(0, 0, 0, 0.125);
}

.school-card:hover {
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  padding: 1rem 1.25rem;
}

.major-item {
  transition: all 0.2s ease;
  border-left: 3px solid var(--bs-primary);
}

.major-item:hover {
  background-color: #f8f9fa;
}

@media (max-width: 768px) {
  .input-group {
    flex-direction: column;
  }

  .input-group .form-control,
  .input-group .btn {
    border-radius: 8px !important;
    width: 100%;
    margin-bottom: 10px;
  }

  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
}
</style>

