//
//  ViewController.swift
//  MemeMe
//
//  Created by Najla Awadh on 05/08/1440 AH.
//  Copyright © 1440 Najla Awadh. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate,UITextFieldDelegate{
//Outlet

    @IBOutlet weak var bottomToolbar: UIToolbar!
    //@IBOutlet  var bottomToolbar: UIToolbar!
    @IBOutlet weak var action: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet var cameraButton : UIBarButtonItem!
    @IBOutlet var topText : UITextField!
    @IBOutlet var bottomText : UITextField!
    
    //let
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: Float(-4) ]
    
    let memedImage : UIImage! = nil
    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    memes = appDelegate.memes
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //init TextField
        setStyle(toTextField: topText)
        setStyle(toTextField: bottomText)
        //cameraButton
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        //share button
        action.isEnabled = false
    }
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    func setStyle(toTextField textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    //When a user presses return, the keyboard should be dismissed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
      
    }
    //
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //
    @objc func keyboardWillShow(_ notification:Notification) {
        if (bottomText.isEditing){
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    //
    @objc func keyboardWillHide (_ notification:Notification){
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0}
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        }
    
    func imagePickerController(_ picker :UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
            action.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
  
    //The action method for the camera & album
     func openImagePicker(_ type: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
       picker.delegate = self
        picker.sourceType = type
         present(picker, animated: true, completion: nil)
        
    }
    
    func save() {
        // Create the meme
      let meme = Meme(top: topText.text!, bottom: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        // Add it to the memes array on the application Delegate
       // (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        //
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    func generateMemedImage() -> UIImage {
        
        //Hide toolbar and navbar
        
        hideToolbars(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show toolbar and navbar
    
        hideToolbars(false)
        
        return memedImage
    }
    
    func hideToolbars(_ hide: Bool) {
      
        bottomToolbar.isHidden = hide
    }
    
    @IBAction func action(_ sender: Any) {
      
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller , animated: true , completion: nil)
        controller.completionWithItemsHandler = {(_, completed, _, _) in
       if (completed){
        self.save()
        }

    //Dismiss the shareActivityViewController
    self.dismiss(animated: true, completion: nil)
    }
    
    }
}

