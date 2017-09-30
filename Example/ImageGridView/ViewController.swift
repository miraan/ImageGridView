//
//  ViewController.swift
//  ImageGridView
//
//  Created by miraan on 09/30/2017.
//

import UIKit
import ImageGridView

class ViewController: UIViewController {
    
    @IBOutlet weak var imageGridViewContainer: UIView!
    
    var imageGridView: ImageGridView!
    var images: [UIImage] = [#imageLiteral(resourceName: "ProfilePicture1"), #imageLiteral(resourceName: "ProfilePicture2"), #imageLiteral(resourceName: "ProfilePicture3"), #imageLiteral(resourceName: "ProfilePicture4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        self.imageGridView = ImageGridView(frame: self.imageGridViewContainer.bounds)
        self.imageGridView.delegate = self
        self.imageGridView.datasource = self
        self.imageGridViewContainer.addSubview(imageGridView)
        self.imageGridView.reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: ImageGridViewDelegate {
    
    func imageGridView(_ imageGridView: ImageGridView, didTapDeleteForImage index: Int) {
        self.images.remove(at: index)
        self.imageGridView.reload()
    }
    
    func imageGridViewDidTapAddImage(_ imageGridView: ImageGridView) {
        let images = [#imageLiteral(resourceName: "ProfilePicture1"), #imageLiteral(resourceName: "ProfilePicture2"), #imageLiteral(resourceName: "ProfilePicture3"), #imageLiteral(resourceName: "ProfilePicture4")]
        let image = images[Int(arc4random_uniform(UInt32(images.count)))]
        self.images.append(image)
        self.imageGridView.reload()
    }
    
    func imageGridView(_ imageGridView: ImageGridView, didMoveImage fromIndex: Int, toIndex: Int) {
        self.images.insert(self.images.remove(at: fromIndex), at: min(toIndex, self.images.count))
        self.imageGridView.reload()
    }
    
}

extension ViewController: ImageGridViewDatasource {
    
    func imageGridViewImages(_ imageGridView: ImageGridView) -> [UIImage] {
        return self.images
    }
    
}
