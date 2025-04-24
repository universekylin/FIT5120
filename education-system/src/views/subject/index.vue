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
                            <router-link class="nav-link active" to="/subject">Subject</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/secondary-college">College</router-link>
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
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue'

// Reactive reference for search input value
const searchQuery = ref('')
// Stores list of search results
const searchResults = ref([])
// Indicates if search is currently loading
const isLoading = ref(false)
// Stores error message if search fails or yields no result
const errorMessage = ref('')


// Search secondary colleges function
// Function to search for secondary colleges based on the input query
const searchSchools = async () => {
    // If the input is empty, show an error and reset results
    if (!searchQuery.value.trim()) {
        errorMessage.value = 'Please enter a school name'
        searchResults.value = []
        return
    }

    // Set loading state and clear previous error
    isLoading.value = true
    errorMessage.value = ''

    try {
        // Make an API request with the entered school name
        const response = await fetch(`/api/secondary_colleges?college_name=${encodeURIComponent(searchQuery.value.trim())}`)
        // If response is not successful, throw an error
        if (!response.ok) {
            throw new Error('Search failed, please try again later')
        }
        const data = await response.json()
        // If server returns an error message, handle it
        if (data.error) {
            throw new Error(data.error)
        }
        // Set the search results; if none, show a message
        searchResults.value = data.data || []
        if (searchResults.value.length === 0) {
            errorMessage.value = `No schools found containing "${searchQuery.value}"`
        }
    } catch (err) {
        // Catch and display any errors during the request
        errorMessage.value = err.message
        searchResults.value = []
    } finally {
        // Always reset loading state after request finishes
        isLoading.value = false
    }
}
// Returns a Google Maps search URL for a given location name
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