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
          v-for="(cluster, index) in sortedClusterScores" 
          :key="cluster.name" 
          class="cluster-card"
          v-if="cluster.score > 0"
        >
          <h3>{{ cluster.name }}</h3>
          <div class="score-bar">
            <div class="score-fill" :style="{ width: (cluster.score / maxPossibleScore * 100) + '%' }"></div>
          </div>
          <div class="jobs">
            <h4>Career Examples:</h4>
            <ul>
              <li v-for="(job, jobIndex) in getJobsForCluster(cluster.name)" :key="jobIndex">{{ job }}</li>
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
          text: 'Q1. Which school subjects do you actually enjoy the most?',
          subtitle: 'Pick up to 3',
          options: [
            { text: 'Coding or working with computers', clusters: ['IT & Data'] },
            { text: 'Maths (any type)', clusters: ['Engineering & Science', 'Math & Theoretical Sciences'] },
            { text: 'Psychology or Health classes', clusters: ['Health & Human Services'] },
            { text: 'Science stuff like bio or chemistry', clusters: ['Engineering & Science', 'Health & Human Services', 'Agriculture, Environment & Natural Sciences'] },
            { text: 'Art, media or anything creative', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Business, economics or money-related', clusters: ['Business & Management'] },
            { text: 'English, history or legal studies', clusters: ['Education & Social Sciences', 'Law & Public Services'] },
            { text: 'Environmental science or agriculture', clusters: ['Agriculture, Environment & Natural Sciences'] },
            { text: 'Food studies, textiles or woodwork', clusters: ['Vocational & Lifestyle Services'] }
          ],
          maxSelections: 3
        },
        {
          text: 'Q2. What kinds of activities do you enjoy most in or outside school?',
          subtitle: 'Select all that apply',
          options: [
            { text: 'Helping people with their problems', clusters: ['Health & Human Services'] },
            { text: 'Making stuff—drawing, editing, creating', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Figuring things out or solving tricky puzzles', clusters: ['IT & Data', 'Engineering & Science', 'Math & Theoretical Sciences'] },
            { text: 'Running group projects or planning stuff', clusters: ['Business & Management'] },
            { text: 'Coding or building cool tech things', clusters: ['IT & Data'] },
            { text: 'Performing, writing or telling stories', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Getting hands-on with food, plants or tools', clusters: ['Vocational & Lifestyle Services', 'Agriculture, Environment & Natural Sciences'] },
            { text: 'Standing up for what\'s right', clusters: ['Law & Public Services'] }
          ],
          maxSelections: 3
        },
        {
          text: 'Q3. What type of work vibe do you think you\'d like in the future?',
          options: [
            { text: 'Fast and team-based', clusters: ['Business & Management'] },
            { text: 'Calm and about helping people', clusters: ['Health & Human Services'] },
            { text: 'Quiet and independent', clusters: ['IT & Data', 'Math & Theoretical Sciences'] },
            { text: 'Creative and chill', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Super organised and routine', clusters: ['Education & Social Sciences', 'Business & Management'] },
            { text: 'Practical and hands-on', clusters: ['Engineering & Science', 'Vocational & Lifestyle Services'] },
            { text: 'Outdoorsy or nature-connected', clusters: ['Agriculture, Environment & Natural Sciences'] }
          ],
          maxSelections: 2
        },
        {
          text: 'Q4. What are you naturally good at or feel confident doing?',
          options: [
            { text: 'Chatting with people and understanding them', clusters: ['Health & Human Services', 'Education & Social Sciences'] },
            { text: 'Working with numbers or spotting patterns', clusters: ['IT & Data', 'Math & Theoretical Sciences'] },
            { text: 'Leading a group or making decisions', clusters: ['Business & Management'] },
            { text: 'Coming up with cool or clever ideas', clusters: ['Creative Arts, Media & Communication', 'Engineering & Science'] },
            { text: 'Staying on top of tasks and being organised', clusters: ['Business & Management'] },
            { text: 'Learning new tech or digital stuff fast', clusters: ['IT & Data'] },
            { text: 'Explaining ideas or writing stuff clearly', clusters: ['Creative Arts, Media & Communication', 'Law & Public Services'] }
          ],
          maxSelections: 2
        },
        {
          text: 'Q5. When you\'re working in a group, what role do you usually take?',
          options: [
            { text: 'The leader who keeps things moving', clusters: ['Business & Management'] },
            { text: 'The creative who makes it look awesome', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'The helper who keeps the team happy', clusters: ['Health & Human Services'] },
            { text: 'The one who digs into the research', clusters: ['IT & Data', 'Education & Social Sciences'] },
            { text: 'The planner with the perfect timeline', clusters: ['Business & Management'] },
            { text: 'The quiet one who just gets it done', clusters: ['Engineering & Science', 'IT & Data', 'Math & Theoretical Sciences'] }
          ]
        },
        {
          text: 'Q6. What sounds most important to you in your future job?',
          options: [
            { text: 'Helping people and doing good', clusters: ['Health & Human Services'] },
            { text: 'Being creative and expressing yourself', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Having freedom to work your own way', clusters: ['IT & Data', 'Math & Theoretical Sciences'] },
            { text: 'Earning well and moving up quickly', clusters: ['Business & Management'] },
            { text: 'Tackling tricky problems or challenges', clusters: ['Engineering & Science', 'Math & Theoretical Sciences', 'IT & Data'] },
            { text: 'Clear structure and routine', clusters: ['Education & Social Sciences', 'Business & Management'] },
            { text: 'Making a difference for the planet or community', clusters: ['Law & Public Services', 'Agriculture, Environment & Natural Sciences'] }
          ],
          maxSelections: 2
        },
        {
          text: 'Q7. What gives you that "yes, I nailed it" feeling?',
          options: [
            { text: 'Helping someone feel better or less stressed', clusters: ['Health & Human Services'] },
            { text: 'Solving a tough challenge or problem', clusters: ['Engineering & Science', 'IT & Data', 'Math & Theoretical Sciences'] },
            { text: 'Making something original and cool', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Finishing everything on time and to plan', clusters: ['Business & Management'] },
            { text: 'Explaining things well to others', clusters: ['Education & Social Sciences'] },
            { text: 'Quietly fixing things behind the scenes', clusters: ['IT & Data', 'Vocational & Lifestyle Services'] },
            { text: 'Speaking up or making your opinion heard', clusters: ['Creative Arts, Media & Communication', 'Law & Public Services'] }
          ],
          maxSelections: 2
        },
        {
          text: 'Q8. What kind of goals or values matter most to you in a job?',
          options: [
            { text: 'Being outside or doing something for the environment', clusters: ['Agriculture, Environment & Natural Sciences'] },
            { text: 'Standing up for justice and fairness', clusters: ['Law & Public Services'] },
            { text: 'Sharing stories or helping people understand things', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Doing hands-on or practical work you can see', clusters: ['Vocational & Lifestyle Services'] },
            { text: 'Solving tricky questions or logical stuff', clusters: ['Math & Theoretical Sciences'] }
          ],
          maxSelections: 2
        },
        {
          text: 'Q9. Which of these just sounds like a good time to you?',
          options: [
            { text: 'Writing a blog, giving a speech, or making a podcast', clusters: ['Creative Arts, Media & Communication'] },
            { text: 'Taking care of animals, plants or the planet', clusters: ['Agriculture, Environment & Natural Sciences'] },
            { text: 'Cooking something great or making a DIY project', clusters: ['Vocational & Lifestyle Services'] },
            { text: 'Debating a real-world issue or defending your side', clusters: ['Law & Public Services'] },
            { text: 'Proving a maths problem or finding a logic shortcut', clusters: ['Math & Theoretical Sciences'] }
          ],
          maxSelections: 2
        }
      ],
      clusterJobs: {
        'IT & Data': ['Data Analyst', 'Data Scientist', 'Software Developer', 'Systems Analyst', 'Web Developer'],
        'Health & Human Services': ['Nurse', 'Mental Health Counselor', 'Nutritionist', 'Healthcare Analyst', 'Physician Assistant'],
        'Creative Arts, Media & Communication': ['Animator', 'Content Creator', 'Digital Marketing Analyst', 'Journalist', 'Art Director'],
        'Engineering & Science': ['Engineer', 'Project Engineer', 'Environmental Scientist', 'Climate Analyst', 'QA/QC Engineer'],
        'Business & Management': ['Accountant', 'Business Analyst', 'Brand Manager', 'Digital Marketing Analyst', 'Economist'],
        'Education & Social Sciences': ['School Teacher', 'Social Worker', 'Research Officer', 'Policy Analyst'],
        'Agriculture, Environment & Natural Sciences': ['Agricultural Technician', 'Conservation Officer', 'Ecologist', 'Biologist', 'Climate Analyst'],
        'Law & Public Services': ['Lawyer', 'Paralegal', 'Compliance Officer', 'Legal Advisor', 'Policy Analyst'],
        'Math & Theoretical Sciences': ['Actuary', 'Mathematician', 'Statistician', 'Data Scientist', 'Quantitative Analyst'],
        'Vocational & Lifestyle Services': ['Chef', 'Interior Designer', 'Fashion Designer', 'Tradesperson', 'Personal Trainer']
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
        'Creative Arts, Media & Communication': 0,
        'Engineering & Science': 0,
        'Business & Management': 0,
        'Education & Social Sciences': 0,
        'Agriculture, Environment & Natural Sciences': 0,
        'Law & Public Services': 0,
        'Math & Theoretical Sciences': 0,
        'Vocational & Lifestyle Services': 0
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
    sortedClusterScores() {
      // Convert scores object to array of objects with name and score
      const scoresArray = Object.keys(this.clusterScores).map(cluster => ({
        name: cluster,
        score: this.clusterScores[cluster]
      }));
      
      // Sort by score in descending order
      return scoresArray.sort((a, b) => b.score - a.score);
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