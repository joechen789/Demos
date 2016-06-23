//
//  RainforestCardCell.swift
//  Layers
//
//  Created by René Cacheaux on 9/1/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class RainforestCardCell: UICollectionViewCell {
    let featureImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionTextView = UITextView()
    let gradientView = GradientView()
    var featureImageSizeOptional: CGSize?
    var placeholderLayer = CALayer()
    var backgroundImageNode: ASImageNode?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholderLayer.contents = UIImage(named: "cardPlaceholder")?.CGImage
        placeholderLayer.contentsGravity = kCAGravityCenter
        placeholderLayer.contentsScale = UIScreen.mainScreen().scale
        placeholderLayer.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 1).CGColor
        contentView.layer.addSublayer(placeholderLayer)
    }
    
    //MARK: Layout
    override func sizeThatFits(size: CGSize) -> CGSize {
        if let featureImageSize = featureImageSizeOptional {
            return FrameCalculator.sizeThatFits(size, withImageSize: featureImageSize)
        } else {
            return CGSizeZero
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        placeholderLayer.frame = bounds
        CATransaction.commit()
    }
    
    //MARK: Cell Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: Cell Content
    func configureCellDisplayWithCardInfo(cardInfo: RainforestCardInfo) {
        //MARK: Image Size Section
        let image = UIImage(named: cardInfo.imageName)!
        featureImageSizeOptional = image.size
        
        let backgroundImageNode = ASImageNode()
        backgroundImageNode.image = image
        backgroundImageNode.contentMode = .ScaleAspectFill
        backgroundImageNode.layerBacked = true
        
        // MARK: - Node Layout Section
        backgroundImageNode.frame = FrameCalculator.frameForContainer(image.size)
        
        //MARK: - Node Layer and Wrap Up Section
        contentView.layer.addSublayer(backgroundImageNode.layer)
        self.backgroundImageNode = backgroundImageNode
    }
    
}
