//
//  MessageCell.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-12-02.
//

import Foundation
import UIKit

class MessageCell: UICollectionViewCell {

    var message: Message? {
        didSet { configure() }
    }

    private weak var navigationController: UINavigationController?
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!

    let locationButtonView: UIButton = {
        let locationButton = UIButton()
        locationButton.setImage(UIImage(systemName: "location.north"), for: .normal)
        return locationButton
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()

    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(locationButtonView)
        locationButtonView.anchor(bottom: bottomAnchor, right: rightAnchor,paddingLeft: 50, paddingBottom: -4,paddingRight: 10)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 15, paddingBottom: -4)
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12

        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true

        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false

        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: locationButtonView.rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false

        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor,
                        bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,
                        paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)

        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text

        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive

        profileImageView.isHidden = viewModel.shouldHideProfileImage
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        locationButtonView.isHidden = !viewModel.shouldHideProfileImage
        locationButtonView.isEnabled = true
    }
    
    
}
