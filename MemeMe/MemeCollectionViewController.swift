//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Najla Awadh on 11/08/1440 AH.
//  Copyright © 1440 Najla Awadh. All rights reserved.


import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes : [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView!.reloadData() }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage.image = meme.memedImage
        return cell
    }

   
//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?)
//    {
//
//    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailCV = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailCV.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailCV, animated: true)
        
    }

}
