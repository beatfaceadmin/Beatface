
import { Component, OnInit, OnDestroy } from '@angular/core';
import { FileUploader, FileItem, ParsedResponseHeaders } from 'ng2-file-upload';
import { Model } from '../../shared/common/contracts/model';
import { Product } from '../../models/product';
import { ProductService } from '../../services/product.service';
import { Page } from '../../shared/common/contracts/page';



@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})

export class ProductComponent implements OnInit {
  uploader: FileUploader;
  products: Page<Product>;
  product: Model<Product>;
  

  constructor(private productService: ProductService) {

    this.products = new Page({
      api: productService.products
    });
    
    this.fetch();
  
  }

  addWord() {
    this.productService.products
  }

  upload(){}
  
  ngOnInit() {
  }

  fetch() {
    this.products.fetch();
  }
  
}
