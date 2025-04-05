<template>
    <div class="career-quiz">
      <h1>Career Pathway Quiz</h1>
      <p class="intro">This quiz will help you discover which career clusters align with your interests and strengths.</p>
  
      <div v-if="!quizCompleted">
        <div class="progress-bar">
          <div class="progress" :style="{ width: progress + '%' }"></div>
          <div class="progress-text">Question {{ currentQuestionIndex + 1 }} of {{ questions.length }}</div>
        </div>
  
        <div class="question-container">
          <h2>{{ questions[currentQuestionIndex].text }}</h2>
          <p v-if="questions[currentQuestionIndex].subtitle" class="subtitle">
            {{ questions[currentQuestionIndex].subtitle }}
          </p>
  
          <div class="options">
            <div 
              v-for="(option, index) in questions[currentQuestionIndex].options" 
              :key="index" 
              class="option"
              :class="{ selected: selectedOptions[currentQuestionIndex] && selectedOptions[currentQuestionIndex].includes(index) }"
              @click="toggleOption(index)"
            >
              <div class="checkbox">
                <div class="checkbox-inner" v-if="selectedOptions[currentQuestionIndex] && selectedOptions[currentQuestionIndex].includes(index)"></div>
              </div>
              <span>{{ option.text }}</span>
            </div>
          </div>
  
          <div class="navigation">
            <button 
              v-if="currentQuestionIndex > 0" 
              @click="prevQuestion" 
              class="nav-button prev"
            >
              Previous
            </button>
            <button 
              @click="nextQuestion" 
              class="nav-button next"
              :disabled="!canProceed"
            >
              {{ currentQuestionIndex === questions.length - 1 ? 'See Results' : 'Next' }}
            </button>
          </div>
        </div>
      </div>
  
      <div v-else class="results">
        <h2>Your Career Cluster Results</h2>
        <p>Based on your responses, here are the career clusters that match your interests and strengths:</p>
        
        <div class="clusters">
          <div 
            v-for="(score, cluster) in clusterScores" 
            :key="cluster" 
            class="cluster-card"
            v-if="score > 0"
          >
            <h3>{{ cluster }}</h3>
            <div class="score-bar">
              <div class="score-fill" :style="{ width: (score / maxPossibleScore * 100) + '%' }"></div>
            </div>
            <div class="jobs">
              <h4>Career Examples:</h4>
              <ul>
                <li v-for="(job, index) in getJobsForCluster(cluster)" :key="index">{{ job }}</li>
              </ul>
            </div>
          </div>
        </div>
        
        <button @click="resetQuiz" class="reset-button">Take the Quiz Again</button>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'CareerQuiz',
    data() {
      return {
        currentQuestionIndex: 0,
        selectedOptions: {},
        quizCompleted: false,
        questions: [
          {
            text: 'Q1. Which of the following school subjects do you enjoy the most?',
            subtitle: 'Select up to 3',
            options: [
              { text: 'Applied Computing / Data Analytics', clusters: ['IT & Data'] },
              { text: 'Maths (General, Methods, Specialist)', clusters: ['IT & Data', 'Engineering & Science'] },
              { text: 'Psychology / Health & Human Development', clusters: ['Health & Human Services'] },
              { text: 'Biology / Chemistry / Physics', clusters: ['Health & Human Services', 'Engineering & Science'] },
              { text: 'Visual Communication / Studio Arts / Media', clusters: ['Creative Arts & Media'] },
              { text: 'Business / Economics / Accounting', clusters: ['Business & Management'] },
              { text: 'English / Literature / History / Legal Studies', clusters: ['Education & Social Sciences'] }
            ],
            maxSelections: 3
          },
          {
            text: 'Q2. What types of activities do you enjoy or feel excited about?',
            options: [
              { text: 'Helping people feel better or solve problems', clusters: ['Health & Human Services'] },
              { text: 'Designing, drawing, or creating things', clusters: ['Creative Arts & Media'] },
              { text: 'Solving complex puzzles or logical problems', clusters: ['IT & Data', 'Engineering & Science'] },
              { text: 'Organizing tasks or managing projects', clusters: ['Business & Management'] },
              { text: 'Coding, programming or working with tech', clusters: ['IT & Data'] },
              { text: 'Performing, storytelling or writing', clusters: ['Creative Arts & Media'] }
            ]
          },
          {
            text: 'Q3. Which work environments do you feel most drawn to?',
            options: [
              { text: 'Fast-paced and team-driven', clusters: ['Business & Management'] },
              { text: 'Calm and people-focused', clusters: ['Health & Human Services'] },
              { text: 'Quiet and independent', clusters: ['IT & Data'] },
              { text: 'Creative and flexible', clusters: ['Creative Arts & Media'] },
              { text: 'Structured and process-based', clusters: ['Education & Social Sciences', 'Business & Management'] },
              { text: 'Technical and hands-on', clusters: ['Engineering & Science'] }
            ]
          },
          {
            text: 'Q4. What are you naturally good at or confident in?',
            options: [
              { text: 'Talking with people and understanding their needs', clusters: ['Health & Human Services', 'Education & Social Sciences'] },
              { text: 'Working with numbers, data or logic', clusters: ['IT & Data'] },
              { text: 'Leading groups and making decisions', clusters: ['Business & Management'] },
              { text: 'Solving problems creatively', clusters: ['Creative Arts & Media', 'Engineering & Science'] },
              { text: 'Staying organised and on schedule', clusters: ['Business & Management'] },
              { text: 'Learning new tech or digital tools quickly', clusters: ['IT & Data'] }
            ]
          },
          {
            text: 'Q5. In a group project, what role do you usually take?',
            options: [
              { text: 'The leader – organising and assigning roles', clusters: ['Business & Management'] },
              { text: 'The creative – designing visuals or making it look good', clusters: ['Creative Arts & Media'] },
              { text: 'The helper – checking in with others and resolving conflict', clusters: ['Health & Human Services'] },
              { text: 'The researcher – finding and analysing information', clusters: ['IT & Data', 'Education & Social Sciences'] },
              { text: 'The planner – managing timelines and task flow', clusters: ['Business & Management'] },
              { text: 'The quiet worker – focusing on your assigned part', clusters: ['IT & Data', 'Engineering & Science'] }
            ]
          },
          {
            text: 'Q6. What matters most to you in a future career?',
            options: [
              { text: 'Helping others and making a difference', clusters: ['Health & Human Services'] },
              { text: 'Expressing creativity and ideas', clusters: ['Creative Arts & Media'] },
              { text: 'Working independently with flexibility', clusters: ['IT & Data'] },
              { text: 'Earning good income and progressing quickly', clusters: ['Business & Management'] },
              { text: 'Solving difficult problems or learning new things', clusters: ['Engineering & Science', 'IT & Data'] },
              { text: 'Having a clear structure and daily routine', clusters: ['Education & Social Sciences', 'Business & Management'] }
            ]
          },
          {
            text: 'Q7. What gives you the biggest sense of satisfaction?',
            options: [
              { text: 'Seeing someone smile after you helped them', clusters: ['Health & Human Services'] },
              { text: 'Finishing a complex task or challenge', clusters: ['IT & Data', 'Engineering & Science'] },
              { text: 'Creating something original', clusters: ['Creative Arts & Media'] },
              { text: 'Meeting a deadline perfectly', clusters: ['Business & Management'] },
              { text: 'Teaching, explaining, or supporting someone', clusters: ['Education & Social Sciences'] },
              { text: 'Working behind the scenes to keep things running', clusters: ['IT & Data'] }
            ]
          }
        ],
        clusterJobs: {
          'IT & Data': ['Software Developer', 'Data Analyst'],
          'Health & Human Services': ['Registered Nurse', 'Social Worker'],
          'Creative Arts & Media': ['Graphic Designer', 'Interior Designer', 'Fashion Designer'],
          'Engineering & Science': ['Mechanical Engineer', 'Architect'],
          'Business & Management': ['Human Resources Officer', 'Marketing Coordinator', 'Financial Analyst'],
          'Education & Social Sciences': ['Primary / Secondary School Teacher', 'Librarian']
        }
      };
    },
    computed: {
      progress() {
        return ((this.currentQuestionIndex + 1) / this.questions.length) * 100;
      },
      canProceed() {
        // Check if at least one option is selected for the current question
        return this.selectedOptions[this.currentQuestionIndex] && 
               this.selectedOptions[this.currentQuestionIndex].length > 0;
      },
      clusterScores() {
        const scores = {
          'IT & Data': 0,
          'Health & Human Services': 0,
          'Creative Arts & Media': 0,
          'Engineering & Science': 0,
          'Business & Management': 0,
          'Education & Social Sciences': 0
        };
  
        // Calculate scores based on selected options
        Object.keys(this.selectedOptions).forEach(questionIndex => {
          const question = this.questions[questionIndex];
          this.selectedOptions[questionIndex].forEach(optionIndex => {
            const selectedClusters = question.options[optionIndex].clusters;
            selectedClusters.forEach(cluster => {
              scores[cluster] += 1;
            });
          });
        });
  
        return scores;
      },
      maxPossibleScore() {
        // Calculate the maximum possible score for any cluster
        let maxCount = 0;
        this.questions.forEach(question => {
          const maxSelectionsForQuestion = question.maxSelections || 1;
          maxCount += maxSelectionsForQuestion;
        });
        return maxCount;
      }
    },
    methods: {
      toggleOption(optionIndex) {
        // Initialize if not already
        if (!this.selectedOptions[this.currentQuestionIndex]) {
          this.selectedOptions[this.currentQuestionIndex] = [];
        }
  
        const currentSelections = this.selectedOptions[this.currentQuestionIndex];
        const currentQuestion = this.questions[this.currentQuestionIndex];
        const maxSelections = currentQuestion.maxSelections || 1;
  
        // If already selected, remove it
        const existingIndex = currentSelections.indexOf(optionIndex);
        if (existingIndex !== -1) {
          currentSelections.splice(existingIndex, 1);
        } 
        // Add new selection if under max limit
        else if (currentSelections.length < maxSelections) {
          currentSelections.push(optionIndex);
        }
        // If at max and we're trying to add a new one, replace the first one (or implement other logic)
        else if (maxSelections === 1) {
          // For single selection questions, replace the selection
          currentSelections.splice(0, 1, optionIndex);
        }
      },
      nextQuestion() {
        if (this.currentQuestionIndex < this.questions.length - 1) {
          this.currentQuestionIndex++;
        } else {
          this.quizCompleted = true;
        }
      },
      prevQuestion() {
        if (this.currentQuestionIndex > 0) {
          this.currentQuestionIndex--;
        }
      },
      resetQuiz() {
        this.currentQuestionIndex = 0;
        this.selectedOptions = {};
        this.quizCompleted = false;
      },
      getJobsForCluster(cluster) {
        return this.clusterJobs[cluster] || [];
      }
    }
  };
  </script>
  
  <style scoped>
  .career-quiz {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }
  
  h1 {
    color: #2c3e50;
    text-align: center;
    margin-bottom: 10px;
  }
  
  .intro {
    text-align: center;
    color: #666;
    margin-bottom: 30px;
  }
  
  .progress-bar {
    background-color: #eee;
    height: 8px;
    border-radius: 4px;
    margin-bottom: 30px;
    position: relative;
  }
  
  .progress {
    background-color: #42b983;
    height: 100%;
    border-radius: 4px;
    transition: width 0.3s ease;
  }
  
  .progress-text {
    text-align: center;
    font-size: 14px;
    color: #666;
    margin-top: 5px;
  }
  
  .question-container {
    background-color: #f9f9f9;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  }
  
  h2 {
    margin-top: 0;
    color: #2c3e50;
    font-size: 20px;
  }
  
  .subtitle {
    color: #666;
    font-style: italic;
    margin-bottom: 20px;
  }
  
  .options {
    margin-bottom: 25px;
  }
  
  .option {
    display: flex;
    align-items: center;
    padding: 12px;
    margin-bottom: 10px;
    background-color: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .option:hover {
    border-color: #42b983;
    transform: translateY(-1px);
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
  }
  
  .option.selected {
    border-color: #42b983;
    background-color: rgba(66, 185, 131, 0.05);
  }
  
  .checkbox {
    width: 20px;
    height: 20px;
    border: 2px solid #aaa;
    border-radius: 4px;
    margin-right: 12px;
    position: relative;
  }
  
  .checkbox-inner {
    position: absolute;
    width: 12px;
    height: 12px;
    background-color: #42b983;
    border-radius: 2px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  
  .navigation {
    display: flex;
    justify-content: space-between;
  }
  
  .nav-button {
    padding: 10px 20px;
    background-color: #42b983;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.2s;
  }
  
  .nav-button:hover {
    background-color: #3aa876;
  }
  
  .nav-button:disabled {
    background-color: #cccccc;
    cursor: not-allowed;
  }
  
  .prev {
    background-color: #95a5a6;
  }
  
  .prev:hover {
    background-color: #7f8c8d;
  }
  
  .results {
    background-color: #f9f9f9;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  }
  
  .clusters {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
    margin-top: 25px;
  }
  
  .cluster-card {
    background-color: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  }
  
  .cluster-card h3 {
    margin-top: 0;
    color: #2c3e50;
    border-bottom: 2px solid #42b983;
    padding-bottom: 8px;
  }
  
  .score-bar {
    height: 8px;
    background-color: #eee;
    border-radius: 4px;
    margin: 15px 0;
  }
  
  .score-fill {
    height: 100%;
    background-color: #42b983;
    border-radius: 4px;
  }
  
  .jobs h4 {
    margin-bottom: 8px;
    font-size: 16px;
    color: #666;
  }
  
  .jobs ul {
    margin: 0;
    padding-left: 20px;
  }
  
  .jobs li {
    margin-bottom: 5px;
  }
  
  .reset-button {
    display: block;
    margin: 30px auto 0;
    padding: 12px 25px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.2s;
  }
  
  .reset-button:hover {
    background-color: #2980b9;
  }
  </style>