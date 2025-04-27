<template>
  <div class="education-homepage">
    <!--header-->
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
              <router-link class="nav-link" to="/">Main</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link active" to="/test">Test</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/career">Career</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/career-stories">Career Stories</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/subject">Subject</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/secondary-college">College</router-link>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <div class="career-quiz-container container">
      <h1 class="quiz-title">Career Interest Questionnaire</h1>

      <form @submit.prevent="submitQuiz">
        <!-- question 1 -->
        <div class="question-card">
          <h3>
            Q1. Which school subjects do you actually enjoy the most?
            <small>(Pick up to 3)</small>
          </h3>
          <div class="options-grid">
            <div v-for="(option, index) in questions[0].options" :key="index" class="option-item">
              <input type="checkbox" :id="'q1-option' + index" v-model="answers[0].selected" :value="option.value"
                @change="limitSelections(0, 3)" />
              <label :for="'q1-option' + index">
                {{ option.text
                }}<!--  <span class="career-tag">{{ option.tags.join(', ') }}</span> -->
              </label>
            </div>
          </div>
        </div>

        <!-- question 2-9 -->
        <div v-for="(question, qIndex) in questions.slice(1)" :key="qIndex + 1" class="question-card">
          <h3>Q{{ qIndex + 2 }}. {{ question.text }}</h3>
          <div class="options-grid">
            <div v-for="(option, oIndex) in question.options" :key="oIndex" class="option-item">
              <input type="checkbox" :id="'q' + (qIndex + 2) + '-option' + oIndex"
                v-model="answers[qIndex + 1].selected" :value="option.value" />
              <label :for="'q' + (qIndex + 2) + '-option' + oIndex">
                {{ option.text
                }}<!--  <span class="career-tag">{{ option.tags.join(', ') }}</span> -->
              </label>
            </div>
          </div>
        </div>

        <button type="submit" class="submit-btn">Submit Questionnaire</button>
      </form>

      <!-- modal -->
      <div v-if="showResults" class="modal fade show" tabindex="-1"
        style="display: block; background: rgba(0, 0, 0, 0.5)">
        <div class="modal-dialog modal-lg modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header bg-primary text-white">
              <h5 class="modal-title">Your Career Clusters</h5>
              <button type="button" class="btn-close btn-close-white" @click="showResults = false"></button>
            </div>
            <div class="modal-body">
              <div v-if="topClusters.length > 0" class="top-recommendations">
                <h4 class="text-center mb-4">
                  <i class="bi bi-stars me-2"></i>
                  Your Top Career Matches
                </h4>

                <div class="row g-4">
                  <div v-for="(cluster, index) in topClusters" :key="index" class="col-md-12">
                    <div class="card h-100 border-primary shadow-sm">
                      <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">{{ cluster.name }}</h5>
                      </div>
                      <div class="card-body">
                        <div class="progress mb-3" style="height: 20px">
                          <div class="progress-bar" :class="getProgressBarClass(index)" role="progressbar"
                            :style="{ width: cluster.score + '%' }">
                            {{ cluster.score + "%" }}
                          </div>
                        </div>
                        <h6 class="text-primary">Recommended Careers:</h6>
                        <div class="d-flex flex-wrap gap-2 mb-3">
                          <span v-for="(job, jIndex) in cluster.jobs" :key="jIndex" class="badge bg-light text-dark">
                            {{ job }}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" @click="showResults = false">
                Close
              </button>
              <button type="button" class="btn btn-primary" @click="restartQuiz">
                Re-Test
              </button>
              <button type="button" class="btn btn-success" @click="toCareerPage">
                Career
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="alert alert-warning" v-show="error_tips_show" id="error_tips" role="alert">
      Please complete the questionnaire before submitting!
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";
import { questions, careerClustersData } from "@/utils/index";
import { useRouter } from "vue-router";
const router = useRouter();
// The error message field.
const error_tips_show = ref(false);
// Initialize the answer array.
const answers = ref(
  questions.map((question) => ({
    selected: [],
  }))
);
const showResults = ref(false);
const careerClusters = ref([]);

// Initialize the answer.
const initAnswers = () => {
  answers.value = questions.map(() => ({
    selected: [],
  }));
};

// Limit the number of selections.
const limitSelections = (qIndex, max) => {
  if (answers.value[qIndex].selected.length > max) {
    answers.value[qIndex].selected = answers.value[qIndex].selected.slice(
      0,
      max
    );
  }
};

// Calculate the highest score.
const topScore = computed(() => {
  return careerClusters.value.length > 0
    ? Math.max(...careerClusters.value.map((c) => c.score))
    : 0;
});

// Get the highest score cluster.
const topClusters = computed(() => {
  return careerClusters.value.filter((c) => c.score === topScore.value);
});

// Get the progress bar color.
const getProgressBarClass = (index) => {
  const colors = [
    "bg-primary",
    "bg-success",
    "bg-info",
    "bg-warning",
    "bg-danger",
    "bg-secondary",
  ];
  return colors[index % colors.length];
};

// Calculate the result.
const calculateResults = () => {
  // Create a score mapping.
  const scoreMap = {};
  careerClustersData.forEach((cluster) => {
    cluster.tags.forEach((tag) => {
      scoreMap[tag] = 0;
    });
  });

  // Calculate the score for each label.
  answers.value.forEach((answer, qIndex) => {
    answer.selected.forEach((selectedValue) => {
      const question = questions[qIndex];
      const selectedOption = question.options.find(
        (opt) => opt.value === selectedValue
      );
      if (selectedOption) {
        selectedOption.tags.forEach((tag) => {
          if (scoreMap[tag] !== undefined) {
            scoreMap[tag] += 1;
          }
        });
      }
    });
  });

  // Convert to percentage.
  const totalPossible = answers.value.reduce(
    (sum, answer) => sum + answer.selected.length,
    0
  );

  // Prepare the results.
  careerClusters.value = careerClustersData
    .map((cluster) => {
      const clusterScore = cluster.tags.reduce(
        (sum, tag) => sum + (scoreMap[tag] || 0),
        0
      );
      const percentage =
        totalPossible > 0
          ? Math.round((clusterScore / totalPossible) * 100)
          : 0;

      return {
        name: cluster.name,
        score: percentage,
        jobs: [...cluster.jobs],
      };
    })
    .sort((a, b) => b.score - a.score);
};

// Submit the survey.
const submitQuiz = () => {
  if (
    answers.value.filter((item) => item.selected && item.selected.length)
      .length != answers.value.length
  ) {
    if (!error_tips_show.value) {
      error_tips_show.value = true;
      timeout = setTimeout(() => {
        error_tips_show.value = false;
      }, 3000);
    }
    return;
  }
  calculateResults();
  showResults.value = true;
};
const toCareerPage = () => {
  console.log(topClusters);
  if (topClusters.value.length) {
    let careerNames = "";
    topClusters.value.forEach((cluster) => {
      careerNames += cluster.jobs.join(",");
    });
    router.push({ name: "career", query: { careers: careerNames } });
  }
};
// Retest.
const restartQuiz = () => {
  initAnswers();
  showResults.value = false;
  careerClusters.value = [];
};
</script>

<style scoped>
.career-quiz-container {
  user-select: none;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
}

.quiz-title {
  color: #2c3e50;
  text-align: center;
  margin-bottom: 20px;
}

.question-card {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 25px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.question-card h3 {
  color: #2c3e50;
  margin-bottom: 15px;
}

.question-card h3 small {
  font-size: 0.8em;
  color: #6c757d;
  font-weight: normal;
}

.options-grid {
  display: grid;
  gap: 12px;
}

.option-item {
  display: flex;
  align-items: flex-start;
  padding: 12px;
  background: white;
  border-radius: 5px;
  border: 1px solid #dee2e6;
  transition: all 0.2s;
}

.option-item:hover {
  border-color: #adb5bd;
  background: #f8f9fa;
}

.option-item input[type="checkbox"] {
  margin-right: 10px;
  margin-top: 3px;
}

.option-item label {
  flex-grow: 1;
  cursor: pointer;
  line-height: 1.4;
}

.career-tag {
  display: block;
  font-size: 0.75em;
  color: #6c757d;
  margin-top: 3px;
  font-style: italic;
}

.submit-btn {
  display: block;
  width: 100%;
  padding: 12px;
  background: #0d6efd;
  color: white;
  border: none;
  border-radius: 5px;
  font-size: 16px;
  cursor: pointer;
  transition: background 0.3s;
  margin-top: 20px;
}

.submit-btn:hover {
  background: #0b5ed7;
}

.modal {
  z-index: 1050;
}

.modal-content {
  border: none;
  border-radius: 0.5rem;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}

.card {
  transition: transform 0.2s;
  border-radius: 0.5rem;
  overflow: hidden;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-header {
  font-weight: 600;
}

.progress {
  height: 0.5rem;
}

.badge {
  font-weight: 500;
  padding: 0.35em 0.65em;
}

#error_tips {
  position: fixed;
  left: 50%;
  top: 30px;
  transform: translateX(-50%);
  z-index: 99999;
}

@media (max-width: 768px) {
  .options-grid {
    grid-template-columns: 1fr;
  }

  .modal-dialog {
    margin: 1rem;
  }
}
</style>
