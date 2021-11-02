//
//  VehicleTableViewCell.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bottomstackViewConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var prosConsStackView: UIStackView!
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
    
    /// SetUp UI Data in cell
    func setData() {
        
        guard let vehcileData = vehicleModelData else {
            return
        }
        lblModelName.text = "\(vehcileData.make ?? "") \(vehcileData.model ?? "")"
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
    
    /// Set up views inside stackview
    func setProsCons() {
        
        self.prosConsStackView.subviews.forEach({$0.removeFromSuperview()})
        let prosList = vehicleModelData?.prosList?.filter({!$0.isEmpty }) ?? [String]()
        let consList = vehicleModelData?.consList?.filter({!$0.isEmpty }) ?? [String]()
        let prosCount = prosList.count   
        let consCount = consList.count
        var stackViewHeight: CGFloat = 0.0
        if prosCount > 0 {
            stackViewHeight = self.getTotalHeightOfLabels(list: prosList) + 30.0
            setUpViews(title: kPros, list: prosList, verticalMargin: 0.0)
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
    
    
    /// Setup view for Pros and Cons view
    /// - Parameter title:passed Pros and Cons string name
    /// - Parameter list: string list of bullet points
    /// - Parameter verticalMargin: vertical margin from top
    func setUpViews(title:String, list:[String], verticalMargin:CGFloat) {
        
        let appColor = AppColors()
        let titleView = UIView(frame: CGRect(x: 20.0,
                                        y: verticalMargin,
                                        width: prosConsStackView.frame.width - 20.0,
                                        height: CGFloat(list.count * 30) + 30.0))
        let titleLabel = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: titleView.frame.width,
                                               height: 30))
        titleLabel.text = "\(title) : "
        titleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .medium)
        titleLabel.textColor = appColor.colorDarkGrey
        titleView.addSubview(titleLabel)
        var verticalMarginOfBullet: CGFloat = 32.0
        
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
        self.prosConsStackView.addSubview(titleView)  /// add pros and cons view to stackview
    }
    
    /// Get total height for bullet labels
    /// - Parameter list:list of bullet points in pros and cons
    /// - Returns: return total height of bullet listing
    func getTotalHeightOfLabels(list:[String]) -> CGFloat {
        
        var height:CGFloat = 0.0
        
        for data in list {
            height += self.getHeightOfLabel(title: data)
        }
        return height
    }
    
    /// Get total height for bullet labels
    /// - Parameter title: content of string to pass
    /// - Returns: return  height of bullet list label
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
