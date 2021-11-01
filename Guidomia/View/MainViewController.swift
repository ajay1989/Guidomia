//
//  MainViewController.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var heightTopViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainTableView: UITableView!
    private var mainViewModel : MainViewModel!
    var vehicleData:Vehicle?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setNavigationTitle(title: kMainNavigationTitle)
        self.setUIView()
        self.callToViewModel()
    }
    
    //Main UIView Setup
    func setUIView() {
        
        self.heightTopViewConstraint.constant = kAspectRatio * kScreenSize.width/100.0
        let cellIdentifier = TableCellIdentifier()
        self.mainTableView.autoLayoutRegisterNib(nibName: cellIdentifier.kFilterCellIdentifier)
        self.mainTableView.autoLayoutRegisterNib(nibName: cellIdentifier.kVehicleCellIdentifier)
    }
    
    //calling of ViewModel class
    func callToViewModel() {
        
        self.mainViewModel =  MainViewModel()
        self.mainViewModel.bindVehicleViewModel = {
            self.updateTableView()
        }
    }
    
    // reload tableview
    func updateTableView() {
        
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}

//MARK:- TableView delegate methods
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Get number of rows in section of teableview
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return (self.mainViewModel.vehicleData?.count ??  0) + 1
    }
    
    //Set cell for each row
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = TableCellIdentifier()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.kFilterCellIdentifier,
                                                     for: indexPath) as! FilterTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.kVehicleCellIdentifier,
                                                     for: indexPath) as! VehicleTableViewCell
            cell.vehicleModelData = self.mainViewModel.vehicleData?[indexPath.row - 1]
            cell.setData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row > 0 {
            let vehcileList = self.mainViewModel.vehicleData
            let listCount = vehcileList?.count ?? 0
            if vehcileList?[indexPath.row - 1].collapse == false {
                let data = vehcileList?[indexPath.row - 1]
                data?.collapse = true
            } else {
                for i in 0..<listCount {
                    let data = vehcileList?[i]
                    data?.collapse = i == indexPath.row - 1 ? false : true
                }
            }
            self.mainTableView.reloadData()
        }
    }
    
    
}
