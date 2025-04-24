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
                            <router-link class="nav-link" to="/subject">Subject</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link active" to="/secondary-college">College</router-link>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
         <!-- Search section -->
        <div class="school-search-container">
            <!-- Search box -->
            <!-- Search input and button -->
            <div class="search-box card shadow-sm mb-4">
                <div class="card-body">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-lg"
                            placeholder="Enter Subject name" v-model="searchQuery"
                            @keyup.enter="searchSubjects">
                        <button class="btn btn-primary btn-lg" @click="searchSubjects" :disabled="isLoading">
                            <span v-if="!isLoading">Search</span>
                            <span v-else>
                                <span class="spinner-border spinner-border-sm me-1"></span>
                                Searching...
                            </span>
                        </button>
                    </div>
                    <!-- Show Error message -->
                    <div v-if="errorMessage" class="alert alert-warning mt-3 mb-0">
                        {{ errorMessage }}
                    </div>
                </div>
            </div>

             <!-- Display results -->
            <div v-if="searchResults.length > 0" class="search-results">
                <div class="result-count mb-3">
                    Found <span class="badge bg-primary">{{ searchResults.length }}</span> matching subjects with colleges
                </div>

                <!-- Subject list -->
                <!-- List of subjects and related colleges -->
                <div class="school-list">
                    <div v-for="subject in searchResults" :key="subject.subject_id" class="school-card card mb-4">
                        <div class="card-header bg-light">
                            <h4 class="mb-0">
                                {{ subject.subject_name }}
                            </h4>
                        </div>
                        <div class="card-body">
                            <!-- College list -->
                            <h5 class="mb-3">Offered By Colleges ({{ subject.secondaryColleges.length }})</h5>
                            <div class="subjects-container">
                                <div v-for="college in subject.secondaryColleges" :key="college.college_id"
                                    class="major-item card mb-2">
                                    <div class="card-body py-2">
                                        <div class="d-flex justify-content-between align-items-center" style="width:100%">
                                            <div class="d-flex justify-content-between align-items-center" style="width:100%">
                                                <h6 class="mb-1">{{ college.college_name }}</h6>
                                                <a :href="getLocationLink(college.college_name)"  target="_blank" class="float-end text-muted ms-2">Location</a>
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
    </div>
</template>

<script setup>
import { ref } from 'vue'
// User's input value for subject search
const searchQuery = ref('')
// Array to store the search results from API
const searchResults = ref([])
// Boolean to indicate loading status
const isLoading = ref(false)
// String for any error messages
const errorMessage = ref('')
// Search subjects function
// Handles the subject search process.
// Validates input, calls API, handles loading/error state, and updates results.
const searchSubjects = async () => {
    // Check if input is empty or only whitespace
    if (!searchQuery.value.trim()) {
        errorMessage.value = 'Please enter a subject name'
        searchResults.value = []
        return
    }
    // Start loading, clear previous error
    isLoading.value = true
    errorMessage.value = ''

    try {
        // Fetch search results from API
        const response = await fetch(`/api/subject?subject_name=${encodeURIComponent(searchQuery.value.trim())}`)
        // Handle network or response error
        if (!response.ok) {
            throw new Error('Search failed, please try again later')
        }
        // Parse response JSON
        const data = await response.json()
        // If backend returns an error field, show it
        if (data.error) {
            throw new Error(data.error)
        }
        // Assign results or empty array
        searchResults.value = data.results || []
        // If no results, show a message
        if (searchResults.value.length === 0) {
            errorMessage.value = data.message || `No subjects with colleges found matching "${searchQuery.value}"`
        }
    } catch (err) {
        // Handle and show any error that occurred
        errorMessage.value = err.message
        searchResults.value = []
    } finally {
        // Always stop loading animation
        isLoading.value = false
    }
}
// Generate a Google Maps search link for a given location string.
// location - Name of the college or location
const getLocationLink = (location) => {
    return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(location)}`
}
</script>

<style scoped>
.school-search-container {
    max-width: 900px;
    margin: 0 auto;
    padding: 20px;
}

.search-box {
    background-color: #f8f9fa;
    border-radius: 10px;
}

.school-card {
    transition: all 0.2s ease;
    border: 1px solid rgba(0, 0, 0, 0.125);
}

.school-card:hover {
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transform: translateY(-2px);
}

.major-item {
    transition: all 0.2s ease;
    border-left: 3px solid var(--bs-primary);
}

.major-item:hover {
    background-color: #f8f9fa;
}

.result-count {
    font-size: 1.1rem;
    color: #6c757d;
}

@media (max-width: 768px) {
    .search-box .input-group {
        flex-direction: column;
    }

    .search-box .form-control {
        margin-bottom: 10px;
    }

    .search-box .btn {
        width: 100%;
    }
}
</style>