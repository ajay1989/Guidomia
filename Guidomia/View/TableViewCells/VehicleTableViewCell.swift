//
//  VehicleTableViewCell.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var heightStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var prosConsStackView: UIStackView!
    @IBOutlet private weak var viewRating: CosmosView!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblModelName: UILabel!
    @IBOutlet private weak var imgVehicle: UIImageView!
    var vehicleModelData:Vehicle?
    
    override func awakeFromNib() {
        for view in prosConsStackView.subviews{
            view.removeFromSuperview()
        }
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //SetUp UI Data
    func setData() {
        
        guard let vehcileData = vehicleModelData else {
            return
        }
        lblModelName.text = "\(vehcileData.make.unwrappedValue) \(vehcileData.model.unwrappedValue)"
        lblPrice.text = "Price : \(vehcileData.customerPrice.unwrappedValue/1000)k"
        viewRating.totalStars = vehcileData.rating.unwrappedValue
        imgVehicle.image = UIImage(named: "\(vehcileData.make.unwrappedValue) \(vehcileData.model.unwrappedValue)")
        if !vehcileData.collapse {
            self.setProsCons()
            self.prosConsStackView.isHidden = false
        }
        else {
            self.heightStackViewConstraint.constant = 0.0
            self.prosConsStackView.isHidden = true
        }
    }
    
    func setProsCons() {
        
        let prosList = vehicleModelData?.prosList?.filter({$0 != "" }) ?? [String]()
        let consList = vehicleModelData?.consList?.filter({$0 != "" }) ?? [String]()
        let prosCount = prosList.count
        let consCount = consList.count
        var stackViewHeight:CGFloat = 0.0
        if prosCount > 0 {
            stackViewHeight = self.getTotalHeightOfLabels(list: prosList) + 30.0
            setUpViews(title: "Pros", list: prosList, yaxis: 0.0)
        }
        if consCount > 0 {
            let defaultProsLabelHeight:CGFloat = prosCount > 0 ? 30.0 : 0.0
            stackViewHeight = stackViewHeight + CGFloat(consCount * 30) + 30.0
            setUpViews(title: "Cons", list: consList, yaxis: self.getTotalHeightOfLabels(list: prosList) + defaultProsLabelHeight)
        }
        self.heightStackViewConstraint.constant = CGFloat(stackViewHeight) + 16.0
    }
    
    func setUpViews(title:String,
                    list:[String],
                    yaxis:CGFloat) {
        
        let appColor = AppColors()
        let titleView = UIView(frame: CGRect(x: 20.0,
                                        y: yaxis,
                                        width: prosConsStackView.frame.width - 20.0,
                                        height: CGFloat(list.count * 30) + 30.0))
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: titleView.frame.width, height: 30))
        titleLabel.text = "\(title) : "
        titleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .medium)
        titleLabel.textColor = appColor.colorDarkGrey
        titleView.addSubview(titleLabel)
        var yaxisOfBullet:CGFloat = 30.0
        for i in 0..<list.count {
            let bulletViews = UIView(frame: CGRect(x: 20.0, y: yaxisOfBullet, width: titleView.frame.width - 20, height: self.getHeightOfLabel(title: list[i])))
            let circleView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
            circleView.backgroundColor = appColor.colorOrange
            circleView.cornerRadius = 5.0
            circleView.clipsToBounds = true
            bulletViews.addSubview(circleView)
            let bulletLabel = UILabel(frame: CGRect(x: 20.0, y: 3.0, width: bulletViews.frame.width - 20, height: self.getHeightOfLabel(title: list[i])))
            bulletLabel.text = list[i]
            bulletLabel.font = UIFont.systemFont(ofSize: 18.0)
            bulletLabel.numberOfLines = 0
            bulletLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            bulletLabel.sizeToFit()
            bulletLabel.textColor = .black
            bulletViews.addSubview(bulletLabel)
            titleView.addSubview(bulletViews)
            yaxisOfBullet +=  self.getHeightOfLabel(title: list[i])
        }
        self.prosConsStackView.addSubview(titleView)
    }
    
    
    func getTotalHeightOfLabels(list:[String]) -> CGFloat {
        
        var height:CGFloat = 0.0
        for data in list {
            height += self.getHeightOfLabel(title: data)
        }
        return height
    }
    
    func getHeightOfLabel(title:String) -> CGFloat {
        
        let label = UILabel(frame: CGRect(x: 60.0, y: 3.0, width: prosConsStackView.frame.width - 60.0, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.text = title
        label.sizeToFit()
        return label.frame.height + 8.0
    }
    
}
