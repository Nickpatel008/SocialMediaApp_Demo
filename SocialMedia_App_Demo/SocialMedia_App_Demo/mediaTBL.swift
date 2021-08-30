//
//  mediaTBL.swift
//  SocialMedia_App_Demo
//
//  Created by Nick patel on 29/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import UIKit

class mediaTBL: UITableViewCell {

    private let myview:UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 25
        return view
    }()
    
    private let userName:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let details:UILabel = {
        let label = UILabel()
        label.text = "Just Now"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let myImg:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private let desc:UILabel = {
        let label = UILabel()
        label.text = "post is good... pkapp mkdalia nkxkxns"
        label.numberOfLines = 3
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    private let commenttxt:UITextField = {
       let txt = UITextField()
        txt.placeholder = "Add Commnet"
        txt.textAlignment = .center
        txt.backgroundColor = .gray
        txt.layer.cornerRadius = 10
        return txt
    }()
    
    func mySocialMediaSetup(title name:String , img:String , desc1:String)
    {
        userName.text = name
        //myImg.image = UIImage(named: img)
        myImg.image = convertBase64ToImage(imageString: img)
        desc.text = desc1
        setupUi()
    }
    
    private func setupUi()
    {
        contentView.addSubview(myview)
        contentView.addSubview(userName)
        contentView.addSubview(details)
        contentView.addSubview(myImg)
        contentView.addSubview(desc)
        contentView.addSubview(commenttxt)
        
        myview.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        userName.frame = CGRect(x: myview.right + 10, y: 8, width: 300, height: 40)
        details.frame = CGRect(x: myview.right + 10, y: userName.bottom - 20, width: 300, height: 40)
        myImg.frame = CGRect(x: 20, y: details.bottom + 10, width: 320, height: 200)
        desc.frame = CGRect(x: 20, y: myImg.bottom + 10, width: contentView.width - 40, height: 50)
        
        commenttxt.frame = CGRect(x: 10, y: desc.bottom + 5, width: contentView.width - 20, height: 50)
        
    }
    
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString,
                             options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
}
