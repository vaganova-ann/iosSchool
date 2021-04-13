//
//  PhotosCell.swift
//  School
//
//  Created by Anna Vaganova on 4/6/21.
//

import UIKit

class PhotosCell: UITableViewCell {
    
    @IBOutlet private var roundImageView: UIImageView!
    @IBOutlet private var bigImageView: UIImageView!
    @IBOutlet private var colorView: UIView!
    
    func createPhotosCell(userData: ProfileData) -> UITableViewCell {
        
        roundImageView.layer.cornerRadius = 138.0/2.0
        roundImageView.clipsToBounds = true
        
        if let userPhoto = userData.photo {
            roundImageView.image = userPhoto
            roundImageView.contentMode = .scaleAspectFill
            
            bigImageView.contentMode = .scaleAspectFill
            bigImageView.image = userPhoto
        } else {
            roundImageView.image = UIImage(named: "bigMan")
        }
        
        if let userColor = userData.color{
            colorView.alpha = 0.4
            colorView.backgroundColor = UIColor(red: CGFloat(userColor.red), green: CGFloat(userColor.green), blue: CGFloat(userColor.blue), alpha: 1)
        }
        else {
            colorView.alpha = 0
        }
        return self
    }
    
}
