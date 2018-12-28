import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';
import { Router } from '@angular/router';
import { Page } from '../shared/common/contracts/page';
import { Artist } from '../models/artist';
import { ArtistService } from '../services/artist.service';
import { Filter } from '../shared/common/contracts/filters';
// import { Router } from '@angular/router';
// import { User } from '../models/user';

export class NavLink {
  name: string;
  url: string;
}

@Component({
  selector: 'app-deshboard',
  templateUrl: './deshboard.component.html',
  styleUrls: ['./deshboard.component.css']
})
export class DeshboardComponent implements OnInit {
  user: User;
  artists: Page<Artist>;
  links: NavLink[] = [
    { name: 'USERS', url: '/pages/users' },
    { name: 'APPOINTMENT', url: '/pages/appointment' },
    { name: 'ARTISTS', url: '/pages/artists' },
    { name: 'SPOTLIGHT', url: '/pages/spotlight' },
    { name: 'PRODUCT OF MONTH', url: '/pages/product' },
    { name: 'FEEDBACK', url: '/pages/feedbacks' },
  ]
  selectedFilter: string = 'name';

  filters = [{
    field: 'name',
    value: null,
    displayName: 'Artist'
  }, {
    field: 'serviceName',
    value: null,
    displayName: 'Service'
  }, {
    field: 'businessAddress',
    value: null,
    displayName: 'Location'
  }, {
    field: 'email',
    value: null,
    displayName: 'Email'
  }]


  constructor(private router: Router, private artistService: ArtistService) {
    this.user = JSON.parse(window.localStorage.getItem('user'));

    this.artists = new Page({
      api: artistService.artists,
      serverPaging: false,
      filters: this.filters
    });
  }
  ngOnInit() {
  }

  logOut() {
    window.localStorage.clear();
    this.router.navigate(['/signin']);
  }

  searchArtist(text: string) {

    if (!text || text.length < 3) {
      return;
    }
    this.artists.filters.reset();
    this.artists.filters.properties[this.selectedFilter].value = text;
    this.artists.fetch();

  }
  onSelectArtist(artist: Artist) {
    if (document.getElementById('searchBar')) {
      document.getElementById('searchBar')['value'] = null;
      this.router.navigate(['/pages/artists', artist.id]);
    }

  }


}
