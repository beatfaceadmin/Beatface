import { Component, OnInit } from '@angular/core';
import {  FeedbackService } from '../../services/feedback.service';
import { Page } from '../../shared/common/contracts/page';
import { Feedback } from '../../models/feedback';

@Component({
  selector: 'app-feedbacks',
  templateUrl: './feedbacks.component.html',
  styleUrls: ['./feedbacks.component.css']
})
export class FeedbacksComponent implements OnInit {
  feedbacks: Page<Feedback>;

  constructor(private FeedbackService: FeedbackService) { 

  this.feedbacks = new Page({
    api: FeedbackService.feedbacks
  });
  this.fetch();
}


ngOnInit() {
}

fetch() {
  this.feedbacks.fetch();
}

}