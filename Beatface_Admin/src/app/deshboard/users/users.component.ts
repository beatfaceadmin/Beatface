import { Component, OnInit } from '@angular/core';
import { User } from '../../models/user';
import { UserService } from '../../services/user.service';
import { Page } from '../../shared/common/contracts/page';



@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {

  users: Page<User>;

  constructor(private userService: UserService) {
    this.users = new Page({
      api: userService.users
    });
    this.fetch();
  }

  ngOnInit() {
  }


  fetch() {
    this.users.fetch();
  }

  deleteuser(id: number) {
    var isDelete = window.confirm('Are you sure want to delete ?')
    if (!isDelete) {
      return
    }
    this.users.isLoading = true;
    this.userService.users.remove(id).then(() => { this.users.isLoading = false; this.fetch(); });
  }

}








