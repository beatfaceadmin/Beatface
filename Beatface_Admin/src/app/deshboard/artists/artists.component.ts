import { Component, OnInit } from '@angular/core';
import { ArtistService } from '../../services/artist.service';
import { Page } from '../../shared/common/contracts/page';
import { Artist } from '../../models/artist';


@Component({
  selector: 'app-artists',
  templateUrl: './artists.component.html',
  styleUrls: ['./artists.component.css']
})
export class ArtistsComponent implements OnInit {
  artists: Page<Artist>;
  
  constructor(private artistService: ArtistService) {
    this.artists = new Page({
      api: artistService.artists,
      serverPaging: false,
      filters: [{
        field: 'status',
        value: 'pending'
      }]
    });
    this.fetch();
  }

  ngOnInit() {
  }

  update(artist: Artist) {
    this.artists.isLoading = true;
    this.artistService.artists.update(artist.id, artist).then(() => {
      this.artists.isLoading = false;
      this.fetch();
    }).catch(err => alert(JSON.stringify(err)))
  }

  fetch() {
    this.artists.fetch();
  }
  deleteartist(id: number) {
    this.artists.isLoading = true;
    this.artistService.artists.remove(id).
    then(() => { this.artists.isLoading = false;
       this.fetch(); 
      });
  }
}
