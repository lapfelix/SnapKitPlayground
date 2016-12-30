//: Playground - noun: a place where people can play

import UIKit
import SnapKit
import PlaygroundSupport

var str = "Hello, playground"

// Setup
let mainView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 320, height: 568)))
let flexibleView = VariableSizeView(size: CGSize(width: 400, height: 600), variableView: mainView)
PlaygroundPage.current.liveView = flexibleView
PlaygroundPage.current.needsIndefiniteExecution = true

mainView.clipsToBounds = true
mainView.backgroundColor = UIColor(white: 0.9, alpha: 1)

// add view to mainView and set constraints here:

let whiteView = UIView()
whiteView.backgroundColor = .white

let textLabel = UILabel()
textLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
textLabel.numberOfLines = 0

let dogView = UIImageView(image: #imageLiteral(resourceName: "good_dog.jpg"))
dogView.contentMode = .scaleAspectFill
dogView.clipsToBounds = true

mainView.addSubview(whiteView)
whiteView.addSubview(textLabel)
whiteView.addSubview(dogView)

whiteView.snp.makeConstraints { (make) in
    make.edges.equalTo(mainView.readableContentGuide)
}

textLabel.snp.makeConstraints { (make) in
    make.top.bottom.right.equalTo(whiteView).inset(5)
    make.width.equalTo(whiteView).multipliedBy(0.5)
}

dogView.snp.makeConstraints { (make) in
    make.left.top.bottom.equalTo(whiteView.readableContentGuide)
    make.right.equalTo(textLabel.snp.left).offset(-10)
}
