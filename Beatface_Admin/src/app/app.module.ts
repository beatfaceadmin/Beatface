import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { AgmCoreModule } from '@agm/core';


import { AppRoutingModule } from './app-routing.module';
import {
  MatCardModule,
  MatTableModule, MatExpansionModule,
  MatListModule, MatButtonModule, MatIconModule,
  MatInputModule, MatSelectModule, MatFormFieldModule,
  MatToolbarModule, MatMenuModule, MatTooltipModule, MatAutocompleteModule
} from '@angular/material';

import { AppComponent } from './app.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { FileUploadModule } from 'ng2-file-upload';
import { ErrorComponent } from './error/error.component';
import { LoginFormComponent } from './login-form/login-form.component';
import { DeshboardComponent } from './deshboard/deshboard.component';
import { AppointmentComponent } from './deshboard/appointment/appointment.component';
import { UsersComponent } from './deshboard/users/users.component';
import { SpotlightComponent } from './deshboard/spotlight/spotlight.component';
import { ProductComponent } from './deshboard/product/product.component';
import { UpdateComponent } from './deshboard/appointment/update/update.component';
import { EditComponent } from './deshboard/users/edit/edit.component';
import { FeedbacksComponent } from './deshboard/feedbacks/feedbacks.component';
import { ArtistsComponent } from './deshboard/artists/artists.component';
import { LoginGuard } from './gaurds/login.guard';
import { UserGuard } from './gaurds/user.guard';
import { UserService } from './services/user.service';
import { ArtistService } from './services/artist.service';
import { AppointmentService } from './services/appointment.service';
import { FeedbackService } from './services/feedback.service';
import { ProductService } from './services/product.service';
import { SpinnerComponent } from './spinner/spinner.component';
import { SpotlightService } from './services/spotlight.service';
import { EditArtistComponent } from './deshboard/artists/edit-artist/edit-artist.component';

const MaterialModule = [
  MatCardModule,
  MatTableModule,
  MatExpansionModule,
  MatListModule,
  MatButtonModule,
  MatIconModule,
  MatInputModule,
  MatSelectModule,
  MatFormFieldModule,
  MatToolbarModule,
  MatMenuModule,
  MatTooltipModule,
  MatAutocompleteModule
];


@NgModule({
  declarations: [
    AppComponent,
    LoginFormComponent,
    DeshboardComponent,
    UsersComponent,
    AppointmentComponent,
    SpotlightComponent,
    ProductComponent,
    EditComponent,
    UpdateComponent,
    FeedbacksComponent,
    ArtistsComponent,
    ErrorComponent,
    SpinnerComponent,
    EditArtistComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    ReactiveFormsModule,
    HttpClientModule,
    FormsModule,
    MaterialModule,
    AppRoutingModule,
    FileUploadModule,
    AgmCoreModule.forRoot({
      // please get your own API key here:
      // https://developers.google.com/maps/documentation/javascript/get-api-key?hl=en
      apiKey: 'AIzaSyD8-yCdAAn9qWoMrEHu7s0BhsesVhv_kpY'
    })
  ],
  providers: [
    LoginGuard,
    UserGuard,
    UserService,
    AppointmentService,
    FeedbackService,
    ProductService,
    SpotlightService,
    ArtistService],
  bootstrap: [AppComponent]
})
export class AppModule { }
