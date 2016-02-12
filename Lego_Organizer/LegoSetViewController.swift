//
//  LegoSetViewController.swift
//  Lego_Organizer
//
//  Created by Jason Shultz on 12/13/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Alamofire

class LegoSetViewController: UIViewController {
    
    let realm = try! Realm()
    
    var profile:Profile? = nil
    
    var apiKey:String = ""
    
    var userSets:NSArray = []
    
    var activeSet = -1
    
    var legoSet:Set? = nil
    

    @IBOutlet weak var setNumberLabel: UILabel!
    
    @IBOutlet weak var setNameLabel: UILabel!
    
    @IBOutlet weak var setDescriptionLabel: UILabel!
    
    @IBOutlet weak var setImage: UIImageView!
        
    var setId:JSON = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        setupUI()
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func setupUI() {
        
        self.view?.backgroundColor = UIColor.orangeColor()
        self.setNameLabel.textColor = UIColor.whiteColor()
        self.setDescriptionLabel.textColor = UIColor.whiteColor()
        
        
        self.title = (self.legoSet?.set_id)! + " " + (self.legoSet?.descr)!
        
        self.setNameLabel.text = (self.legoSet?.set_id)! + " " +  (self.legoSet?.descr)!
        
        let pieces:String = (self.legoSet?.pieces)!
        
        let year:String = (self.legoSet?.year)!
        
        self.setDescriptionLabel.text = "Set consists of \(pieces) pieces and was first produced in \(year). "
        
        let imageView = self.setImage as UIImageView
        
        let img_url:String = (self.legoSet?.img_sm)!
        
        imageView.contentMode = .ScaleAspectFit
        
        if let checkedUrl = NSURL(string: "\(img_url)") {
//            downloadImage(checkedUrl)
            imageView.contentMode = .ScaleAspectFit
            
            self.getDataFromUrl(checkedUrl) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }

                    imageView.image = UIImage(data: data)
                }
            }
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "newPlace" {
            
        } else if segue.identifier == "showSetsPartsList" {
            
            let PartsController:SetsPartsListTableViewController = segue.destinationViewController as! SetsPartsListTableViewController
                        
            let setId = self.legoSet
            
            PartsController.legoSet = setId
        }
        
    }


}
