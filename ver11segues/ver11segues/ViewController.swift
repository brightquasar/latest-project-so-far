//  ViewController.swift
//  ver15segues
//
//  Created by Richard H Woolley on 6/15/15.
//  Copyright (c) 2015 Bright Quasar Software, R. Woolley. All rights being understood to require force to secure. 
//  this will be my HomeWork project

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  var people = [Person]()
  var myInfo = [String: Person]()
  var cell = UITableViewCell()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self

    let russell = Person(first: "Russell", last: "Wilson")
    let richard = Person(first: "Richard", last: "Sherman")
    people.append(russell)
    people.append(richard)

    myInfo["bff"] = russell
    myInfo["buddy"] = richard
  }

  // The following func reloads the table view with the data entered in DetailViewController, it is magic.
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()    // parens needed because reloadData is ... what? A func NOT in the class tableView?

    /*  This exact code works in my proj, but does not work in this one ????????????????????????????????????????????????????
    // I want to do this in a more ... efficient way ... And, how it works is explaied below.

    let indexPathToReload = NSIndexPath(forItem: 0, inSection: 0)  // option-clicking on NSIndexPath informs us that: ...
    // ... The NSIndexPath class represents the path to a specific node in a tree of nested array collections. This path is known as an index path. Each index in an index path represents the index into an array of children from one node in the tree to another, deeper, node.

    let indexPaths = [indexPathToReload]  // so [indexPathToReload] is one of those, aforementioned, bits of indexPath magic.
    tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
    */

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.people.count
  }

  // It seems that we cannot get-away with putting optional binding on the cell= line; any such tricks result in cell being
  // unresolved, or the func not returning anything, or, if cell is defined outside of the func : var cell = UITableViewCell()
  // it breaks the tableView, so, this as! will have to stay! as is (all puns intended)
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
      let personToDisplay = self.people[indexPath.row]
      if let image = personToDisplay.image {    // With optional binding
        cell.imageView?.image = image          // and, optional chaining
      }
      cell.textLabel?.text = personToDisplay.firstName + " " + personToDisplay.lastName  // optional chaining, again
      return cell
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowDetailViewController" {
      if let detailViewController = segue.destinationViewController as? DetailViewController {
        let myIndexPath = self.tableView.indexPathForSelectedRow()
        if let indexPath = self.tableView.indexPathForSelectedRow() {
          let selectedRow = indexPath.row
          let selectedPerson = self.people[selectedRow]
          detailViewController.selectedPerson = selectedPerson
        }
        
      }
    }
  }
}


