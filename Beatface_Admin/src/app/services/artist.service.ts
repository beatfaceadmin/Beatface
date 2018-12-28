import { Injectable } from '@angular/core';
import { IApi } from '../shared/common/contracts/api';
import { Artist } from '../models/artist';
import { GenericApi } from '../shared/common/generic-api';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class ArtistService {
  artists: IApi<Artist>;

  constructor(http: HttpClient) {
    this.artists = new GenericApi<Artist>('artists', http);
  }

}
