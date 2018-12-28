import { Injectable } from '@angular/core';
import { IApi } from '../shared/common/contracts/api';
import { Feedback } from '../models/feedback';
import { GenericApi } from '../shared/common/generic-api';
import { HttpClient } from '@angular/common/http';


@Injectable()
export class FeedbackService {
  feedbacks: IApi<Feedback>;

  constructor(http: HttpClient) {
    this.feedbacks = new GenericApi<Feedback>('feedbacks', http);
  }

}
