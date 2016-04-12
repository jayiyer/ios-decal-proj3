//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by Jay Iyer on 4/11/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo: Photo!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeMagic()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let url = NSURL(string: photo.url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            (data, response, error) -> Void in
            if error == nil {
                let img = UIImage(data: data!)
                imageView.image = img
            }
        })
        task.resume()
    }
    
    func makeMagic() {
        photoImageView.image = UIImage(named: "loading.png")
        loadImageForCell(self.photo, imageView: photoImageView)
        usernameLabel.text = self.photo.username
        likesLabel.text = "\(self.photo.likes) Likes"
        dateLabel.text = self.photo.date
        
    }
    
    @IBAction func likePressed(sender: AnyObject) {
        let titleText = likeButton.currentTitle! as String
        var newText : String
        var netGain = 0
        /*switch (titleText) {
        case "💔":
            newText = "❤️"
            netGain = 1
            break
        case "❤️":
            newText = "💔"
            netGain = -1
            break
        default: return
        }*/
        
        if titleText == "💔" {
            newText = "❤️"
            netGain = 1
        } else if titleText == "❤️" {
            newText = "💔"
            netGain = -1
        } else {
            return
        }
        photo.likes = photo.likes + netGain
        likesLabel.text! = "\(photo.likes) Likes"
        likeButton.setTitle(newText, forState: UIControlState.Normal)
    }
}
