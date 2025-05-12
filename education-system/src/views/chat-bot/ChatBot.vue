<template>
  <!--header-->
  <!-- Only render the navbar on the chatbot page -->
  <nav v-if="$route.path === '/chatbot'" class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
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
            <router-link class="nav-link " to="/test">Test</router-link>
          </li>
          <!-- <li class="nav-item">
            <router-link class="nav-link" to="/career">Career</router-link>
          </li> -->
          <li class="nav-item">
            <router-link class="nav-link" to="/career-stories">Career Stories</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" to="/subject">High School</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" to="/secondary-college">Subject</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link active" to="/chatbot">Chat Bot</router-link>
          </li>
          <li class="nav-item">
              <router-link class="nav-link" to="/three">Our University</router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- New content for the chatbot page - MODIFIED: removed the !isOpen condition -->
  <div class="container my-5 chatbot-page-content" v-if="$route.path === '/chatbot'">
    <div class="row justify-content-center">
      <div class="col-md-10">
        <div class="card shadow-lg border-0">
          <div class="card-body p-4">
            <div class="text-center mb-4">
              <div class="robot-icon-large mb-3">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="80" height="80" fill="none" stroke="#396aae" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="3" y="11" width="18" height="10" rx="2" />
                  <rect x="8" y="24" width="8" height="3" rx="1" ry="1" />
                  <rect x="8" y="2" width="8" height="5" rx="1" ry="1" />
                  <path d="M12 7v4" />
                  <circle cx="8" cy="16" r="1" />
                  <circle cx="16" cy="16" r="1" />
                  <path d="M9 11v-1.5a3 3 0 0 1 6 0V11" />
                </svg>
              </div>
              <h2 class="fw-bold text-primary">Career Guidance Assistant</h2>
              <p class="lead text-muted">Your personalized AI helper for education and career planning</p>
            </div>

            <div class="row g-4 mb-4">
              <div class="col-md-6">
                <div class="feature-card h-100 p-4 rounded shadow-sm border">
                  <h4 class="fw-bold mb-3">How Can I Help You?</h4>
                  <ul class="list-unstyled mb-0">
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Find university courses by career path</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Search for secondary colleges by name</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Discover subjects offered at colleges</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Find colleges offering specific subjects</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Explore career pathways from job interests</li>
                  </ul>
                </div>
              </div>
              <div class="col-md-6">
                <div class="feature-card h-100 p-4 rounded shadow-sm border">
                  <h4 class="fw-bold mb-3">Getting Started</h4>
                  <p>Click the chat button in the bottom right corner to start a conversation. Ask questions related to education pathways and careers.</p>
                  <p class="mb-0">For the best experience, try asking about:</p>
                  <ul class="mb-0">
                    <li>University courses for specific careers</li>
                    <li>Subjects offered by a college</li>
                    <li>Colleges that teach your subject of interest</li>
                    <li>Career options related to job types</li>
                  </ul>
                </div>
              </div>
            </div>

            <div class="card bg-light mb-4">
              <div class="card-body p-4">
                <h4 class="fw-bold mb-3">Sample Questions</h4>
                <div class="sample-questions">
                  <span class="sample-question" @click="handleSampleQuestion('What university courses are available for Nursing?')">What university courses are available for Nursing?</span>
                  <span class="sample-question" @click="handleSampleQuestion('Which subjects are offered at Melbourne Secondary College?')">Which subjects are offered at Melbourne Secondary College?</span>
                  <span class="sample-question" @click="handleSampleQuestion('Which colleges offer Chemistry?')">Which colleges offer Chemistry?</span>
                  <span class="sample-question" @click="handleSampleQuestion('Show me careers related to Software Developer')">Show me careers related to Software Developer</span>
                  <span class="sample-question" @click="handleSampleQuestion('What university degrees match with Mental Health Counselor?')">What university degrees match with Mental Health Counselor?</span>
                </div>
              </div>
            </div>

            <div class="text-center">
              <p class="text-muted">Our AI assistant uses your information only to provide personalized guidance and doesn't store personal data.</p>
              <button class="btn btn-primary btn-lg" @click="toggleChatbot">
                <i class="bi bi-chat-dots-fill me-2"></i>Start Chatting Now
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Existing chatbot functionality (unchanged) -->
  <div class="chatbot-container" :class="{ 'chatbot-open': isOpen }">
    <!-- Chatbot Button - Larger with Robot Icon -->
    <div class="chatbot-button" @click="toggleChatbot">
      <div class="chatbot-icon">
        <!-- New Robot Icon -->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="10" rx="2" />
          <rect x="8" y="24" width="8" height="3" rx="1" ry="1" />
          <rect x="8" y="2" width="8" height="5" rx="1" ry="1" />
          <path d="M12 7v4" />
          <circle cx="8" cy="16" r="1" />
          <circle cx="16" cy="16" r="1" />
          <path d="M9 11v-1.5a3 3 0 0 1 6 0V11" />
        </svg>
      </div>
    </div>

    <!-- Chatbot Dialog - Larger size -->
    <div class="chatbot-dialog" v-if="isOpen">
      <div class="chatbot-header">
        <div class="header-content">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="me-2">
            <rect x="3" y="11" width="18" height="10" rx="2" />
            <rect x="8" y="24" width="8" height="3" rx="1" ry="1" />
            <rect x="8" y="2" width="8" height="5" rx="1" ry="1" />
            <path d="M12 7v4" />
            <circle cx="8" cy="16" r="1" />
            <circle cx="16" cy="16" r="1" />
            <path d="M9 11v-1.5a3 3 0 0 1 6 0V11" />
          </svg>
          <span>Career Guidance Assistant</span>
        </div>
        <button class="close-button" @click="toggleChatbot">
          <span>&times;</span>
        </button>
      </div>

      <div class="chatbot-messages" ref="messagesContainer">
        <div v-for="(message, index) in messages" :key="index" :class="['message', message.sender]">
          <div class="message-content">{{ message.text }}</div>
        </div>
        <!-- Loading indicator -->
        <div v-if="isLoading" class="message bot loading-message">
          <div class="loading-dots">
            <span></span>
            <span></span>
            <span></span>
          </div>
        </div>
      </div>

      <div class="suggested-responses" v-if="suggestedResponses.length > 0 && !isLoading">
        <button 
          v-for="(response, index) in suggestedResponses" 
          :key="index" 
          class="suggested-response-btn"
          @click="sendMessage(response.text)"
        >
          {{ response.text }}
        </button>
      </div>

      <div class="chatbot-input">
        <input 
          type="text" 
          v-model="userInput" 
          placeholder="Type your question here..." 
          @keyup.enter="sendMessage(userInput)"
          :disabled="isLoading"
        />
        <button class="send-button" @click="sendMessage(userInput)" :disabled="isLoading">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="22" y1="2" x2="11" y2="13"></line>
            <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import WorkflowApiService from '../../utils/WorkflowApiService';

export default {
  name: 'ChatBot',
  data() {
    return {
      isOpen: false,
      userInput: '',
      messages: [
        {
          sender: 'bot',
          text: "Hi there! I'm your Career Guidance Assistant. I can help you explore university courses, careers, subjects, and colleges. You can ask me about specific careers, search for subjects offered by colleges, or find colleges that offer certain subjects."
        }
      ],
      suggestedResponses: [
        { text: "Show me careers in healthcare" },
        { text: "What university courses are available for Nursing?" },
        { text: "Show me careers related to Software Developer?" }
      ],
      userContext: {
        yearLevel: null,
        interests: [],
        location: null
      },
      isLoading: false,
     
    };
  },
  created() {
    // Automatically open the chatbot if we're navigating to this page
    if (this.$route.path === '/chatbot') {
      // Use nextTick to ensure DOM is ready
      this.$nextTick(() => {
        this.isOpen = true;

        // Check for query parameters to autostart conversation
        if (this.$route.query.university) {
          const universityName = this.$route.query.university;
          
          // Create a custom message based on the university parameter
          const message = `Tell me about programs at ${universityName} University`;
          
          // Wait a moment before sending the message for better UX
          setTimeout(() => {
            this.sendMessage(message);
          }, 1000);
        }
      });
    }
  },
  methods: {
    toggleChatbot() {
      this.isOpen = !this.isOpen;
      if (this.isOpen) {
        this.$nextTick(() => {
          this.scrollToBottom();
        });
      }
    },
    handleSampleQuestion(question) {
      // Open chatbot if not already open
      if (!this.isOpen) {
        this.isOpen = true;
      }
      // Send the sample question
      this.sendMessage(question);
    },
    async sendMessage(text) {
      if (!text.trim() || this.isLoading) return;
      
      // Add user message
      this.messages.push({
        sender: 'user',
        text: text
      });
      
      // Clear input after sending
      this.userInput = '';
      this.isLoading = true;
      
      // Update context based on message
      this.updateContext(text);
      
      // Wait for DOM update
      this.$nextTick(() => {
        this.scrollToBottom();
        
        // Call the workflow API
        this.callWorkflowApi(text);
      });
    },
    updateContext(message) {
      // Update user context based on message content
      const lowerMessage = message.toLowerCase();
      
      // Detect data types being searched
      if (lowerMessage.includes('university') || lowerMessage.includes('course') || 
          lowerMessage.includes('major') || lowerMessage.includes('degree')) {
        this.userContext.searchType = 'university';
      } else if (lowerMessage.includes('college') || lowerMessage.includes('secondary')) {
        this.userContext.searchType = 'college';
      } else if (lowerMessage.includes('subject') || lowerMessage.includes('class')) {
        this.userContext.searchType = 'subject';
      } else if (lowerMessage.includes('career') || lowerMessage.includes('job')) {
        this.userContext.searchType = 'career';
      }
      
      // Detect specific careers or job interests
      const careerKeywords = {
        'healthcare': ['doctor', 'nurse', 'medical', 'health', 'medicine', 'counselor', 'nutritionist'],
        'technology': ['software', 'it', 'computer', 'programming', 'developer', 'engineering'],
        'business': ['business', 'management', 'marketing', 'finance', 'economics'],
        'education': ['teacher', 'education', 'teaching', 'professor', 'instructor']
      };
      
      Object.entries(careerKeywords).forEach(([career, keywords]) => {
        if (keywords.some(keyword => lowerMessage.includes(keyword)) && 
            !this.userContext.interests.includes(career)) {
          this.userContext.interests.push(career);
        }
      });
    },
    async callWorkflowApi(userMessage) {
      try {
       
        
        // Call the workflow API
        const response = await WorkflowApiService.runWorkflow(
          userMessage
        );
        
        // Process the response
        console.log('Workflow API response:', response);
        
        // Extract the bot message and suggestions from the response
        // This will depend on your specific workflow API response structure
        // The following is an example assuming a certain response format
        let botMessage = "I received your message.";
        let suggestions = [];
        
        if (response && response.data) {
          // Assuming the response has an outputs object with a bot_response field
          botMessage = response.data.outputs.text || botMessage;
          
          // Assuming the response includes suggested responses
          suggestions = response.data.outputs.suggestions || [];
        }
        
        // Add bot response
        this.messages.push({
          sender: 'bot',
          text: botMessage
        });
        
        // Update suggested responses
        this.suggestedResponses = suggestions.map(text => ({ text }));
      } catch (error) {
        console.error('Error calling workflow API:', error);
        
        // Add an error message
        this.messages.push({
          sender: 'bot',
          text: "Sorry, I'm having trouble processing your request right now. Please try again later."
        });
        
        this.suggestedResponses = [
          { text: "Try again" },
          { text: "Help" }
        ];
      } finally {
        this.isLoading = false;
        
        // Scroll to bottom after bot responds
        this.$nextTick(() => {
          this.scrollToBottom();
        });
      }
    },
    scrollToBottom() {
      if (this.$refs.messagesContainer) {
        this.$refs.messagesContainer.scrollTop = this.$refs.messagesContainer.scrollHeight;
      }
    }
  },
  // Watch for route changes to handle direct navigation to chatbot with parameters
  watch: {
    '$route.query': {
      immediate: true,
      handler(newQuery) {
        if (this.$route.path === '/chatbot' && newQuery.university && !this.isOpen) {
          this.isOpen = true;
          
          // Create a university-specific message
          const message = `Tell me about programs at ${newQuery.university} University`;
          
          // Add slight delay for better user experience
          setTimeout(() => {
            this.sendMessage(message);
          }, 1000);
        }
      }
    }
  }
};
</script>

<style scoped>
/* Existing chatbot styles */
.chatbot-container {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 1000;
  font-family: Arial, sans-serif;
}

.chatbot-button {
  width: 70px; /* Increased size */
  height: 70px; /* Increased size */
  border-radius: 50%;
  background-color: #396aae;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.3); /* Enhanced shadow */
  position: absolute;
  bottom: 0;
  right: 0;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.chatbot-button:hover {
  transform: scale(1.05);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.35);
}

.chatbot-icon {
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px; /* Increased icon size */
}

.chatbot-dialog {
  position: absolute;
  bottom: 80px;
  right: 0;
  width: 380px; /* Increased width */
  height: 500px; /* Increased height */
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 5px 25px rgba(0, 0, 0, 0.25);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transition: all 0.3s ease;
}

.chatbot-header {
  padding: 16px;
  background-color: #396aae;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: 600;
}

.header-content {
  display: flex;
  align-items: center;
}

.close-button {
  background: transparent;
  border: none;
  color: white;
  font-size: 24px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  width: 30px;
  height: 30px;
}

.chatbot-messages {
  flex: 1;
  padding: 16px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  background-color: #f9f9f9;
}

.message {
  margin-bottom: 12px;
  max-width: 85%;
  padding: 10px 14px;
  border-radius: 18px;
  word-wrap: break-word;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  line-height: 1.4;
}

.message.bot {
  align-self: flex-start;
  background-color: #f1f1f1;
  border-bottom-left-radius: 4px;
}

.message.user {
  align-self: flex-end;
  background-color: #e3f2fd;
  border-bottom-right-radius: 4px;
}

.suggested-responses {
  padding: 12px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 8px;
  border-top: 1px solid #eee;
  background-color: white;
}

.suggested-response-btn {
  background-color: #f1f1f1;
  border: none;
  border-radius: 18px;
  padding: 8px 16px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s ease;
  color: #333;
}

.suggested-response-btn:hover {
  background-color: #e0e0e0;
  transform: translateY(-1px);
}

.suggested-response-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.chatbot-input {
  padding: 12px 16px;
  display: flex;
  border-top: 1px solid #eee;
  background-color: white;
}

.chatbot-input input {
  flex: 1;
  padding: 12px 16px;
  border: 1px solid #ddd;
  border-radius: 24px;
  outline: none;
  margin-right: 10px;
  font-size: 15px;
}

.chatbot-input input:focus {
  border-color: #396aae;
  box-shadow: 0 0 0 2px rgba(57, 106, 174, 0.1);
}

.chatbot-input input:disabled {
  background-color: #f9f9f9;
  cursor: not-allowed;
}

.send-button {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background-color: #396aae;
  color: white;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s ease;
}

.send-button:hover {
  background-color: #2a5595;
  transform: scale(1.05);
}

.send-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.send-button svg {
  width: 20px;
  height: 20px;
}

/* Loading indicator styling */
.loading-message {
  padding: 12px;
}

.loading-dots {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 24px;
}

.loading-dots span {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: #396aae;
  margin: 0 3px;
  animation: dot-pulse 1.5s infinite ease-in-out;
}

.loading-dots span:nth-child(2) {
  animation-delay: 0.2s;
}

.loading-dots span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes dot-pulse {
  0%, 80%, 100% {
    transform: scale(0.8);
    opacity: 0.6;
  }
  40% {
    transform: scale(1.2);
    opacity: 1;
  }
}

/* Add a more prominent appearance when the chatbot is open */
.chatbot-open .chatbot-button {
  transform: scale(0.85);
  opacity: 0.8;
}

/* New styles for the chatbot page content */
.chatbot-page-content {
  margin-bottom: 100px; /* Space for the chatbot button */
}

.robot-icon-large {
  display: inline-block;
}

.feature-card {
  transition: all 0.3s ease;
  border-left: 5px solid #396aae !important;
}

.feature-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
}

.sample-questions {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
}

.sample-question {
  background-color: #e3f2fd;
  color: #396aae;
  border-radius: 20px;
  padding: 8px 16px;
  font-size: 14px;
  display: inline-block;
  cursor: pointer;
  transition: all 0.2s ease;
}

.sample-question:hover {
  background-color: #bbdefb;
  transform: translateY(-2px);
}

/* Bootstrap Icons placeholder */
.bi {
  display: inline-block;
  vertical-align: -0.125em;
  width: 1em;
  height: 1em;
}

.bi-check-circle-fill::before {
  content: "✓";
  color: #28a745;
}

.bi-chat-dots-fill::before {
  content: "💬";
}
</style>