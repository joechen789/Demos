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
    let gradientView = GradientNode()
    var featureImageSizeOptional: CGSize?
    var placeholderLayer = CALayer()
    // 不能直接在这个属性上设置 layerBacked 会 Crash
    //    var backgroundImageNode: ASImageNode?
    var containerNode: ASDisplayNode?
    var contentLayer: CALayer?
    var nodeConstructionOperation: NSOperation?
    
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
        
        if let operation = nodeConstructionOperation {
            operation.cancel()
        }
        //        backgroundImageNode?.preventOrCancelDisplay = true
        containerNode?.recursiveSetPreventOrCancelDisplay(true)
        contentLayer?.removeFromSuperlayer()
        
        contentLayer = nil
        //        backgroundImageNode = nil
        containerNode = nil
    }
    
    func nodeConstructionOperationWithCardInfo(cardInfo: RainforestCardInfo, image: UIImage) -> NSOperation {
        let nodeConstructionOperation = NSBlockOperation()
        nodeConstructionOperation.addExecutionBlock {
            [weak self, unowned nodeConstructionOperation] in
            if nodeConstructionOperation.cancelled {
                return
            }
            if let strongSelf = self {
                
                let backgroundImageNode = ASImageNode()
                backgroundImageNode.image = image
                backgroundImageNode.contentMode = .ScaleAspectFill
                backgroundImageNode.layerBacked = true
                
                backgroundImageNode.imageModificationBlock = {
                    input in
                    if input == nil {
                        return input
                    }
                    
                    if let blurredImage = input.applyBlurWithRadius(30, tintColor: UIColor(white:0.5, alpha: 0.3), saturationDeltaFactor: 1.8, maskImage: nil, didCancel: {
                        return false
                    }) {
                        return blurredImage
                    } else {
                        return image
                    }
                }
                
                //MARK: - Container Node Creation Section
//                let containerNode = ASDisplayNode()
                let containerNode = ASDisplayNode(layerClass: AnimatedContentsDisplayLayer.self)
                containerNode.layerBacked = true
                containerNode.shouldRasterizeDescendants = true
                containerNode.borderColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 0.2).CGColor
                containerNode.borderWidth = 1
                containerNode.addSubnode(backgroundImageNode)
                
                let featureImageNode = ASImageNode()
                featureImageNode.layerBacked = true
                featureImageNode.contentMode = .ScaleAspectFit
                featureImageNode.image = image
                containerNode.addSubnode(featureImageNode)
                
                let titleTextNode = ASTextNode()
                titleTextNode.layerBacked = true
                titleTextNode.backgroundColor = UIColor.clearColor()
                titleTextNode.attributedString = NSAttributedString.attributedStringForTitleText(cardInfo.name)
                containerNode.addSubnode(titleTextNode)
                
                let descriptionTextNode = ASTextNode()
                descriptionTextNode.layerBacked = true
                descriptionTextNode.backgroundColor = UIColor.clearColor()
                descriptionTextNode.attributedString =
                    NSAttributedString.attributedStringForDescriptionText(cardInfo.description)
                containerNode.addSubnode(descriptionTextNode)
                
                let gradientNode = GradientNode()
                gradientNode.opaque = false
                gradientNode.layerBacked = true
                containerNode.addSubnode(gradientNode)
                
                // MARK: - Node Layout Section
                containerNode.frame = FrameCalculator.frameForContainer(image.size)
                backgroundImageNode.frame = FrameCalculator.frameForBackgroundImage(containerNode.bounds)
                featureImageNode.frame = FrameCalculator.frameForFeatureImage(image.size, containerFrameWidth: containerNode.frame.size.width)
                titleTextNode.frame = FrameCalculator.frameForTitleText(containerNode.bounds, featureImageFrame: featureImageNode.frame)
                descriptionTextNode.frame = FrameCalculator.frameForDescriptionText(containerNode.bounds, featureImageFrame: featureImageNode.frame)
                gradientNode.frame = FrameCalculator.frameForGradient(featureImageNode.frame)
                
                //MARK: - Node Layer and Wrap Up Section
                //        contentView.layer.addSublayer(backgroundImageNode.layer)
//                strongSelf.contentView.layer.addSublayer(containerNode.layer)
                //        self.backgroundImageNode = backgroundImageNode
                //        contentLayer = backgroundImageNode.layer
//                strongSelf.contentLayer = containerNode.layer
//                strongSelf.containerNode = containerNode
                
                // 1
                dispatch_async(dispatch_get_main_queue()) { [weak nodeConstructionOperation] in
                    if let strongNodeConstructionOperation = nodeConstructionOperation {
                        // 2
                        if strongNodeConstructionOperation.cancelled {
                            return
                        }
                        
                        // 3
                        if strongSelf.nodeConstructionOperation !== strongNodeConstructionOperation {
                            return
                        }
                        
                        // 4
                        if containerNode.preventOrCancelDisplay {
                            return
                        }
                        
                        // 5
                        //MARK: Node Layer and Wrap Up Section
                        strongSelf.contentView.layer.addSublayer(containerNode.layer)
                        containerNode.setNeedsDisplay()
                        strongSelf.contentLayer = containerNode.layer
                        strongSelf.containerNode = containerNode
                    }
                }
                
//                containerNode.setNeedsDisplay()
            }
        }
        return nodeConstructionOperation
    }
    
    //MARK: Cell Content
    func configureCellDisplayWithCardInfo(
        cardInfo: RainforestCardInfo,
        nodeConstructionQueue: NSOperationQueue) {
        //MARK: Image Size Section
        let image = UIImage(named: cardInfo.imageName)!
        featureImageSizeOptional = image.size
        
        let newNodeConstructionOperation = nodeConstructionOperationWithCardInfo(cardInfo, image: image)
        nodeConstructionOperation = newNodeConstructionOperation
        nodeConstructionQueue.addOperation(newNodeConstructionOperation)
    }
}
