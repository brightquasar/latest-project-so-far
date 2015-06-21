//  File.swift
//  ver15segues
//
//  Created by Richard H Woolley on 6/13/15.
//  Copyright (c) 2015 Bright Quasar Software, R. Woolley. All rights being understood to require force to secure. 

import UIKit

class Person {  // here we see that the name of the "file" in our bundle has no effect

  //var firstName: String?  // this optional would allow persons to not have a first name

  var firstName: String

  var lastName: String

  var image: UIImage?

  //let errorCondition:


  init (firstName: String, lastName: String) {

    self.firstName = firstName

    self.lastName = lastName

    //self.image = image  // only needed to make the member an optional, then no init arg is needed. 
    
  }
  
}
