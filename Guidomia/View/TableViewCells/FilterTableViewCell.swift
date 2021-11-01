//
//  FilterTableViewCell.swift
//  Guidomia
//
//  Created by Ajay Vyas on 30/10/21.
//

import UIKit

protocol FilterCallDelegate {
    func callForFilter(make:String,model:String)
    func showAlert(title:String)
}

class FilterTableViewCell: UITableViewCell,
                           UIPickerViewDelegate {

    @IBOutlet private weak var txtVehicleModel: UITextField!
    @IBOutlet private weak var txtVehicleMake: UITextField!
    fileprivate let pickerView = ToolbarPickerView()
    var vehicleList = [Vehicle]()
    private var listing = [String]()
    private var selectedTextField = UITextField()
    var delegate: FilterCallDelegate?
    override func awakeFromNib() {
        
        super.awakeFromNib()
        txtVehicleMake.showShadowTextField()
        txtVehicleModel.showShadowTextField()
        self.txtVehicleMake.inputView = self.pickerView
        self.txtVehicleMake.inputAccessoryView = self.pickerView.toolbar
        self.txtVehicleModel.inputView = self.pickerView
        self.txtVehicleModel.inputAccessoryView = self.pickerView.toolbar
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
    }

    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}

extension FilterTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.selectedTextField = textField
        if selectedTextField == txtVehicleModel {
            if self.txtVehicleMake.text.unwrappedValue.isEmpty {
                self.delegate?.showAlert(title: kErrorSelectVehicleMake)
                return false
            }
        }
        self.showActionSheet(textField: textField)
        return true
    }
    
    func showActionSheet(textField : UITextField) {
        
        var vehcileMakeList = Array(Set(vehicleList.map({$0.make ?? ""})))
        var vehcileModelList = Array(Set(vehicleList.filter({$0.make == self.txtVehicleMake.text}).map({$0.model ?? ""})))
        vehcileMakeList.sort()
        vehcileModelList.sort()
        self.listing = textField == txtVehicleMake ? vehcileMakeList : vehcileModelList
        self.pickerView.reloadAllComponents()
    }
}

extension FilterTableViewCell: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return self.listing.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return self.listing[row]
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        print(self.listing[row])
    }
}

extension FilterTableViewCell: ToolbarPickerViewDelegate {

    func didTapDone() {
        
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.selectedTextField.text = self.listing[row]
        self.selectedTextField.resignFirstResponder()
        if selectedTextField == txtVehicleMake {
            txtVehicleModel.text = ""
        }
        self.delegate?.callForFilter(make: self.txtVehicleMake.text ?? "",
                                     model: self.txtVehicleModel.text ?? "")
    }

    func didTapCancel() {
        self.selectedTextField.text = ""
        if selectedTextField == txtVehicleMake {
            txtVehicleModel.text = ""
        }
        self.selectedTextField.resignFirstResponder()
        self.delegate?.callForFilter(make: self.txtVehicleMake.text ?? "",
                                     model: self.txtVehicleModel.text ?? "")
    }
}
