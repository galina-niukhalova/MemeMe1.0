//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Galina Niukhalova on 9/1/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var shareImageButton: UIBarButtonItem!
    
    let topTextFieldDefaultText = "TOP"
    let bottomTextFieldDefaultText = "BOTTOM"
    let memeTextCSSAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -3
    ]
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    // MARK: Controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMemeTextAttributes(textField: topTextField, defaultText: topTextFieldDefaultText)
        setMemeTextAttributes(textField: bottomTextField, defaultText: bottomTextFieldDefaultText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Disable toolbar camera btn when camera is not supported on a device
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // Disable share image btn, if image is not selected 
        shareImageButton.isEnabled = imagePickerView.image != nil
        
        // Subscribe to the keyboard notifications, to allow the view to raise when necessary
        subscribeToKeyboardNotifications()
        
        // Status bar to a dark mode
        view.backgroundColor = .label
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    func setMemeTextAttributes(textField: UITextField, defaultText: String) {
        textField.text = defaultText
        textField.delegate = self
        textField.defaultTextAttributes = memeTextCSSAttributes
        textField.textAlignment = .center
    }

    // MARK: Display gallery or camera popup
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        pickImage()
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickImage(sourceType: .camera)
    }
    
    func pickImage(sourceType: UIImagePickerController.SourceType? = nil) {
        // Display gallery or camera
        let controller = UIImagePickerController()
        controller.delegate = self
        if let sourceType = sourceType {
            controller.sourceType = sourceType
        }
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Display selected image in the UIImageView
        guard let image = info[.originalImage] as? UIImage else { return }
        imagePickerView.image = image
        
        shareImageButton.isEnabled = true
        
        dismiss(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Clear default text when a user start typing
        if textField == topTextField && textField.text == topTextFieldDefaultText {
            textField.text = ""
        }
        
        if textField == bottomTextField && textField.text == bottomTextFieldDefaultText {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide a keyboard on click Enter
        textField.resignFirstResponder()
        
        return true
    }
    
    // Mark: Keyboard notifications
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func showBarElements(_ isShown: Bool) {
        toolbar.isHidden = !isShown
        navBar.isHidden = !isShown
    }
    
    // MARK: Memed image
    
    func generateMemedImage() -> UIImage {
        showBarElements(false)
        
        // Render view to an image
        UIGraphicsBeginImageContextWithOptions(view.frame.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        showBarElements(true)
        
        return memedImage
    }
    
    func saveMeme(_ memedImage: UIImage) -> Meme {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        return meme
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let memedImage = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(controller, animated: true)
        
        controller.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print(self.saveMeme(memedImage))
            }
        }
    }
    
    // Return Meme Editor to its launch state
    @IBAction func resetMemeEditor(_ sender: Any) {
        topTextField.text = topTextFieldDefaultText
        bottomTextField.text = bottomTextFieldDefaultText
        imagePickerView.image = nil
    }
    
    // Status bar to a dark mode
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

