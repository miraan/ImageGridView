//
//  ImageGridView.swift
//  ImageGridView
//
//  Created by Miraan on 30/09/2017.
//  Copyright © 2017 Miraan. All rights reserved.
//

import UIKit

protocol ImageGridViewDelegate {
    func imageGridViewSize(_ imageGridView: ImageGridView) -> Int // The length of the grid, so the capacity will be the square of this number
    func imageGridView(_ imageGridView: ImageGridView, didTapDeleteForImage index: Int)
    func imageGridViewDidTapAddImage(_ imageGridView: ImageGridView)
    func imageGridView(_ imageGridView: ImageGridView, didMoveImage fromIndex: Int, toIndex: Int)
}

protocol ImageGridViewDatasource {
    func imageGridViewImages(_ imageGridView: ImageGridView) -> [UIImage]
}

class ImageGridView: UIView {
    
    let itemPadding: CGFloat = 10.0
    var overlapThreshold: CGFloat = 0.0
    
    var delegate: ImageGridViewDelegate!
    var datasource: ImageGridViewDatasource!
    
    var itemViews: [ImageGridItemView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        if frame.size.width != frame.size.height {
            print("ImageGridView:init(frame:) error: Width and height are not the same")
        }
        self.backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload() {
        if delegate == nil {
            print("ImageGridView:reload() error: No delegate")
            return
        }
        if datasource == nil {
            print("ImageGridView:reload() error: No datasource")
        }
        for itemView in self.itemViews {
            itemView.removeFromSuperview()
        }
        self.itemViews = []
        let size = delegate.imageGridViewSize(self)
        let images = datasource.imageGridViewImages(self)
        if images.count > size * size {
            print("ImageGridView:reload() error: Have \(images.count) images but capacity is only \(size * size)")
        }
        let totalPadding = CGFloat(size + 1) * itemPadding
        let itemSize = (frame.size.width - totalPadding) / CGFloat(size)
        self.overlapThreshold = itemSize / 2
        for row in 0...size-1 {
            for col in 0...size-1 {
                let x = (CGFloat(col) * itemSize) + (CGFloat(col + 1) * itemPadding)
                let y = (CGFloat(row) * itemSize) + (CGFloat(row + 1) * itemPadding)
                let itemView = ImageGridItemView(frame: CGRect(x: x, y: y, width: itemSize, height: itemSize))
                let index = (row * size) + col
                itemView.index = index
                itemView.delegate = self
                itemView.datasource = self
                self.itemViews.append(itemView)
                self.addSubview(itemView)
                itemView.reload()
            }
        }
    }
    
}

extension ImageGridView: ImageGridItemViewDelegate {
    
    func imageGridItemViewDidStartDragging(_ imageGridItemView: ImageGridItemView) {
        self.bringSubview(toFront: imageGridItemView)
        imageGridItemView.lastLocation = imageGridItemView.center
    }
    
    func imageGridItemView(_ imageGridItemView: ImageGridItemView, didDragBy translation: CGPoint) {
        imageGridItemView.center = CGPoint(x: imageGridItemView.lastLocation.x + translation.x, y: imageGridItemView.lastLocation.y + translation.y)
    }
    
    func imageGridItemViewDidEndDragging(_ imageGridItemView: ImageGridItemView) {
        for itemView in self.itemViews {
            if itemView != imageGridItemView {
                if let overlapRect = getOverlapRect(itemA: itemView, itemB: imageGridItemView) {
                    if overlapRect.width > self.overlapThreshold && overlapRect.height > self.overlapThreshold {
                        delegate.imageGridView(self, didMoveImage: imageGridItemView.index, toIndex: itemView.index)
                        return
                    }
                }
            }
        }
        
        imageGridItemView.center = imageGridItemView.lastLocation
    }
    
    func imageGridItemViewDidTapDelete(_ imageGridItemView: ImageGridItemView) {
        delegate.imageGridView(self, didTapDeleteForImage: imageGridItemView.index)
    }
    
    func imageGridItemViewDidTapAddImage(_ imageGridItemView: ImageGridItemView) {
        delegate.imageGridViewDidTapAddImage(self)
    }
    
    func getOverlapRect(itemA: ImageGridItemView, itemB: ImageGridItemView) -> CGRect? {
        let topLeftX = max(itemA.frame.minX, itemB.frame.minX)
        let topLeftY = max(itemA.frame.minY, itemB.frame.minY)
        let bottomRightX = min(itemA.frame.maxX, itemB.frame.maxX)
        let bottomRightY = min(itemA.frame.maxY, itemB.frame.maxY)
        
        if topLeftX > bottomRightX || topLeftY > bottomRightY {
            return nil // No overlap
        }
        
        return CGRect(x: topLeftX, y: topLeftY, width: bottomRightX - topLeftX, height: bottomRightY - topLeftY)
    }
    
}

extension ImageGridView: ImageGridItemViewDatasource {
    
    func imageGridItemViewImage(_ imageGridItemView: ImageGridItemView) -> UIImage? {
        let images = self.datasource.imageGridViewImages(self)
        guard let index = imageGridItemView.index else {
            print("ImageGridView:imageGridItemViewImage() error: imageGridItemView.index is nil")
            return nil
        }
        return index < images.count ? images[index] : nil
    }
    
}
