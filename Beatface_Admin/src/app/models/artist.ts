import { User } from "./user";

export class Artist {
    id?: number = null;
    phone?: string = "";
    email?: string = "";
    status?: string = "";
    user: User = new User();
    rating: number = null;
    workExperience: number = null;
    availbilityRange: number = null;
    availbilityArea: string = "";
    availbilityStart: string = "";
    availbilityTill: string = "";
    businessName: string = "";
    businessAddress: string = "";
    businessCordinates: number[] = [];
    coverPic: string = "";
    attachment: string[] = [];
    socialLinks: string[] = [];
    date?: string = "";
    constructor(artist?: Artist) {
        this.id = artist && artist.id ? artist.id : null;
        this.rating = artist && artist.rating ? artist.rating : null;
        this.workExperience = artist && artist.workExperience ? artist.workExperience : null;
        this.phone = artist && artist.phone ? artist.phone : '';
        this.email = artist && artist.email ? artist.email : '';
        this.availbilityArea = artist && artist.availbilityArea ? artist.availbilityArea : '';
        this.availbilityStart = artist && artist.availbilityStart ? artist.availbilityStart : '';
        this.availbilityTill = artist && artist.availbilityTill ? artist.availbilityTill : '';
        this.status = artist && artist.status ? artist.status : '';
        this.businessName = artist && artist.businessName ? artist.businessName : '';
        this.user = artist && artist.user ? new User(artist.user) : new User();
        this.date = artist && artist.date ? artist.date : '';
    }
}
