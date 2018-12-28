export class User {
  id?: number;
  name?: string;
  dob?: string;
  token?: string;
  age?: string;
  gender?: string;
  status?: string;
  location?: string;
  artist?: string;
  phone?: string;
  email?: string;
  type?: string;
  picUrl?:string;
  constructor(user?: User) {
    this.id = user && user.id ? user.id : null;
    this.name = user && user.name ? user.name : '';
    this.token = user && user.token ? user.token : '';
    this.age = user && user.age ? user.age : '';
    this.gender = user && user.status ? user.status : '';
    this.location = user && user.location ? user.location : '';
    this.artist = user && user.artist ? user.artist : '';
    this.phone = user && user.phone ? user.phone : '';
    this.email = user && user.email ? user.email : '';
    this.type = user && user.type ? user.type : '';
    this.picUrl = user && user.picUrl ? user.picUrl : '';
    this.dob = user && user.dob ? user.dob : '';
  }
}
