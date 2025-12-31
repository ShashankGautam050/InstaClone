//
//  ProfileTabsCollectionReusableView.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 05/01/26.
//

import UIKit
protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didSelectGridTab()
    func didSelectTaggedTab()
}

struct Constants {
    static let padding: CGFloat = 12
}
class ProfileTabsCollectionReusableView: UICollectionReusableView {
        static  let identifier: String = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    private let gridButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        btn.clipsToBounds = true
        btn.tintColor = .systemBlue
        return btn
    }()
    private let taggedButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        btn.clipsToBounds = true
        btn.tintColor = .secondarySystemBackground
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(gridButton)
        addSubview(taggedButton)
        addActionsOfBtn()
    }
    
    private func addActionsOfBtn() {
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didSelectGridTab()
    }
    @objc private func didTapTaggedButton() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didSelectTaggedTab()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let height = height - (Constants.padding * 2)
        let gridButtonX = ((width/2) - height)/2
        gridButton.frame = CGRect(x: gridButtonX, y:Constants.padding , width: height, height: height)
        taggedButton.frame = CGRect(x: gridButtonX + (width/2), y:Constants.padding, width: height, height: height)
    }
}
