import { Component, OnInit } from '@angular/core';
import { Page } from '../../shared/common/contracts/page';
import { Spotlight } from '../../models/spotlight';
import { SpotlightService } from '../../services/spotlight.service';
import { Model } from '../../shared/common/contracts/model';
import { Artist } from '../../models/artist';
import { ArtistService } from '../../services/artist.service';

export interface StateGroup {
  letter: string;
  names: string[];
}

@Component({
  selector: 'app-spotlight',
  templateUrl: './spotlight.component.html',
  styleUrls: ['./spotlight.component.css']
})


export class SpotlightComponent implements OnInit {
  
  // foods = [
  //   {value: 'steak-0', viewValue: 'January'},
  //   {value: 'pizza-1', viewValue: 'February'},
  //   {value: 'tacos-2', viewValue: 'March'},
  //   {value: 'pizza-1', viewValue: 'April'},
  //   {value: 'tacos-2', viewValue: 'May'},
  //   {value: 'pizza-1', viewValue: 'June '},
  //   {value: 'tacos-2', viewValue: 'July'},
  //   {value: 'pizza-1', viewValue: 'August'},
  //   {value: 'tacos-2', viewValue: 'September'},
  //   {value: 'pizza-1', viewValue: 'October '},
  //   {value: 'tacos-2', viewValue: 'November'},
  //   {value: 'pizza-1', viewValue: 'December'},
   
  // ];
  isNew: boolean = false;
  spotlights: Page<Spotlight>;
  spotlight: Model<Spotlight>;
  artists: Page<Artist>;
  
  constructor(private spotlightService: SpotlightService, private artistService: ArtistService) {
    this.spotlight = new Model({
      api: spotlightService.spotlight,
      properties: new Spotlight()
    });

    this.artists = new Page({
      api: artistService.artists,
      serverPaging: false,
    });

    this.spotlights = new Page({
      api: spotlightService.spotlight,
      serverPaging: false
    });

    this.artists.fetch();
    this.fetch();
  }

  removeItem(index: number, array: Array<string>) {
    array.splice(index, 1);
  }

  newSpot() {
    this.spotlight.properties = new Spotlight();
    this.isNew = true;
  }
  add(type: 'SR' | 'SP', spotlight: Spotlight, value: string) {
    if (!value) {
      return;
    }
    switch (type) {
      case 'SR':
        spotlight.selectionReason['push'](value);
        break;
      case 'SP':
        spotlight.specialties['push'](value);
        break;
    }

  }

  save(spotlight: Spotlight) {

    if (spotlight.selectionReason.length == 0) {
      return alert('Please add selectionReason');
    }
    if (!spotlight.artistId) {
      return alert('Please add artist');
    }
    if (spotlight.specialties.length == 0) {
      return alert('Please add selectionReason');
    }
    this.isNew = false;
    this.spotlight.isProcessing = true;

    this.spotlight.properties = new Spotlight(spotlight);
    this.spotlight.save().then(() => {
      this.spotlight.properties = new Spotlight();
      this.fetch();
    }).catch(err => alert(JSON.stringify(err)));
  }

  remove(spotlight: Spotlight) {
    this.spotlight.properties = spotlight;
    this.spotlight.remove().then(() => {
      this.spotlight.properties = new Spotlight();
      this.fetch();
    }).catch(err => alert(JSON.stringify(err)));
  }

  fetch() {
    this.spotlights.fetch().then(() => {
      if (this.spotlights.items.length == 0) {
        this.newSpot();
      }
    }).catch(err => alert(JSON.stringify(err)));
  }

  ngOnInit() {
  }

}
