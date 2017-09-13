//
//  ViewController.swift
//  DynamicImageChanges
//
//  Created by Eryus Developer on 12/09/17.
//  Copyright © 2017 Eryushion Techsol. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var ivImageView: UIImageView!
    @IBOutlet weak var vwSubView: UIView!
    @IBOutlet weak var ivSubImageView: UIImageView!
    @IBOutlet weak var lblSubView: UILabel!
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var panGesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var btnSelectImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.vwSubView.isHidden = true
        self.BottomView.isHidden = true
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        self.vwSubView.isUserInteractionEnabled = true
        self.vwSubView.addGestureRecognizer(panGesture)
    }
    @IBAction func btnSelectImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ivImageView.contentMode = .scaleToFill
            ivImageView.image = pickedImage
            self.vwSubView.isHidden = false
            self.BottomView.isHidden = false
            self.btnSelectImage.isHidden = true
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
            }
        }
    }
    @IBAction func btnBorder(_ sender: Any) {
//        self.ivImageView.layer.borderWidth = 5
//        self.ivImageView.layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
//        self.ivImageView.layer.masksToBounds = true
        self.ivImageView.addDashedBorder()
    
    }


}

