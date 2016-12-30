import UIKit
import SnapKit

public class VariableSizeView : UIView {

    //private var initialSize
    
    private let handleView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .white
        let radius = 20
        view.frame = .zero
        view.layer.cornerRadius = CGFloat(radius / 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 0, height: 2)

        return view
    }()

    private var widthConstraint : Constraint?
    private var heightConstraint : Constraint?

    public var variableView : UIView
    
    public init(size: CGSize, variableView: UIView) {
        self.variableView = variableView
        
        super.init(frame: CGRect(origin: .zero, size: size))

        backgroundColor = .white
        addSubview(handleView)
        addSubview(variableView)
        sendSubview(toBack: variableView)

        handleView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerX.equalTo(variableView.snp.right)
            make.centerY.equalTo(variableView.snp.bottom)
        }


        variableView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            widthConstraint = make.width.equalTo(0).offset(variableView.frame.size.width).constraint
            heightConstraint = make.height.equalTo(0).offset(variableView.frame.size.height).constraint
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        if handleView.frame.contains(location) {
            animateFrameSizeChange(newTouchLocation: location)
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        
        animateFrameSizeChange(newTouchLocation: location)
    }
    
    func animateFrameSizeChange(newTouchLocation location: CGPoint) {
        variableView.snp.updateConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.width.equalTo(0).offset(location.x)
            make.height.equalTo(0).offset(location.y)
        }
        
        self.setNeedsLayout()
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] () -> Void in
            self?.layoutIfNeeded()
        })
    }

}
