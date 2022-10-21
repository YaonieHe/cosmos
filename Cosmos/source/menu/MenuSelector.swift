import UIKit

import AVFoundation

public class MenuSelector : UIView {
    private var highlight: Shape!
    
    private(set) var currentSelection = -1
    
    private var menuLabel: UILabel!
    
    private let tick = AudioPlayer("tick.mp3")!
    
    // MARK: -
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = false
        backgroundColor = .clear
        createGesture()
        createHighlight()
        createLabel()
        tick.volume = 0.4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createHighlight() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius:CGFloat = 156
        highlight = Shape(frame: CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius), size: CGSize(width: radius * 2, height: radius * 2)))
        let path = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: CGFloat.pi / 6, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: radius, y: radius))
        path.close()
        highlight.path = path.cgPath
        highlight.fillColor = UIColor.COSMOSblue.cgColor
        highlight.lineWidth = 0
        highlight.opacity = 0.8
        
        self.addSubview(highlight)
        
        let donut = Circle(center: CGPoint(x: radius, y: radius), radius: 156 - 54 / 2)
        donut.fillColor = UIColor.clear.cgColor
        donut.strokeColor = UIColor.black.cgColor
        donut.lineWidth = 54
        highlight.mask = donut
        
        highlight.isHidden = true
    }
    
    private func createLabel() {
        let font = UIFont(name: "Menlo-Regular", size: 13)!
        menuLabel = UILabel()
        menuLabel.text = "COSMOS"
        menuLabel.font = font
        menuLabel.textColor = .white
        self.addSubview(menuLabel)
        menuLabel.isHidden = true
    }
    
    private func createGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.addGestureRecognizer(longPress)
    }
    
    // MARK: - 手势
    @objc func longPress(_ longPress: UILongPressGestureRecognizer) {
        switch longPress.state {
        case .changed:
            update(location: longPress.location(in: self))
        case .cancelled, .ended, .failed:
            self.currentSelection = -1
            self.highlight.isHidden = true
            menuLabel.isHidden = true
        default: do {}
        }
    }
    
    private func update(location: CGPoint) {
        let d = CGPoint(x: location.x - bounds.midX, y: location.y - bounds.midY)
        var angle = atan2(d.y, d.x)
        if angle < 0 {
            angle += CGFloat.pi * 2
        }
        let count = AstrologicalSignProvider.sharedInstance.order.count
        
        let index = Int(CGFloat(count) * angle / (CGFloat.pi * 2))
        
        let dist = sqrt(d.x * d.x + d.y * d.y)
       
        if dist > 102 && dist < 156 {
            highlight.isHidden = false
            menuLabel.isHidden = false
            if currentSelection != index {
                currentSelection = index
                highlight.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(index) * CGFloat.pi / 6))
                tick.stop()
                tick.play()
            }
            
            menuLabel.text = AstrologicalSignProvider.sharedInstance.order[index]
            menuLabel.sizeToFit()
            menuLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        } else {
            highlight.isHidden = true
            menuLabel.isHidden = true
        }
        
    }
}
