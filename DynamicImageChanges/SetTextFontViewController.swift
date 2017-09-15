//
//  SetTextFontViewController.swift
//  DynamicImageChanges
//
//  Created by Eryus Developer on 15/09/17.
//  Copyright © 2017 Eryushion Techsol. All rights reserved.
//

import UIKit
import LSDialogViewController
class SetTextFontViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblTestText: UILabel!
    @IBOutlet weak var tfSelectFont: UITextField!
    @IBOutlet weak var tfSelectColor: UITextField!
    @IBOutlet weak var tfSelectSize: UITextField!
    var dialogViewController: SelectionTextAttribute!
    var delegate: ViewController!
    var data = [String]()
    var color = ["black","blue","brown","cyan","darkGray","gray","green","magenta","orange","purple","red","yellow"]
    var size = ["10","15","20","25","30","35","40","45","50"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Text Attribute"
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    @IBAction func TextEditingChanged(_ sender: UITextField) {
        dialogViewController = SelectionTextAttribute(nibName: "SelectionTextAttribute", bundle: Bundle.main)
        dialogViewController.delegate = self
        dialogViewController.datasource = self
        let screenSize: CGRect = UIScreen.main.bounds
        dialogViewController.view.frame = CGRect(x: 0, y: 0, width: screenSize.width / 1.1, height: screenSize.height / 2)
        switch(sender){
        case tfSelectFont:
            dialogViewController.from = "Font"
            data += UIFont.familyNames
            dialogViewController.data = data
            self.presentDialogViewController(dialogViewController, animationPattern: .fadeInOut, completion: nil)
            break
        case tfSelectColor:
            dialogViewController.from = "Color"
            dialogViewController.data = color
            self.presentDialogViewController(dialogViewController, animationPattern: .fadeInOut, completion: nil)
            break
        case tfSelectSize:
            dialogViewController.from = "Size"
            dialogViewController.data = size
            self.presentDialogViewController(dialogViewController, animationPattern: .fadeInOut, completion: nil)
            break
        default:
            break;
        }
    }
    
    @IBAction func btnSetText(_ sender: UIButton) {
        delegate.lblText.font = self.lblTestText.font
        delegate.lblText.textColor = self.lblTestText.textColor
        delegate.textEdit()
        navigationController?.popViewController(animated: true)
    }
}
