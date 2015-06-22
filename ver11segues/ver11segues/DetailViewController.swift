//  DetailViewController.swift
//  ver15segues
//
//  Created by Richard H Woolley on 6/15/15.
//  Copyright (c) 2015 Bright Quasar Software, R. Woolley. All rights being understood to require force to secure. 
//  this will be my HomeWork project

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var cameraMissingAlert: UILabel!

  var selectedPerson: Person!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.firstNameTextField.delegate = self
    self.lastNameTextField.delegate = self
    self.firstNameTextField.tag = 0
    self.lastNameTextField.tag = 1
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }

  func textFieldDidEndEditing(textField: UITextField) {
    switch textField.tag {
    case 0:
      self.selectedPerson.firstName = textField.text
    case 1:
      self.selectedPerson.lastName = textField.text
    default:
      break
    }
  }

  @IBAction func photoButtonPressed(sender: AnyObject) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
      imagePickerController.allowsEditing = true
      self.presentViewController(imagePickerController, animated: true, completion: nil)
    } else {
      // Warn the user of the missing camera in both the sim and the really-old-iPod-touch
      self.cameraMissingAlert.text = "No camera found"
    }
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    // so, what may one want to put in here, anyway?
    // perhaps provide for persistance of the photo taken?
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
      self.imageView.image = image
      selectedPerson.image = image 
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
  }

}

