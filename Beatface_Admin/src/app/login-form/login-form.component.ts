import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, FormBuilder, Validators } from '@angular/forms';
import { UserService } from '../services/user.service';
import { User } from '../models/user';
import { Model } from '../shared/common/contracts/model';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styleUrls: ['./login-form.component.css']
})

export class LoginFormComponent implements OnInit {

  loginForm: FormGroup;
  hide = true;

  constructor(private frmBuilder: FormBuilder,
    private userService: UserService,
    private router: Router) {
    this.initForm();
  }

  initForm() {
    this.loginForm = this.frmBuilder.group({
      password: ['', [Validators.required, Validators.email]],
      email: ['', [Validators.required]],
    })
  }

  logIn() {
    this.userService.signIn.create(this.loginForm.value).then((data) => {
      if (!data.type || data.type.toLowerCase() != "admin") {
        return this.router.navigate(['/error'],{queryParams:{msg:"Only Admin Accessible !"}});
      }
      window.localStorage.setItem('token', data.token);
      window.localStorage.setItem('user', JSON.stringify(data));
      this.router.navigate(['/pages']);
    }).catch(err => alert(err));
  }

  ngOnInit() {
  }

  // submit(e){
  //   e.preventDefault();
  //   console.log(e);
  //   var username = e.target.elements[0].value;
  //   var password = e.target.elements[1].value;

  //   if(username == 'admin' && password == 'admin'){
  //      this.router.navigate(['/']);    
  //   }
  // }



}