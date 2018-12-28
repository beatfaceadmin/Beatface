import { Component, OnInit } from '@angular/core';
import { AppointmentService } from '../../services/appointment.service';
import { Page } from '../../shared/common/contracts/page';
import { Appointment } from '../../models/appointment';


@Component({
  selector: 'app-appointment',
  templateUrl: './appointment.component.html',
  styleUrls: ['./appointment.component.css']
})
export class AppointmentComponent implements OnInit {
  appointments: Page<Appointment>;
  status = ['', 'pending', 'active', 'start', 'complete', 'cancel']

  constructor(private appointmentService: AppointmentService) {
    this.appointments = new Page({
      api: appointmentService.appointments,
      serverPaging: false,
      filters: [{
        field: 'status',
        value: ''
      }]
    });
    this.fetch();
  }

  ngOnInit() {
  }

  update(appointment: Appointment) {
    this.appointments.isLoading = true;
    this.appointmentService.appointments.update(appointment.id, appointment).then(() => {
      this.appointments.isLoading = false;
      this.fetch();
    }).catch(err => alert(JSON.stringify(err)))
  }

  fetch() {
    this.appointments.fetch().then(() => {
      // this.appointments.items.forEach(item => {
      //   if (item.time) {
      //     item.time = (new Date(item.time)).toISOString();
      //   }
      // })
    });
  }


  deleteappointment(id: number) {
    this.appointments.isLoading = true;
    this.appointmentService.appointments.remove(id).then(() => {
      this.appointments.isLoading = false;
      this.fetch();
    });
  }

}
