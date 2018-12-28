export class Appointment {
    id?: number;
    comments? : string;
    time?: string;
    address?: string;
    addressCoordinates?: string;
    isUrgent?: string;
    status?: string;
    paymentStatus?: string;
    paymentMethod?: string;
    addressDescription?: string;
    price?: number;
    grandTotal?: number;
   
    constructor(appointment?: Appointment) {
        this.id = appointment && appointment.id ? appointment.id : null;
        this.comments = appointment && appointment.comments ? appointment.comments : '';
        this.time = appointment && appointment.time ? appointment.time : '';
        this.address = appointment && appointment.address ? appointment.address : '';
        this.addressCoordinates = appointment && appointment.addressCoordinates ? appointment.addressCoordinates : '';
        this.isUrgent = appointment && appointment.isUrgent ? appointment.isUrgent : '';
        this.status = appointment && appointment.status? appointment.status : '';
        this.paymentStatus = appointment && appointment.paymentStatus ? appointment.paymentStatus : '';
        this.paymentMethod = appointment && appointment.paymentMethod? appointment.paymentMethod : '';
        this.addressDescription = appointment && appointment.addressDescription? appointment.addressDescription : '';
        this.price = appointment && appointment.price? appointment.price :null;
        this.grandTotal = appointment && appointment.grandTotal? appointment.grandTotal : null;
       
    }
  }
  