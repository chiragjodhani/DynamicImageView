//
//  ViewController.swift
//  DynamicImageChanges
//
//  Created by Eryus Developer on 12/09/17.
//  Copyright © 2017 Eryushion Techsol. All rights reserved.
//

import UIKit
import PhotoTweaks
class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var textFields: UITextField!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var ivImageView: UIImageView!
    @IBOutlet weak var vwSubView: UIView!
    @IBOutlet weak var ivSubImageView: UIImageView!
    @IBOutlet weak var lblSubView: UILabel!
    var panGesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var btnSelectImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       // textFields.delegate = self
        textFields.isHidden = true
        navigationItem.title = "Custom Image Editor"
        self.vwSubView.isHidden = true
        self.lblText.isHidden = true
        self.BottomView.isHidden = true
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        self.vwSubView.isUserInteractionEnabled = true
        self.vwSubView.addGestureRecognizer(panGesture)
    }
    @IBAction func btnSelectImage(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageCropViewController") as! ImageCropViewController
        secondVC.delegate = self
        self.navigationController?.pushViewController(secondVC, animated: true)
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
        self.ivImageView.addDashedBorder()
    }

    @IBAction func btnDotted(_ sender: Any) {
        self.ivImageView.addDottedBorder()
    }

    @IBAction func btnSimple(_ sender: Any) {
        self.ivImageView.layer.borderWidth = 5
        self.ivImageView.layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
        self.ivImageView.layer.masksToBounds = true
    }
    
    
    @IBAction func btnText(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SetTextFontViewController") as! SetTextFontViewController
        secondVC.delegate = self
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    func textEdit(){
        self.lblText.isHidden = false
        lblText.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(ViewController.lblTapped)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        lblText.addGestureRecognizer(tapGesture)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedText(_:)))
        self.lblText.addGestureRecognizer(panGesture)
    }
    func lblTapped(){
        lblText.isHidden = true
        textFields.isHidden = false
        textFields.text = lblText.text
    }
    func draggedText(_ sender:UIPanGestureRecognizer){
        if sender.state == .began || sender.state == .changed || sender.state == .ended {
            var rec: CGRect = (sender.view?.frame)!
            let imgvw = self.ivImageView.frame
            if ((rec.origin.x >= imgvw.origin.x && rec.origin.y >= imgvw.origin.y && (rec.origin.x + rec.size.width <= imgvw.origin.x + imgvw.size.width) && (rec.origin.y + rec.size.height <= imgvw.origin.y + imgvw.size.height))){
                let translation = sender.translation(in: self.ivImageView)
                lblText.center = CGPoint(x: (sender.view?.center.x)! + translation.x, y: (sender.view?.center.y)! + translation.y)
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
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFields.isHidden = true
        lblText.isHidden = false
        lblText.text = textFields.text
        return true
    }
    @IBAction func btnSave(_ sender: UIButton) {
//        UIGraphicsBeginImageContextWithOptions(ivImageView.bounds.size, true, UIScreen.main.scale)
//        ivImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        UIGraphicsBeginImageContext(ivImageView.bounds.size)
//        UIGraphicsEndImageContext()
//        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let image =  UIImage.init(view: subView)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        let alert = UIAlertController(title:"Image Saved", message: "Your Image has been saved to your camera roll", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


