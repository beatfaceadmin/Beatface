import { Injectable } from '@angular/core';
import { IApi } from '../shared/common/contracts/api';
import { User } from '../models/user';
import { GenericApi } from '../shared/common/generic-api';
import { Product } from '../models/product';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class ProductService {

  products: IApi<Product>;

  constructor(http: HttpClient) {
    this.products = new GenericApi<Product>('products', http);
  }

}
