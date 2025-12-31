//
//  FormTableViewCell.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 05/01/26.
//

import UIKit
protocol FormTableViewCellDelegate : AnyObject {
    func didEndEditing(_ cell : FormTableViewCell, updatedModel : EditProfileModel?)
}

class FormTableViewCell: UITableViewCell {
    
    
    static let identifier : String = "FormTableViewCell"
    
    private var model : EditProfileModel?
   
    // this is weak variable because to retain strong reference cycle which can lead to memory leak,therefore we use weak variable inside the closure especially if we are using class/instance variable inside the closure
    public weak var delegate : FormTableViewCellDelegate?
    private let formLabel : UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let formTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(formTextField)
        formTextField.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        formTextField.placeholder = nil
        formTextField.text = nil
    }
    public func configureModel(with model : EditProfileModel){
        self.model = model
        formLabel.text = model.label
        formTextField.placeholder = model.placeholder
        formTextField.text = model.value
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // Assigning frame here for the subviews here as like the view controllers we use to do
        formLabel.frame = CGRect(x: 16, y: 0, width: contentView.width/3, height: contentView.height)
        formTextField.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width - 10 - formLabel.width, height: contentView.height)
    }
}

  // MARK - Field
extension FormTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let value = textField.text {
            model?.value = value
        }
        guard let model = model else { return true }
        delegate?.didEndEditing(self, updatedModel: model)
        return true
    }
}
