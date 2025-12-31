//
//  PhotoCollectionViewCell.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 05/01/26.
//

import UIKit
import SDWebImage
class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifer = "PhotoCollectionViewCell"
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        accessibilityHint = "Double Tap to OPen Picture"
        accessibilityLabel = "Users Profile Picture"
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
//    public func configure(with model : PhotoPost){
//        let url = model.thumbnailImage
//        
//    }
   public func configure(with image : String){
        imageView.image = UIImage(named: image)
    }
}
