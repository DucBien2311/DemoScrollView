//
//  ViewScroll.swift
//  DemoScrollView
//
//  Created by NguyenDucBien on 1/9/17.
//  Copyright © 2017 NguyenDucBien. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var sldZoom: UISlider!
    
    var photo = UIImageView()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        let imgView = UIImageView(image: UIImage(named: "shop1-0.jpg"))
        imgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
        imgView.contentMode = .ScaleAspectFit
        imgView.userInteractionEnabled = true
        imgView.multipleTouchEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.tapImg(_:)))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.doubleTapImg(_:)))
        doubleTap.numberOfTapsRequired = 2
        tap.requireGestureRecognizerToFail(doubleTap)
        imgView.addGestureRecognizer(doubleTap)
        
        
        
        
        photo = imgView
        scrollView.contentSize = CGSizeMake(imgView.bounds.width, imgView.bounds.height)
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        self.scrollView.addSubview(imgView)
        
    }
    
    func tapImg(gesture: UITapGestureRecognizer) {
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    
    func doubleTapImg(gesture: UITapGestureRecognizer) {
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        print(zoomRect)
        scrollView.zoomToRect(zoomRect, animated: true)
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo
    }
    
    
    @IBAction func sldZoom(sender: UISlider) {
        scrollView.setZoomScale(CGFloat(sender.value), animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
