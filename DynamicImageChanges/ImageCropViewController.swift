//
//  ImageCropViewController.swift
//  DynamicImageChanges
//
//  Created by Eryus Developer on 14/09/17.
//  Copyright © 2017 Eryushion Techsol. All rights reserved.
//

import UIKit
import PhotoTweaks
class ImageCropViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIScrollViewDelegate,PhotoTweaksViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView = UIImageView()
    var image: UIImage!
    var delegate: ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Image Crop & Save"
        scrollView.delegate = self
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        imageView.image = UIImage(named: "download.jpeg")
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loadImage(recognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }

    func loadImage(recognizer: UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        imageView.image = pickedImage
//        imageView.contentMode = UIViewContentMode.center
//        imageView.frame = CGRect(x: 0, y: 0, width: pickedImage.size.width, height: pickedImage.size.height)
//        scrollView.contentSize = pickedImage.size
//        let scrollviewFrame = scrollView.frame
//        let scaleWidth = scrollviewFrame.size.width / scrollView.contentSize.width
//        let scaleHeight = scrollviewFrame.size.height / scrollView.contentSize.height
//        let minScale = min(scaleHeight,scaleWidth)
//        scrollView.minimumZoomScale = minScale
//        scrollView.maximumZoomScale = 1
//        scrollView.zoomScale = minScale
//        //rotatedimage()
//        centerScrollViewContents()
        
        let photoCrop = PhotoTweaksViewController(image: pickedImage)
        photoCrop?.delegate = self
        photoCrop?.autoSaveToLibray = false
        photoCrop?.maxRotationAngle = .pi / 4
        picker.pushViewController(photoCrop!, animated: true)
    }
    func photoTweaksController(_ controller: PhotoTweaksViewController!, didFinishWithCroppedImage croppedImage: UIImage!) {
        self.imageView.image = croppedImage
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, true, UIScreen.main.scale)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContext(imageView.bounds.size)
        UIGraphicsEndImageContext()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        delegate.ivImageView.image = image
        delegate.BottomView.isHidden = false
        delegate.vwSubView.isHidden = false
        delegate.btnSelectImage.isHidden = true
        navigationController?.popViewController(animated: true)
        controller.dismiss(animated: true, completion: nil)
       // controller.navigationController?.dismiss(animated: true, completion: nil)
    }
    func photoTweaksControllerDidCancel(_ controller: PhotoTweaksViewController!) {
        controller.dismiss(animated: true, completion: nil)
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

    @IBAction func btnCropSave(_ sender: UIButton) {
        /*UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        let offSet = scrollView.contentOffset
        UIGraphicsGetCurrentContext()?.translateBy(x: -offSet.x, y: -offSet.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContext(scrollView.bounds.size)
        UIGraphicsEndImageContext()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        let alert = UIAlertController(title:"Image Saved", message: "Your Image has been saved to your camera roll", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
        
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        let offSet = scrollView.contentOffset
        UIGraphicsGetCurrentContext()?.translateBy(x: -offSet.x, y: -offSet.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsBeginImageContext(scrollView.bounds.size)
        UIGraphicsEndImageContext()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        delegate.ivImageView.image = image
        delegate.BottomView.isHidden = false
        delegate.vwSubView.isHidden = false
        delegate.btnSelectImage.isHidden = true
        navigationController?.popViewController(animated: true)
    }
}





