//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Najla Awadh on 12/08/1440 AH.
//  Copyright © 1440 Najla Awadh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.label.text = self.meme.name
//        self.imageView!.image = UIImage(named: meme.imageName)
    }

}
