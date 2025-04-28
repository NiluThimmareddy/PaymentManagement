//
//  LeftMenuTVC.swift
//  PaymentManagement
//
//  Created by praveenkumar on 25/04/25.
//

import UIKit
protocol LeftMenuTVCDelegate: AnyObject {
    func didSelectMenuItem(_ index: IndexPath)
}
class LeftMenuTVC: UITableViewCell {
    
    weak var delegate: LeftMenuTVCDelegate?
    var isExpanded = false {
            didSet {
                let imageName = isExpanded ? "upload" : "dload"
                arrowImage.image = UIImage(named: imageName)
                bottomView.isHidden = !bottomView.isHidden
                
            }
        }
    var subMenuItems: [MenuItem] = []
   
    @IBOutlet weak var tableViewOpenButton: UIButton!
    @IBOutlet weak var subData: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var leftMenuTitle: UILabel!
    @IBOutlet weak var leftMenuImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        subData.dataSource = self
        subData.delegate = self
        subData.register(UINib(nibName: "LeftMenuSubDataTVC", bundle: nil), forCellReuseIdentifier: "LeftMenuSubDataTVC")
        tableViewOpenButton.isHidden = true
    }
    
    @IBAction func tableViewOpenButton(_ sender: Any) {
        isExpanded.toggle()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func config(with data: MenuItem, expanded: Bool){
        leftMenuImage.image = UIImage(named: data.imageName)
        leftMenuTitle.text = data.title
        isExpanded = expanded
        if data.title == "Invoice", let subItems = data.subItems {
               subMenuItems = subItems
            tableViewOpenButton.isHidden = false
              
           } else {
               subMenuItems = []
               tableViewOpenButton.isHidden = true
           }
        subData.reloadData()
    }
}
extension LeftMenuTVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subMenuItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuSubDataTVC") as! LeftMenuSubDataTVC
        let subItem = subMenuItems[indexPath.row]
        cell.subDataLbl.text = subItem.title
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectMenuItem(indexPath)

        
       
    }
}
