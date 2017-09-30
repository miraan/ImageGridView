//
//  ImageGridItemView.swift
//  ImageGridView
//
//  Created by Miraan on 30/09/2017.
//  Copyright © 2017 Miraan. All rights reserved.
//

import UIKit

protocol ImageGridItemViewDelegate {
    func imageGridItemViewDidTapDelete(_ imageGridItemView: ImageGridItemView)
    func imageGridItemViewDidTapAddImage(_ imageGridItemView: ImageGridItemView)
    func imageGridItemViewDidStartDragging(_ imageGridItemView: ImageGridItemView)
    func imageGridItemView(_ imageGridItemView: ImageGridItemView, didDragBy translation: CGPoint)
    func imageGridItemViewDidEndDragging(_ imageGridItemView: ImageGridItemView)
}

protocol ImageGridItemViewDatasource {
    func imageGridItemViewImage(_ imageGridItemView: ImageGridItemView) -> UIImage?
}

class ImageGridItemView: UIView {
    
    var lastLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    var delegate: ImageGridItemViewDelegate!
    var datasource: ImageGridItemViewDatasource!
    var index: Int!
    
    private var imageView: UIImageView!
    private var buttonImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ImageGridItemView.detectPan(recognizer:)))
        self.gestureRecognizers = [panRecognizer]
        self.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer) {
        if delegate == nil {
            print("ImageGridItemView:detectPan() error: No delegate")
            return
        }
        
        if recognizer.state == UIGestureRecognizerState.began {
            self.delegate.imageGridItemViewDidStartDragging(self)
            return
        }
        
        if recognizer.state == UIGestureRecognizerState.ended {
            self.delegate.imageGridItemViewDidEndDragging(self)
            return
        }
        
        let translation = recognizer.translation(in: self.superview!)
        self.delegate.imageGridItemView(self, didDragBy: translation)
    }
    
    func reload() {
        if delegate == nil {
            print("ImageGridItemView:reload() error: delegate is nil")
            return
        }
        if datasource == nil {
            print("ImageGridItemView:reload() error: datasource is nil")
            return
        }
        if self.imageView != nil {
            self.imageView.removeFromSuperview()
            self.imageView = nil
        }
        self.imageView = UIImageView(frame: self.bounds)
        self.imageView.image = datasource.imageGridItemViewImage(self)
        self.imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView.clipsToBounds = true
        self.addSubview(self.imageView)
    }
    
}
