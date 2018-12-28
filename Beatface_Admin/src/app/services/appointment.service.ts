import { Injectable } from '@angular/core';
import { IApi } from '../shared/common/contracts/api';
import { Appointment } from '../models/appointment';
import { GenericApi } from '../shared/common/generic-api';
import { HttpClient } from '@angular/common/http';


@Injectable()
export class AppointmentService {
  appointments: IApi<Appointment>;

  constructor(http: HttpClient) {
    this.appointments = new GenericApi<Appointment>('appointments', http);
  }

}
