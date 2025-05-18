<template>
  <div class="major">
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
            <li class="nav-item"><router-link class="nav-link" to="/">Home</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/test">Career Quiz</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/career-stories">Career Stories</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/subject">VCE Subject Check</router-link></li>
            <li class="nav-item"><router-link class="nav-link active" to="/secondary-college">Alternative Schools</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/chatbot">AI ChatBot</router-link></li>
            <li class="nav-item"><router-link class="nav-link" to="/three">Uni Virtual Explore</router-link></li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="school-search-container">
      <div class="search-box card shadow-sm mb-4">
        <div class="card-body">
          <div class="d-flex flex-column align-items-center">
            <div class="input-group w-100 search-bar-wrapper">
              <input type="text" class="form-control form-control-lg"
                     placeholder="Enter a VCE Subject to search for schools"
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

            <div v-if="groupedSubjects && Object.keys(groupedSubjects || {}).length > 0" class="subject-suggestions mt-4 w-100 subject-box">
              <div v-for="(group, letter) in groupedSubjects" :key="letter" class="mb-2">
                <details>
                  <summary class="fw-bold">{{ letter }} ({{ group.length }})</summary>
                  <div class="d-flex flex-wrap mt-2">
                    <button
                      v-for="subject in group"
                      :key="subject"
                      class="btn btn-outline-secondary btn-sm me-2 mb-2"
                      @click="selectSuggestion(subject)"
                    >
                      {{ subject }}
                    </button>
                  </div>
                </details>
              </div>
            </div>

            <div v-if="errorMessage" class="alert alert-warning mt-3 mb-0 w-100 search-bar-wrapper">
              {{ errorMessage }}
            </div>
          </div>
        </div>
      </div>

      <div v-if="searchResults.length > 0" class="search-results">
        <div class="result-count mb-3">
          Found <span class="badge bg-primary">{{ searchResults.length }}</span> matching subjects with colleges
        </div>

        <div class="school-list">
          <div v-for="subject in searchResults" :key="subject.subject_id" class="school-card card mb-4">
            <div class="card-header bg-light d-flex justify-content-between align-items-center">
              <h4 class="mb-0" style="cursor: pointer;" @click="toggleSubject(subject.subject_id)">
                {{ subject.subject_name }}
                 <span class="map-link" @click="showMapModal(subject)">View Map</span>
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
                    <div>
                      <router-link 
                        :to="`/college-detail/${college.college_id}`" 
                        class="me-3 text-decoration-none text-primary"
                      >
                        Learn More
                      </router-link>
                      <a 
                        :href="getLocationLink(college.college_name)" 
                        target="_blank" 
                        class="text-muted"
                      >
                        Location
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <MapModal 
      v-model:visible="showModal" 
      :college-ids="selectIds" 
      @close="onMapModalClose"
    />
</template>

<script setup>
import { ref, onMounted } from 'vue'
import MapModal from './modal/index.vue';
const searchQuery = ref('')
const searchResults = ref([])
const isLoading = ref(false)
const errorMessage = ref('')
const expandedSubjects = ref({})
const groupedSubjects = ref({})
const selectIds = ref();
const showModal = ref(false);
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
    groupedSubjects.value = data || {}
  } catch (err) {
    console.error('Failed to load subject suggestions', err)
    groupedSubjects.value = {}
  }
}
const showMapModal = (subject) => {
    selectIds.value = subject.secondaryColleges.map(item=>item.college_id).join(',')
    showModal.value = true;
  };
  const onMapModalClose = () => {
    selectIds.value = "";
  };
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

.search-bar-wrapper {
  max-width: 600px;
  width: 100%;
}

.subject-box {
  background-color: #f8f9fa;
  padding: 16px;
  border-radius: 8px;
  border: 1px solid #e0e0e0;
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
.map-link {
  color: #1890ff;
  cursor: pointer;
  text-decoration: underline;
  font-size: 14px;
}

.map-link:hover {
  color: #40a9ff;
}
</style>
