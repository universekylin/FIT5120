<template>
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
            <li class="nav-item"><router-link class="nav-link" to="/career-stories">Career Stories</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/subject">High School</router-link></li>
            <li class="nav-item"><router-link class="nav-link active" to="/secondary-college">Subject</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/chatbot">Chat Bot</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/three">Our University</router-link></li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="school-search-container">
      <!-- Subject Suggestions -->
      <div v-if="subjectSuggestions.length > 0" class="subject-suggestions mb-4 w-100">
        <div class="d-flex align-items-start flex-wrap" style="max-width: 900px; margin: 0 auto; padding: 0 16px;">
          <strong class="me-2 mt-1">Try:</strong>
          <button
            v-for="(subject, index) in subjectSuggestions"
            :key="index"
            class="btn btn-outline-secondary btn-sm me-2 mb-2"
            @click="selectSuggestion(subject)"
          >
            {{ subject }}
          </button>
        </div>
      </div>

      <!-- Search box -->
      <div class="search-box card shadow-sm mb-4">
        <div class="card-body">
          <div class="input-group">
            <input type="text" class="form-control form-control-lg"
                   placeholder="Enter Subject name"
                   v-model="searchQuery"
                   @keyup.enter="searchSubjects">
            <button class="btn btn-primary btn-lg" @click="searchSubjects" :disabled="isLoading">
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
          Found <span class="badge bg-primary">{{ searchResults.length }}</span> matching subjects with colleges
        </div>

        <!-- Subject list -->
        <div class="school-list">
          <div v-for="subject in searchResults" :key="subject.subject_id" class="school-card card mb-4">
            <div class="card-header bg-light d-flex justify-content-between align-items-center">
              <h4 class="mb-0" style="cursor: pointer;" @click="toggleSubject(subject.subject_id)">
                {{ subject.subject_name }}
              </h4>
              <button class="btn btn-outline-primary btn-sm" @click="toggleSubject(subject.subject_id)">
                {{ expandedSubjects[subject.subject_id] ? 'Hide Colleges' : 'Show Colleges' }}
              </button>
            </div>
            <div class="card-body" v-if="expandedSubjects[subject.subject_id]">
              <h5 class="mb-3">Offered By Colleges ({{ subject.secondaryColleges.length }})</h5>
              <div class="subjects-container">
                <div v-for="college in subject.secondaryColleges" :key="college.college_id" class="major-item card mb-2">
                  <div class="card-body py-2 d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">{{ college.college_name }}</h6>
                    <a :href="getLocationLink(college.college_name)" target="_blank" class="text-muted ms-2">Location</a>
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
import { ref, onMounted } from 'vue'

const searchQuery = ref('')
const searchResults = ref([])
const subjectSuggestions = ref([])
const isLoading = ref(false)
const errorMessage = ref('')
const expandedSubjects = ref({})

// Search function
const searchSubjects = async () => {
  if (!searchQuery.value.trim()) {
    errorMessage.value = 'Please enter a subject name'
    searchResults.value = []
    return
  }

  isLoading.value = true
  errorMessage.value = ''

  try {
    const response = await fetch(`/api/subject?subject_name=${encodeURIComponent(searchQuery.value.trim())}`)
    if (!response.ok) throw new Error('Search failed, please try again later')

    const data = await response.json()
    if (data.error) throw new Error(data.error)

    searchResults.value = data.results || []
    if (searchResults.value.length === 0) {
      errorMessage.value = data.message || `No subjects with colleges found matching "${searchQuery.value}"`
    }

    expandedSubjects.value = {}
    searchResults.value.forEach(subject => {
      expandedSubjects.value[subject.subject_id] = false
    })

  } catch (err) {
    errorMessage.value = err.message
    searchResults.value = []
    expandedSubjects.value = {}
  } finally {
    isLoading.value = false
  }
}

const toggleSubject = (subjectId) => {
  expandedSubjects.value[subjectId] = !expandedSubjects.value[subjectId]
}

const getLocationLink = (location) => {
  return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(location)}`
}

const selectSuggestion = (subject) => {
  searchQuery.value = subject
  searchSubjects()
}

const loadSubjectSuggestions = async () => {
  try {
    const response = await fetch('/api/all_subjects')
    const data = await response.json()
    subjectSuggestions.value = data.subjects || []
  } catch (err) {
    console.error('Failed to load subject suggestions', err)
  }
}

onMounted(() => {
  loadSubjectSuggestions()
})
</script>

<style scoped>
.school-search-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40px 16px;
}

.subject-suggestions button {
  border-radius: 6px;
  padding: 6px 14px;
  font-size: 0.95rem;
  transition: background-color 0.2s;
}

.subject-suggestions button:hover {
  background-color: #e9ecef;
}

.search-box {
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  border: 1px solid #e0e0e0;
  padding: 12px 20px;
  max-width: 900px; 
  width: 100%;
  margin-bottom: 24px;
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

.search-results {
  width: 100%;
  max-width: 900px;
  padding: 0 16px;
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
