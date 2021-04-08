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
    
    func createPhotosCell(userData: ProfileData) -> UITableViewCell {
        
        roundImageView.layer.cornerRadius = 138.0/2.0
        roundImageView.clipsToBounds = true
        
        if let userPhoto = userData.photo {
            roundImageView.image = UIImage(named: userPhoto)
            bigImageView.image = UIImage(named: userPhoto)
        }
        else {
            roundImageView.image = UIImage(named: "bigMan")
        }
        
        
        
        return self
    }
    
}
