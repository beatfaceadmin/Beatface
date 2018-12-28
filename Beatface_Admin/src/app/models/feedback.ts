export class Feedback {
    id?: number;
    date?: string;
    time?: string;
    feedback?: string;
    
    constructor(feedback?: Feedback) {
        this.id = feedback && feedback.id ? feedback.id : null;
        this.date = feedback && feedback.date ? feedback.date : '';
        this.time = feedback && feedback.time ? feedback.time : '';
        this.feedback = feedback && feedback.feedback ? feedback.feedback : '';
        
    }
  }
  