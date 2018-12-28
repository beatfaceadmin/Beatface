//
//  FileUpload.swift
//  SearchApp
//
//  Created by dEEEP on 28/03/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//


import Foundation
import Alamofire
import SVProgressHUD
import Cloudinary


class FileUpload {
  
  let queue = DispatchQueue(label: "com.fileupload.queue", attributes: DispatchQueue.Attributes.concurrent)
  var downloadedImage : UIImage?
   private let baseUrl1 = beatfaceConfig.mBaseUrl1
  fileprivate let imageUrl = "images/upload"
  var countValue: Int = 0
  var cld = CLDCloudinary(configuration: CLDConfiguration(cloudName: beatfaceConfig.cloudName,apiKey: beatfaceConfig.cloudKey,apiSecret: beatfaceConfig.cloudSecret, secure: true))

  
  //Utilize Singleton pattern by instanciating API only once.
  class var sharedInstance: FileUpload {
    struct Singleton {
      static let instance = FileUpload()
    }
    
    return Singleton.instance
  }
  
  init() {
    
  }
  
   func uploadImageRemote (imageh:UIImage?, callback:@escaping (_ url:  String?, _ error: String? ) -> Void){
  if let image = imageh, let data = UIImageJPEGRepresentation(image, 1.0) {
  

  
    let progressHandler = { (progress: Progress) in
      let ratio: CGFloat = CGFloat(progress.completedUnitCount) / CGFloat(progress.totalUnitCount)
      SVProgressHUD.showProgress(Float(ratio))
    }
    cld.createUploader().upload(data: data, uploadPreset: beatfaceConfig.cloudPreset, progress: progressHandler) { (result, error) in
     SVProgressHUD.dismiss()
      
      if let error = error {
       print(error.description)
        callback(nil,"Failed")
//        os_log("Error uploading image %@", error)
      } else {
        if let result = result, let publicUrl = result.url {
          callback(publicUrl,nil)
        }else{
           callback(nil,"Failed")
        }
      }
    }
  }
  }
  
  
  //MARK:upload image to server and returns dictionary containing url and image DATA
  
  func uploadImageaaaRemote (image:UIImage, callback:@escaping (_ data: Dictionary<String, String>?, _ error: NSError? ) -> Void){
    
    
//    let imageData = UIImageJPEGRepresentation(image, 1.0)
//    let imageInfo : UIImage = UIImage(data: imageData!)!
    
    let baseUrl = baseUrl1 + self.imageUrl
    
    
     let data = UIImageJPEGRepresentation(image,1)
      

      let parameters: Parameters = [
        "x-access-token" : Constants.kUserDefaults.string(forKey: appConstants.token)!
      ]
       let imageData = UIImageJPEGRepresentation(image, 1.0)
      
      Alamofire.upload(multipartFormData: { (multipartFormData) in
        multipartFormData.append(data!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
        for (key, value) in parameters {
          multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
        }
      }, to:baseUrl)
      { (result) in
        switch result {
        case .success(let upload, _, _):
          
          upload.uploadProgress(closure: { (Progress) in
            print("Upload Progress: \(Progress.fractionCompleted)")
          })
          
          upload.responseJSON { response in
            //self.delegate?.showSuccessAlert()
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            //                        self.showSuccesAlert()
            //self.removeImage("frame", fileExtension: "txt")
            if let JSON = response.result.value {
              print("JSON: \(JSON)")
            }
          }
          
        case .failure(let encodingError):
          //self.delegate?.showFailAlert()
          print(encodingError)
        }
        
      }
      
      
      
      
      
      
//      // You can change your image name here, i use NSURL image and convert into string
//      let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//      let fileName = imageURL.absouluteString
      // Start Alamofire
  
      
//      Alamofire.upload(multipartFormData: { multipartFormData in
//        for (key,value) in parameters {
//          multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//        }
//        multipartFormData.append(data, withName: "image", fileName: fileName!,mimeType: "image/jpeg")
//      },
//                       usingTreshold: UInt64.init(),
//                       to: baseUrl,
//                       method: .put,
//                       encodingCompletion: { encodingResult in
//                        switch encodingResult {
//                        case .success(let upload, _, _):
//                          upload.responJSON { response in
//                            debugPrint(response)
//                          }
//                        case .failure(let encodingError):
//                          print(encodingError)
//                        }
//      })
    
    
  
    
   
  
    
//
//    let headers = ["x-access-token": BackgroundManager.sharedInstance.authToken]
//    BackgroundManager.sharedInstance.manager.upload(multipartFormData: { multipartFormData in
//
//      if  let imageData = UIImageJPEGRepresentation(imageInfo, 1.0) {
//        multipartFormData.append(imageData, withName: "image", fileName: "file.png", mimeType: "image/png")
//
//
//      }
//    }, to: baseUrl, method: .post, headers : headers,encodingCompletion: { encodingResult in
//      switch encodingResult {
//      case .success(let upload, _, _):
//        print("Uploading Avatar IMAGE:\(upload)")
//
//        upload.responseJSON { response in
//
//          guard response.result.error == nil else {
//            print(response.result.value)
//            print("error calling POST IMAGE: \(response.result.error!)")
//            //TODO uncomment below mwthod and call it only if net is available
//
//            if Reachability.isConnectedToNetwork() == true {
//              print("Internet connection OK")
//              self.uploadImageRemote(image: image){(data,error) -> Void in
//              }
//
//            } else {
//              print("Internet connection FAILED")
//              let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//              alert.show()
//            }
//
//            return
//          }
//
//          if let value = response.result.value {
//            print("Success JSON IMAGE:\(value)")
//
//
//
//
//            if let result = value as? Dictionary<String, AnyObject> {
//              let thumbnaildata:String = UIImageJPEGRepresentation(image, 1.0)!.base64EncodedString(options: .lineLength64Characters)
//              //base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
//
////              _ = ["url":result.valueForKeyPath("data.url")!,"thumbnailData":thumbnaildata] as Dictionary<String,String>
//
//              callback(value as? Dictionary<String, String>  ,nil)
//
//            }
//          }
//
//        }
//      case .failure(let encodingError):
//        //Show Alert in UI
//        SVProgressHUD.showError(withStatus: "abc")
//        // Give -1 so that you know that there is error
//        print("Avatar not uploaded \(encodingError)");
//
//      }
//
//    })
//  }
}
}
