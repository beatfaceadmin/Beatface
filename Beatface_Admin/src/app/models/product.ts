export class Product {
    id?: number;
    name?: string;
    description?: string;
    picUrl?: string[];
    specifications?: string;
    selectionReason?: string;
    constructor(product?: Product) {
      this.id = product && product.id ? product.id : null;
      this.name = product && product.name ? product.name : '';
      this.description = product && product.description ? product.description : '';
      this.specifications = product && product.specifications ? product.specifications : '';
      this.selectionReason = product && product.selectionReason ? product.selectionReason : '';
      this.picUrl = product && product.picUrl ? product.picUrl : [];
    }
  }
  