//
//  SelectionTextAttribute.swift
//  DynamicImageChanges
//
//  Created by Eryus Developer on 15/09/17.
//  Copyright © 2017 Eryushion Techsol. All rights reserved.
//

import UIKit

class SelectionTextAttribute: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var delegate: SetTextFontViewController!
    var datasource: SetTextFontViewController!
    var data = [String]()
    var from: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
    }

    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.lblText.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (from!) {
        case "Font":
            self.delegate.tfSelectFont.text = data[indexPath.row]
            self.delegate.lblTestText.font = UIFont(name: data[indexPath.row], size:30)
            break
        case "Color":
            self.delegate.tfSelectColor.text = data[indexPath.row]
            switch(data[indexPath.row]){
            case "black":
                self.delegate.lblTestText.textColor = UIColor.black
                break
            case "blue":
                self.delegate.lblTestText.textColor = UIColor.blue
                break
            case "brown":
                self.delegate.lblTestText.textColor = UIColor.brown
                break
            case "cyan":
                self.delegate.lblTestText.textColor = UIColor.cyan
                break
            case "darkGray":
                self.delegate.lblTestText.textColor = UIColor.darkGray
                break
            case "gray":
                self.delegate.lblTestText.textColor = UIColor.gray
                break
            case "green":
                self.delegate.lblTestText.textColor = UIColor.green
                break
            case "magenta":
                self.delegate.lblTestText.textColor = UIColor.magenta
                break
            case "orange":
                self.delegate.lblTestText.textColor = UIColor.orange
                break
            case "purple":
                self.delegate.lblTestText.textColor = UIColor.purple
                break
            case "red":
                self.delegate.lblTestText.textColor = UIColor.red
                break
            case "yellow":
                self.delegate.lblTestText.textColor = UIColor.yellow
                break
            default:
                break
            }
            break
        case "Size":
            self.delegate.tfSelectSize.text = data[indexPath.row]
            let size = Int(data[indexPath.row])
            self.delegate.lblTestText.font = UIFont(name: self.delegate.lblTestText.font.fontName, size: CGFloat(size!))
            break
        default:
            break
        }
        self.delegate?.dismissDialogViewController(.fadeInOut)
    }
    @IBAction func btnClose(_ sender: UIButton) {
        self.delegate?.dismissDialogViewController(.fadeInOut)
    }
}
