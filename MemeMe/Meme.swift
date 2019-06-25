//
//  Meme.swift
//  MemeMe
//
//  Created by Najla Awadh on 05/08/1440 AH.
//  Copyright © 1440 Najla Awadh. All rights reserved.
//

import Foundation
import UIKit
struct Meme {
    var top : String!
    var bottom : String!
    var originalImage : UIImage!
    var  memedImage : UIImage!

    init(top:String ,bottom : String,originalImage :UIImage , memedImage : UIImage ) {
    self.top = top
        self.bottom = bottom
        self.originalImage = originalImage
        self.memedImage = memedImage
}
    
}
