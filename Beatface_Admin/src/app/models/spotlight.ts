import { User } from "./user";
import { Artist } from "./artist";

export class Spotlight {
    id?: number;
    selectionReason?: string[] | string;
    specialties?: string[] | string;
    artistId: number;
    artist: Artist;
    user: User = new User();
    month?: string = "";
    constructor(spotlight?: Spotlight) {
        this.id = spotlight && spotlight.id ? spotlight.id : null;
        this.artistId = spotlight && spotlight.artistId ? spotlight.artistId : null;
        this.selectionReason = spotlight && spotlight.selectionReason ? spotlight.selectionReason : [];
        this.specialties = spotlight && spotlight.specialties ? spotlight.specialties : [];
        this.artist = spotlight && spotlight.artist ? new Artist(spotlight.artist) : new Artist();
        this.user = spotlight && spotlight.user ? new User(spotlight.user) : new User();
        this.month = spotlight && spotlight.month ? spotlight.month : '';
    }

    
}
