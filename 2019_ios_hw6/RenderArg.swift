//
//  RenderArg.swift
//  2019_ios_hw6
//
//  Created by 王心妤 on 2019/4/1.
//  Copyright © 2019年 river. All rights reserved.
//

import Foundation
import UIKit

struct RenderArg{
    var content: String! = ""
    var pic: UIImage? = UIImage()
    var date: Date = Date()
    var alpha: Double = 0
    // style = 0 -> vertival
    // style = 1 -> horizontal
    var style: Int! = 0
    var filter: Int! = 0
    var useFilter: Bool! = false
   
}
