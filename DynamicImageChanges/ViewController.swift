//
//  ViewController.swift
//  DynamicImageChanges
//
//  Created by Eryus Developer on 12/09/17.
//  Copyright © 2017 Eryushion Techsol. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivImageView: UIImageView!
    @IBOutlet weak var vwSubView: UIView!
    @IBOutlet weak var ivSubImageView: UIImageView!
    @IBOutlet weak var lblSubView: UILabel!
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var panGesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var btnSelectImage: UIButton!
    
    var imageView = UIImageView()
    var subView = UIView()
    var subRect: CGRect!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        scrollView.addSubview(imageView)
        scrollView.addSubview(subView)
        imagePicker.delegate = self
        self.vwSubView.isHidden = true
        self.BottomView.isHidden = true
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        self.vwSubView.isUserInteractionEnabled = true
        self.vwSubView.addGestureRecognizer(panGesture)
        //imageView.addSubview(vwSubView)
    }
    @IBAction func btnSelectImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = pickedImage
        imageView.contentMode = UIViewContentMode.scaleToFill
        imageView.frame = CGRect(x: 0, y: 0, width: pickedImage.size.width, height: pickedImage.size.height)
        
        scrollView.contentSize = pickedImage.size
        
        let scrollviewFrame = scrollView.frame
        let scaleWidth = scrollviewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollviewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleHeight,scaleWidth)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1
        scrollView.zoomScale = minScale
        centerScrollViewContents()
        
        
        self.vwSubView.isHidden = false
        self.BottomView.isHidden = false
        self.btnSelectImage.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
        }else {
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2
        }else {
            contentsFrame.origin.y = 0
        }
        imageView.frame = contentsFrame
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func draggedView(_ sender:UIPanGestureRecognizer){
        if sender.state == .began || sender.state == .changed || sender.state == .ended {
            var rec: CGRect = (sender.view?.frame)!
            let imgvw = self.ivImageView.frame
            if ((rec.origin.x >= imgvw.origin.x && rec.origin.y >= imgvw.origin.y && (rec.origin.x + rec.size.width <= imgvw.origin.x + imgvw.size.width) && (rec.origin.y + rec.size.height <= imgvw.origin.y + imgvw.size.height))){
                let translation = sender.translation(in: self.ivImageView)
                vwSubView.center = CGPoint(x: (sender.view?.center.x)! + translation.x, y: (sender.view?.center.y)! + translation.y)
                rec = (sender.view?.frame)!
                if (rec.origin.x < imgvw.origin.x){
                    rec.origin.x = imgvw.origin.x
                }
                if (rec.origin.y < imgvw.origin.y){
                    rec.origin.y = imgvw.origin.y
                }
                if (rec.origin.x + rec.size.width > imgvw.origin.x + imgvw.size.width) {
                    rec.origin.x = imgvw.origin.x + imgvw.size.width - rec.size.width
                }
                if (rec.origin.y + rec.size.height > imgvw.origin.y + imgvw.size.height) {
                    rec.origin.y = imgvw.origin.y + imgvw.size.height - rec.size.height
                }
                sender.view?.frame = rec
                sender.setTranslation(CGPoint.zero, in: self.ivImageView)
                subRect = rec

            }
        }
    }
    @IBAction func btnBorder(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        let offSet = scrollView.contentOffset
        UIGraphicsGetCurrentContext()?.translateBy(x: -offSet.x, y: -offSet.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContext(scrollView.bounds.size)
        UIGraphicsEndImageContext()
        self.scrollView.addDashedBorder()
    }

    @IBAction func btnDotted(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        let offSet = scrollView.contentOffset
        UIGraphicsGetCurrentContext()?.translateBy(x: -offSet.x, y: -offSet.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContext(scrollView.bounds.size)
        UIGraphicsEndImageContext()
       self.scrollView.addDottedBorder()
    }

    @IBAction func btnSimple(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        let offSet = scrollView.contentOffset
        UIGraphicsGetCurrentContext()?.translateBy(x: -offSet.x, y: -offSet.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContext(scrollView.bounds.size)
        UIGraphicsEndImageContext()
        self.scrollView.layer.borderWidth = 5
        self.scrollView.layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
        self.scrollView.layer.masksToBounds = true
    }
    @IBAction func btnSave(_ sender: UIButton) {
       
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        subView.frame = subRect
        subView.addSubview(vwSubView)
        imageView.addSubview(subView)
        let offSet = scrollView.contentOffset
        UIGraphicsGetCurrentContext()?.translateBy(x: -offSet.x, y: -offSet.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContext(scrollView.bounds.size)
        UIGraphicsEndImageContext()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        let alert = UIAlertController(title:"Image Saved", message: "Your Image has been saved to your camera roll", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

