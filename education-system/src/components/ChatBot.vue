<!-- components/ChatBot.vue -->
<template>
    <div class="chatbot-container" :class="{ 'chatbot-open': isOpen }">
      <!-- Chatbot Button -->
      <div class="chatbot-button" @click="toggleChatbot">
        <div class="chatbot-icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="16" x2="12" y2="16.01"></line>
            <path d="M12 12a2 2 0 0 0 .914-3.782 1.98 1.98 0 0 0-2.414.483"></path>
          </svg>
        </div>
      </div>
  
      <!-- Chatbot Dialog -->
      <div class="chatbot-dialog" v-if="isOpen">
        <div class="chatbot-header">
          <span>Career Guidance Assistant</span>
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
          />
          <button class="send-button" @click="sendMessage(userInput)">
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
  import ChatBotService from '../utils/ChatBotService';
  
  export default {
    name: 'ChatBot',
    data() {
      return {
        isOpen: false,
        userInput: '',
        messages: [
          {
            sender: 'bot',
            text: "Hi there! I'm your Career Guide Bot. How can I help with your career or study questions today?"
          }
        ],
        suggestedResponses: [
          { text: "Yes, I'm in Year 11" },
          { text: "Yes, I'm in Year 12" }
        ],
        userContext: {
          yearLevel: null,
          interests: [],
          location: null
        },
        isLoading: false
      };
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
      async sendMessage(text) {
        if (!text.trim()) return;
        
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
          
          // Get response from service
          this.getBotResponse(text);
        });
      },
      updateContext(message) {
        // Update user context based on message content
        const lowerMessage = message.toLowerCase();
        
        // Detect year level
        if (lowerMessage.includes('year 11') || lowerMessage.includes('i\'m in year 11')) {
          this.userContext.yearLevel = 11;
        } else if (lowerMessage.includes('year 12') || lowerMessage.includes('i\'m in year 12')) {
          this.userContext.yearLevel = 12;
        }
        
        // Detect interests (simplified example)
        const interestKeywords = {
          'healthcare': ['doctor', 'nurse', 'medical', 'health', 'medicine'],
          'technology': ['software', 'it', 'computer', 'programming', 'tech'],
          'business': ['business', 'management', 'marketing', 'finance', 'economics'],
          'creative': ['art', 'design', 'music', 'writing', 'creative']
        };
        
        Object.entries(interestKeywords).forEach(([interest, keywords]) => {
          if (keywords.some(keyword => lowerMessage.includes(keyword)) && 
              !this.userContext.interests.includes(interest)) {
            this.userContext.interests.push(interest);
          }
        });
      },
      async getBotResponse(userQuestion) {
        try {
          // Get response from service
          const response = await ChatBotService.sendMessage(userQuestion, this.userContext);
          
          // Add bot response
          this.messages.push({
            sender: 'bot',
            text: response.message
          });
          
          // Update suggested responses
          this.suggestedResponses = response.suggestions.map(text => ({ text }));
        } catch (error) {
          console.error('Error getting bot response:', error);
          this.messages.push({
            sender: 'bot',
            text: "Sorry, I'm having trouble processing your request right now. Please try again later."
          });
          this.suggestedResponses = [];
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
    }
  };
  </script>
  
  <style scoped>
  .chatbot-container {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
    font-family: Arial, sans-serif;
  }
  
  .chatbot-button {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #396aae;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    position: absolute;
    bottom: 0;
    right: 0;
  }
  
  .chatbot-icon {
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .chatbot-dialog {
    position: absolute;
    bottom: 60px;
    right: 0;
    width: 300px;
    height: 400px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }
  
  .chatbot-header {
    padding: 12px;
    background-color: #396aae;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .close-button {
    background: transparent;
    border: none;
    color: white;
    font-size: 20px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .chatbot-messages {
    flex: 1;
    padding: 10px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
  }
  
  .message {
    margin-bottom: 10px;
    max-width: 80%;
    padding: 8px 12px;
    border-radius: 15px;
    word-wrap: break-word;
  }
  
  .message.bot {
    align-self: flex-start;
    background-color: #f1f1f1;
  }
  
  .message.user {
    align-self: flex-end;
    background-color: #e3f2fd;
  }
  
  .suggested-responses {
    padding: 10px;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 5px;
    border-top: 1px solid #eee;
  }
  
  .suggested-response-btn {
    background-color: #f1f1f1;
    border: none;
    border-radius: 15px;
    padding: 5px 10px;
    font-size: 12px;
    cursor: pointer;
    transition: background-color 0.2s;
  }
  
  .suggested-response-btn:hover {
    background-color: #e0e0e0;
  }
  
  .chatbot-input {
    padding: 10px;
    display: flex;
    border-top: 1px solid #eee;
  }
  
  .chatbot-input input {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 20px;
    outline: none;
    margin-right: 8px;
  }
  
  .send-button {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background-color: #396aae;
    color: white;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
  }
  
  .send-button svg {
    width: 18px;
    height: 18px;
  }
  
  /* Loading indicator styling */
  .loading-message {
    padding: 10px;
  }
  
  .loading-dots {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 20px;
  }
  
  .loading-dots span {
    display: inline-block;
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background-color: #396aae;
    margin: 0 2px;
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
  </style>