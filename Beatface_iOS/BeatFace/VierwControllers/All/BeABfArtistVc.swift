//
//  BeABfArtistVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 25/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class BeABfArtistVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    @IBOutlet weak var bProfileImgOutlet: UIButton!
    @IBOutlet weak var bNextBtnOut: UIButton!
    @IBOutlet weak var bNameTextField: UITextField!
    @IBOutlet weak var bDOBTextField: UITextField!
    @IBOutlet weak var bGenderTextField: UITextField!
    
    let obj = GenFuncs()
    let Genders = ["Male", "Female" ,"Other"]
    var imagepicker: UIImagePickerController!
    var pickerView = UIPickerView() //Picker for GenderTextField
    let DOBpicker = UIDatePicker()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        obj.roundtheButton(buttonname: bNextBtnOut)
        obj.roundtheButton(buttonname: bProfileImgOutlet)
        let imgTitle = UIImage(named: "titleBeABfArtist")
        navigationItem.titleView = UIImageView(image: imgTitle)
        self.bNameTextField.delegate = self
        self.bDOBTextField.delegate = self
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        bGenderTextField.inputView = pickerView
        createDatePicker()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func bNextBtn(_ sender: UIButton) {
        if bNameTextField.text?.isEmpty == true || bGenderTextField.text?.isEmpty == true {
            let alertcontroller = UIAlertController(title: "Invalid", message: "Please fill all details", preferredStyle: .alert)
            alertcontroller.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alertcontroller, animated: true)
        }
        
        else if (bNameTextField.text?.count)! < 3  {
            let alertcontroller = UIAlertController(title: "Invalid", message: "The Name should be atleast 3 characters long", preferredStyle: .alert)
            alertcontroller.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alertcontroller, animated: true)
        }
        
        else {
            let vcbeabfartist2 = storyboard?.instantiateViewController(withIdentifier: "ArtistOnboarding1ID") as! ArtistOnboarding1
            self.navigationController?.pushViewController(vcbeabfartist2, animated: true)
        }
            
        }
 
    // Setting Profile Pic
    @IBAction func bProfileBtnTapped(_ sender: UIButton) {
        
        let alertcontroller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        
        let cameraAction = UIAlertAction(title: "Use Camera", style: .default) { (action) in
        self.imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            self.imagepicker.sourceType = .camera
            self.imagepicker.allowsEditing = true
            self.present(self.imagepicker, animated: true, completion: nil)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Use Photo Library", style: .default) { (action) in
            self.imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.imagepicker.allowsEditing = true
            self.present(self.imagepicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertcontroller.addAction(cameraAction)
        alertcontroller.addAction(photoLibraryAction)
        alertcontroller.addAction(cancelAction)
        
        present(alertcontroller, animated: true, completion: nil)
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenimage = info[UIImagePickerControllerEditedImage] as! UIImage
        bProfileImgOutlet.imageView?.contentMode = .scaleAspectFill
        bProfileImgOutlet.setBackgroundImage(chosenimage, for: .normal)
        
        dismiss(animated: true, completion: nil)
    }



//GenderPicker
public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}


public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return Genders.count
}


func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return Genders[row]
}
func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    bGenderTextField.text = Genders[row]
    bGenderTextField.resignFirstResponder()
}
    
    //DatePicker
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        bDOBTextField.inputAccessoryView = toolbar
        bDOBTextField.inputView = DOBpicker
        
        DOBpicker.datePickerMode = .date
        }

    
    @objc func donePressed() {
       //formatdate
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: DOBpicker.date)
        

        bDOBTextField.text = "\(dateString)"
        self.view.endEditing(true)
        
        
        
        

}
}




