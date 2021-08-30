//
//  USERPOST.swift
//  SocialMedia_App_Demo
//
//  Created by Nick patel on 29/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import Foundation

class USERPOST {
    var id:Int = 0
    var name:String = ""
    var detail:String = ""
    var img:String = ""
    init(id:Int,name:String,detail:String,img:String)
    {
        self.id = id
        self.name = name
        self.detail = detail
        self.img = img
    }
    
}
