import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Model } from '../../../shared/common/contracts/model';
import { Subscription } from 'rxjs';
import { UserService } from '../../../services/user.service';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from '../../../models/user';


@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.css']
})

export class EditComponent implements OnInit, OnDestroy {
    
  user: Model<User>;
  userForm: FormGroup;
  subscription: Subscription;

  constructor(private userService: UserService,
    private frmBuilder: FormBuilder,
    private router: Router,
    private activatedRoute: ActivatedRoute) {

    this.user = new Model({
      api: userService.users,
      properties: new User()
    });

    this.initForm();

    this.subscription = activatedRoute.params.subscribe(params => {
      const id = params['id'];
      if (id !== 'new') {
        this.getUser(id);
      }
    });


  }

  initForm() {
    this.userForm = this.frmBuilder.group({
      name: ['', [Validators.required]],
      gender: ['', [Validators.required]],
      location: ['', [Validators.required]],
      dob: ['', [Validators.required]],
      status: ['', [Validators.required]],
     
    });
  }



  getUser(id: string) {
    this.user.fetch(parseInt(id));
  }

  create() {
    if (this.user.properties.id) {
      return this.user.update().then(() => {
        this.router.navigate(['/pages/users']);
      });
    }
    this.user.create().then(() => {
      this.router.navigate(['/pages/users']);
    });
}

// save(){
//   this.router.navigate(['/pages/users']);
// }
  ngOnInit() {
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

 

}