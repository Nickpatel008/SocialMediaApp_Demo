//
//  AddPostVC.swift
//  SocialMedia_App_Demo
//
//  Created by Nick patel on 29/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate {
  
    var imgName:String?
    var sql = SqlHandler.sh
    
    private let userName:UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.placeholder = "Enter User Name..."
        txt.textAlignment = .center
        txt.borderStyle = .line
        return txt
    }()
    
    private let myImg:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "1")
        return img
    }()
    
    
    private let mybtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Select Image", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 25
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleSelectImg), for: .touchUpInside)
        return btn
    }()
    
    private let myuploadBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Upload", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 25
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleUploadBtn), for: .touchUpInside)
        return btn
    }()
    
    private let postDetails:UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.placeholder = "Enter About Your Post..."
        txt.borderStyle = .line
        txt.textAlignment = .center
        return txt
    }()
    
    private let myimgPicker:UIImagePickerController = {
        let img = UIImagePickerController()
        img.allowsEditing = false
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        view.addSubview(userName)
        view.addSubview(myImg)
        view.addSubview(postDetails)
        view.addSubview(mybtn)
        view.addSubview(myuploadBtn)
        	
        myimgPicker.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .gray
        
        userName.frame = CGRect(x: 40, y: 80, width: 300, height: 40)
        myImg.frame = CGRect(x: 80, y: userName.bottom + 20, width: 200, height: 200)
        postDetails.frame = CGRect(x: 40, y: myImg.bottom + 80, width: 300, height: 100)
        
        mybtn.frame = CGRect(x: 80, y: myImg.bottom + 20, width: 200, height: 40)
        myuploadBtn.frame = CGRect(x: 100, y: postDetails.bottom + 20, width: 150, height: 40)
        
    }
 
     @objc func handleSelectImg()
     {
        myimgPicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.myimgPicker , animated: true)
        }
     }
     @objc func handleUploadBtn()
     {
         print("Name = \(userName.text!)")
         print("Details = \(postDetails.text!)")
         print("Image Name = \(imgName!)")
         //myImg.image = imgName
        
        let index = sql.Insert_Post(not: USERPOST(id: 0, name: userName.text!, detail: postDetails.text!, img:imgName!))
        if index == 0 {
            navigationController?.popViewController(animated: true)
        }
        
        
     }
    
}

extension AddPostVC : UIDocumentPickerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            //myImg.image = selectedImage
            //imgName = selectedImage
            print(selectedImage)
            print("bbbb")
            
            let imageStringData = convertImageToBase64(image: selectedImage)
                //print("IMAGE base64 String: \(imageStringData)")
           
            myImg.image = convertBase64ToImage(imageString: imageStringData)
            
            //print(imageStringData)
            imgName = imageStringData
        }
        print("aaaa")
       
        
        myimgPicker.dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        myimgPicker.dismiss(animated: true)
    }
    

    
    
}

func convertImageToBase64(image: UIImage) -> String {
    let imageData = image.pngData()!
    return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
}

func convertBase64ToImage(imageString: String) -> UIImage {
    let imageData = Data(base64Encoded: imageString,
                         options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    return UIImage(data: imageData)!
}
