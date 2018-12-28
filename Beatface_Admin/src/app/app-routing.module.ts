import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';




import { AppointmentComponent } from './deshboard/appointment/appointment.component';
import { DeshboardComponent } from './deshboard/deshboard.component';
import { LoginFormComponent } from './login-form/login-form.component';
import { UsersComponent } from './deshboard/users/users.component';
import { SpotlightComponent } from './deshboard/spotlight/spotlight.component';
import { ProductComponent } from './deshboard/product/product.component';
import { LoginGuard } from './gaurds/login.guard';
import { UserGuard } from './gaurds/user.guard';
import { EditComponent } from './deshboard/users/edit/edit.component';
import { UpdateComponent } from './deshboard/appointment/update/update.component';
import { FeedbacksComponent } from './deshboard/feedbacks/feedbacks.component';
import { ArtistsComponent } from './deshboard/artists/artists.component';
import { ErrorComponent } from './error/error.component';
import { EditArtistComponent } from './deshboard/artists/edit-artist/edit-artist.component';

const childRoutes: Routes = [
  { path: '', redirectTo: 'artist', pathMatch: 'full' },
  { path: 'users', component: UsersComponent },
  { path: 'users/edit/:id', component: EditComponent },
  { path: 'appointment', component: AppointmentComponent },
  { path: 'appointment/update/:id', component: UpdateComponent },
  { path: 'spotlight', component: SpotlightComponent },
  { path: 'product', component: ProductComponent, },
  { path: 'artists', component: ArtistsComponent, },
  { path: 'artists/:id', component: EditArtistComponent, },
  { path: 'feedbacks', component: FeedbacksComponent }

];


const routes: Routes = [
  { path: '', redirectTo: 'pages', pathMatch: 'full' },
  { path: 'pages', component: DeshboardComponent, children: childRoutes, canActivate: [UserGuard] },
  { path: 'signin', component: LoginFormComponent, canActivate: [LoginGuard] },
  { path: 'error', component: ErrorComponent },
  { path: '**', redirectTo: 'pages' }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
