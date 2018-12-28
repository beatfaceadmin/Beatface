import { Injectable } from '@angular/core';
import { IApi } from '../shared/common/contracts/api';
import { GenericApi } from '../shared/common/generic-api';
import { HttpClient } from '@angular/common/http';
import { Spotlight } from '../models/spotlight';

@Injectable()
export class SpotlightService {
  spotlight: IApi<Spotlight>;

  constructor(http: HttpClient) {
    this.spotlight = new GenericApi<Spotlight>('spotlights', http);
  }

}
