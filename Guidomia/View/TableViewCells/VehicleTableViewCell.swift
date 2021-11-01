//
//  VehicleTableViewCell.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bottomstackViewConstraint: NSLayoutConstraint!
    
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
        lblPrice.text = "\(kPrice) : \(vehcileData.customerPrice.unwrappedValue/1000)k"
        viewRating.totalStars = vehcileData.rating.unwrappedValue
        imgVehicle.image = UIImage(named: "\(vehcileData.make.unwrappedValue) \(vehcileData.model.unwrappedValue)")
        
        if vehcileData.collapse {
            self.heightStackViewConstraint.constant = 0.0
            self.prosConsStackView.isHidden = true
            self.bottomstackViewConstraint.constant = 4.0
        } else {
            self.setProsCons()
            self.prosConsStackView.isHidden = false
            self.bottomstackViewConstraint.constant = 30.0
        }
    }
    
    func setProsCons() {
        
        let prosList = vehicleModelData?.prosList?.filter({$0 != "" }) ?? [String]()
        let consList = vehicleModelData?.consList?.filter({$0 != "" }) ?? [String]()
        let prosCount = prosList.count
        let consCount = consList.count
        var stackViewHeight: CGFloat = 0.0
        if prosCount > 0 {
            stackViewHeight = self.getTotalHeightOfLabels(list: prosList) + 30.0
            setUpViews(title: kPros,
                       list: prosList,
                       verticalMargin: 0.0)
        }
        if consCount > 0 {
            let defaultProsLabelHeight: CGFloat = prosCount > 0 ? 40.0 : 0.0
            stackViewHeight = stackViewHeight + self.getTotalHeightOfLabels(list: consList) + 30.0
            setUpViews(title: kCons,
                       list: consList,
                       verticalMargin: prosCount > 0 ? self.getTotalHeightOfLabels(list: prosList) + defaultProsLabelHeight : defaultProsLabelHeight)
        }
        self.heightStackViewConstraint.constant = CGFloat(stackViewHeight)
    }
    
    func setUpViews(title:String,
                    list:[String],
                    verticalMargin:CGFloat) {
        // TO DO: yaxis should be change to vertical margin
        let appColor = AppColors()
        let titleView = UIView(frame: CGRect(x: 20.0,
                                        y: verticalMargin,
                                        width: prosConsStackView.frame.width - 20.0,
                                        height: CGFloat(list.count * 30) + 30.0))
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: titleView.frame.width, height: 30))
        titleLabel.text = "\(title) : "
        titleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .medium)
        titleLabel.textColor = appColor.colorDarkGrey
        titleView.addSubview(titleLabel)
        var verticalMarginOfBullet: CGFloat = 30.0
        
        for i in 0..<list.count {
            let bulletViews = UIView(frame: CGRect(x: 20.0,
                                                   y: verticalMarginOfBullet,
                                                   width: titleView.frame.width - 20,
                                                   height: self.getHeightOfLabel(title: list[i])))
            let circleView = UIView(frame: CGRect(x: 0,
                                                  y: 10,
                                                  width: 10,
                                                  height: 10))
            circleView.backgroundColor = appColor.colorOrange
            circleView.cornerRadius = 5.0
            circleView.clipsToBounds = true
            bulletViews.addSubview(circleView)
            let bulletLabel = UILabel(frame: CGRect(x: 20.0,
                                                    y: 3.0,
                                                    width: bulletViews.frame.width - 20,
                                                    height: self.getHeightOfLabel(title: list[i])))
            bulletLabel.text = list[i]
            bulletLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
            bulletLabel.numberOfLines = 0
            bulletLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            bulletLabel.sizeToFit()
            bulletLabel.textColor = .black
            bulletViews.addSubview(bulletLabel)
            titleView.addSubview(bulletViews)
            verticalMarginOfBullet +=  self.getHeightOfLabel(title: list[i])
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
        
        let label = UILabel(frame: CGRect(x: 60.0,
                                          y: 3.0,
                                          width: prosConsStackView.frame.width - 60.0,
                                          height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.text = title
        label.sizeToFit()
        return label.frame.height + 8.0
    }
    
}
