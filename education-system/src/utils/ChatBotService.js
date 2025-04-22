// src/utils/ChatBotService.js

/**
 * Service for handling chatbot interactions
 * This would connect to your backend API in a production environment
 */
export default {
    /**
     * Send a user message to the chatbot and get a response
     * @param {string} message - The user's message
     * @param {Object} context - User context (year level, interests, etc.)
     * @returns {Promise} - Promise resolving to chatbot response
     */
    async sendMessage(message, context = {}) {
      // In production, this would be an API call to your backend
      // For now, we'll simulate a response
      
      try {
        // Simulate API delay
        await new Promise(resolve => setTimeout(resolve, 500));
        
        // This is where you would make your actual API call
        // const response = await fetch('/api/chatbot', {
        //   method: 'POST',
        //   headers: { 'Content-Type': 'application/json' },
        //   body: JSON.stringify({ message, context })
        // });
        // return await response.json();
        
        // For now, return mock data
        return this._getMockResponse(message, context);
      } catch (error) {
        console.error('Error in chatbot service:', error);
        return {
          message: "Sorry, I'm having trouble connecting right now. Please try again later.",
          suggestions: []
        };
      }
    },
    
    /**
     * Mock response generator - replace with actual AI backend integration
     * @private
     */
    _getMockResponse(message, context) {
      const lowerMessage = message.toLowerCase();
      
      // Career guidance responses
      if (lowerMessage.includes('career') || lowerMessage.includes('job')) {
        return {
          message: "Choosing a career path is an important decision. What fields are you interested in? (e.g., healthcare, IT, business, creative arts)",
          suggestions: [
            "I'm interested in healthcare",
            "I'm interested in IT",
            "I'm interested in creative fields",
            "I'm not sure yet"
          ]
        };
      }
      
      // Subject selection responses
      if (lowerMessage.includes('subject') || lowerMessage.includes('vce')) {
        return {
          message: "VCE subject selection is crucial for university pathways. What career or university course are you considering?",
          suggestions: [
            "Science/Medicine pathways",
            "Engineering pathways",
            "Business pathways",
            "Arts/Humanities pathways"
          ]
        };
      }
      
      // ATAR-related responses
      if (lowerMessage.includes('atar') || lowerMessage.includes('score')) {
        return {
          message: "ATAR requirements vary by university and course. Most courses publish a clearly-in ATAR score. Which specific university or course are you interested in?",
          suggestions: [
            "Monash University courses",
            "University of Melbourne courses",
            "Regional university options",
            "Low ATAR pathways"
          ]
        };
      }
      
      // School availability checker
      if (lowerMessage.includes('school') || lowerMessage.includes('available')) {
        return {
          message: "Not all schools offer every VCE subject. Which specific subject are you wondering about availability?",
          suggestions: [
            "Specialist Mathematics",
            "Software Development",
            "Languages",
            "Check all available subjects"
          ]
        };
      }
      
      // Year level specific responses
      if (lowerMessage.includes('year 11') || context.yearLevel === 11) {
        return {
          message: "Year 11 is a great time to start planning your pathway. Are you looking for advice on VCE subject selection or exploring university courses?",
          suggestions: [
            "VCE subject advice",
            "University prerequisites",
            "Career pathways",
            "ATAR requirements"
          ]
        };
      }
      
      if (lowerMessage.includes('year 12') || context.yearLevel === 12) {
        return {
          message: "As a Year 12 student, you're probably thinking about university applications. Do you need help with course selection, VTAC preferences, or understanding prerequisites?",
          suggestions: [
            "VTAC application help",
            "University course selection",
            "Scholarship information",
            "Alternative pathways"
          ]
        };
      }
      
      // Default response
      return {
        message: "I'm here to help with your career and study planning. What would you like to know about VCE subjects, university courses, or career pathways?",
        suggestions: [
          "Help with VCE subjects",
          "University course information",
          "Career options exploration",
          "Regional study opportunities"
        ]
      };
    }
  };