import { AppointmentService } from '../../../services/appointment.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Appointment } from '../../../models/appointment';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Model } from '../../../shared/common/contracts/model';
import { Subscription } from 'rxjs';


@Component({
  selector: 'app-update',
  templateUrl: './update.component.html',
  styleUrls: ['./update.component.css']
})
export class UpdateComponent implements OnInit, OnDestroy {
  
  appointment: Model<Appointment>;
  userForm: FormGroup;
  subscription: Subscription;

  constructor(private appointmentService: AppointmentService,
    private frmBuilder: FormBuilder,
    private router: Router,
    private activatedRoute: ActivatedRoute) {

    this.appointment = new Model({
      api: appointmentService.appointments,
      properties: new Appointment()
    });

    this.initForm();

  this.subscription = activatedRoute.params.subscribe(params => {
      const id = params['id'];
      if (id !== 'new') {
        this.getAppointment(id);
      }
    });


  }

  initForm() {
    this.userForm = this.frmBuilder.group({
      comments: ['', [Validators.required]],
      time: ['', [Validators.required]],
      price: ['', [Validators.required]],
      grandTotal: ['', [Validators.required]],
      address: ['', [Validators.required]],
      addressDescription: ['', [Validators.required]],
      paymentStatus: ['', [Validators.required]],
      status: ['', [Validators.required]],
      paymentMethod: ['', [Validators.required]],
      isUrgent: ['', [Validators.required]],
    });
  }



  getAppointment(id: string) {
    this.appointment.fetch(parseInt(id));
  }

  create() {
    if (this.appointment.properties.id) {
      return this.appointment.update().then(() => {
        this.router.navigate(['/pages/appointment']);
      });
    }
    this.appointment.create().then(() => {
      this.router.navigate(['/pages/appointment']);
    });
}

// save(){
//   this.router.navigate(['/pages/appointment']);
// }
  ngOnInit() {
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

 



 
}
