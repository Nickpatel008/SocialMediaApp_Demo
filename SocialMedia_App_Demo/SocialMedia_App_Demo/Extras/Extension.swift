//
//  Extension.swift
//  SocialMedia_App_Demo
//
//  Created by Nick patel on 29/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public var height:CGFloat { return frame.size.height }
    public var width:CGFloat { return frame.size.width }
    public var top:CGFloat { return frame.origin.y }
    public var left:CGFloat { return frame.origin.x }
    public var bottom:CGFloat { return frame.origin.y + height }
    public var right:CGFloat { return frame.origin.x + width }
    
}
