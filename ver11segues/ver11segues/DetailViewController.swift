//  DetailViewController.swift
//  ver15segues
//
//  Created by Richard H Woolley on 6/15/15.
//  Copyright (c) 2015 Bright Quasar Software, R. Woolley. All rights being understood to require force to secure. 

import UIKit  // this includes Fondation 

  class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // 3 delegate are in effect in this class

  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!

  @IBOutlet weak var firstNameTextField: UITextField!   // these per protocol, are found below in viewDidLoad
  @IBOutlet weak var lastNameTextField: UITextField!

  @IBOutlet weak var cameraMissingAlert: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  // magic man
  var selectedPerson: Person!    // magically locatable via

// ------------------- end of members, funcs follow ---------------------------------------------------------------

  override func viewDidLoad() {   // fires only once when THIS view is created
    super.viewDidLoad()

    //      let url = NSURL(string: "http://prod.www.seahawks.clubs.nfl.com/assets/images/imported/SEA/articleImages/RoundUp/140515-sherman-links-600.jpg")
    //      let imageData = NSData(contentsOfURL: url!)
    //      let image = UIImage(data: imageData!)
    //      self.imageView.image = image


    self.firstNameTextField.delegate = self // .delegate = self  ...obvious references to the new outlets, while self magically finds
                                            // ... selectedPerson, a class/instance var, above.
    self.lastNameTextField.delegate = self  // .delegate = self

    self.firstNameTextField.tag = 0  // these tags will be used to differentiate, below, between the two textFields in the ...
                                     // ... textFieldDidEndEditing func
    self.lastNameTextField.tag = 1

    //self.firstNameTextField.text = self.selectedPerson.firstName  // These would overWrite placeholders
    //self.lastNameTextField.text = self.selectedPerson.lastName   //

    self.firstNameLabel.text = self.selectedPerson.firstName     // these next two insert the data from the tableView into the labels
    self.lastNameLabel.text = self.selectedPerson.lastName      // ... my trick
// just to practice using Frames (will only look correct on the iPhone6 in portrait. 
    let myUnderlieView = UIView(frame: CGRect(x:15, y: 170, width: 300, height: 25))
       myUnderlieView.backgroundColor = UIColor.yellowColor()
    self.view.addSubview(myUnderlieView)
//new for jun 17
    if selectedPerson.lastName == "Namath" {
      lastNameTextField.text = selectedPerson.lastName
    } else {
      // leave the lastNameTextField "blank" with its place-holder text
    }
  }
// -------------- end of viewDidLoad() ---------------------------------------------------------------------------

  // the next two funcs are per protocol UITextFieldDelegate, obviously, there will be a caller of these two func's who will supply
  // ... the textField arg to each of them.

  // this func merely makes the KB go away, we could survive without it, but later, when we learn to call some magic to force the selected first-responder view to be pushed up above the keyboard which it owns, we will first need to dismis KB from the prior used first responder, so as to uncover the next textField (which may be under the KB owned by the previously used textField at that point).
  func textFieldShouldReturn(textField: UITextField) -> Bool {   // textFieldShouldReturn
    textField.resignFirstResponder()                            // just turning off the textField (first responder) i.e., the textField owns the KB
    return false  // I am told that I should understans that one could have returned true and the effect would be identical
  }

  // when user hits return on soft-KB
  // based on the attached tag (done above), we set the appropriate property of "magic man"(selectedPerson) to textField.text, which
  //...is obviouly being supplied by a caller invoked by virtue of having decalred this class to conform to the aformentioned protocol
  func textFieldDidEndEditing(textField: UITextField) {
    switch textField.tag {
    case 0:
      self.selectedPerson.firstName = textField.text
      println("\(textField.text)")
      if textField.text == "Joe" || textField.text == "joe" || textField.text == "Joseph" {
        self.cameraMissingAlert.text = "Yes, his name is Joe"
      }
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

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
      self.imageView.image = image
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
  }
}
    /*   Xcode gives the following advice for free, if only Siri were so ... thoughtful:]
    In a storyboard-based application, you will often want to do a little preparation before navigation ...

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    */

