<template>
  <div class="score-card">
    <h3>Exploration Progress</h3>
    <div class="score-item">
      <span class="label">Universities:</span>
      <span class="value">{{ visitedUniversities }}/{{ totalUniversities }}</span>
      <div class="progress-bar">
        <div 
          class="progress" 
          :style="{ width: `${(visitedUniversities / totalUniversities) * 100}%` }"
        ></div>
      </div>
    </div>
    <div class="score-item">
      <span class="label">Courses:</span>
      <span class="value">{{ discoveredCourses }}/{{ totalCourses }}</span>
      <div class="progress-bar">
        <div 
          class="progress" 
          :style="{ width: `${(discoveredCourses / totalCourses) * 100}%` }"
        ></div>
      </div>
    </div>
    <div class="score-item">
      <span class="label">Videos:</span>
      <span class="value">{{ watchedVideos }}/{{ totalUniversities }}</span>
      <div class="progress-bar">
        <div 
          class="progress" 
          :style="{ width: `${(watchedVideos / totalUniversities) * 100}%` }"
        ></div>
      </div>
    </div>
    <div v-if="notifications > 0" class="notification">{{ notifications }}</div>
  </div>
</template>

<script>
export default {
  name: 'ScoreCard',
  props: {
    visitedUniversities: {
      type: Number,
      required: true
    },
    totalUniversities: {
      type: Number,
      required: true
    },
    discoveredCourses: {
      type: Number,
      required: true
    },
    totalCourses: {
      type: Number,
      required: true
    },
    watchedVideos: {
      type: Number,
      required: true
    },
    notifications: {
      type: Number,
      default: 0
    }
  }
};
</script>

<style scoped>
.score-card {
  position: relative;
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 10px;
  padding: 15px;
  width: 100%;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  border: 2px solid #ccc;
}

.score-card h3 {
  margin-top: 0;
  margin-bottom: 15px;
  text-align: center;
  color: #333;
  font-size: 18px;
}

.score-item {
  margin: 12px 0;
  font-size: 14px;
  color: #333;
}

.label {
  display: inline-block;
  width: 50px;
  font-weight: bold;
}

.value {
  float: right;
}

.progress-bar {
  height: 8px;
  background-color: #e0e0e0;
  border-radius: 4px;
  margin-top: 5px;
  overflow: hidden;
}

.progress {
  height: 100%;
  background-color: #4CAF50;
  border-radius: 4px;
  transition: width 0.3s ease;
}

.notification {
  position: absolute;
  top: -10px;
  right: -10px;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background-color: #ff5252;
  color: white;
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}
</style>