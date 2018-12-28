import { Component, OnInit, OnDestroy } from '@angular/core';
import { Model } from '../../../shared/common/contracts/model';
import { Artist } from '../../../models/artist';
import { ArtistService } from '../../../services/artist.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-edit-artist',
  templateUrl: './edit-artist.component.html',
  styleUrls: ['./edit-artist.component.css']
})
export class EditArtistComponent implements OnInit, OnDestroy {

  artist: Model<Artist>;
  subscription: Subscription;

  constructor(private artistService: ArtistService,
    private router: Router,
    private activatedRoute: ActivatedRoute) {
    this.artist = new Model({
      api: artistService.artists,
      properties: new Artist()
    });

    this.subscription = activatedRoute.params.subscribe(params => {
      this.artist.properties.id = params['id'];
      this.fetch();
    });
  }

  fetch(id?: number) {
    this.artist.fetch(id || this.artist.properties.id).catch(err => alert(JSON.stringify(err)))
  }

  save() {
    this.artist.save().then(() => {
      this.router.navigate(['../'], { relativeTo: this.activatedRoute });
    });
  }

  ngOnInit() {
  }
  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

}
