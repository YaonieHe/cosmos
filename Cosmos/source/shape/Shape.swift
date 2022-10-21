//  Created on 2022/10/19.

import UIKit

class Shape: UIView {
    // MARK: - Public
    var path: CGPath? {
        get {
            return shapeLayer.path
        }
        set {
            shapeLayer.path = newValue
        }
    }
    var lineWidth: CGFloat {
        get {
            return shapeLayer.lineWidth
        }
        set {
            shapeLayer.lineWidth = newValue
        }
    }
    
    var fillColor: CGColor? {
        get { return shapeLayer.fillColor }
        set { shapeLayer.fillColor = newValue }
    }
    
    var strokeColor: CGColor? {
        get { return shapeLayer.strokeColor }
        set { shapeLayer.strokeColor = newValue }
    }
    
    var opacity: Float {
        get { return shapeLayer.opacity }
        set { shapeLayer.opacity = newValue }
    }
    
    var lineDashPattern: [NSNumber]? {
        get { return shapeLayer.lineDashPattern }
        set { shapeLayer.lineDashPattern = newValue }
    }
    
    var strokeEnd: CGFloat {
        get { return shapeLayer.strokeEnd }
        set { shapeLayer.strokeEnd = newValue }
    }
    
    var lineCap: CAShapeLayerLineCap {
        get {return shapeLayer.lineCap}
        set {shapeLayer.lineCap = newValue}
    }
    
    var lineJoin: CAShapeLayerLineJoin {
        get { return shapeLayer.lineJoin }
        set { shapeLayer.lineJoin = newValue }
    }
    
    override var anchorPoint: CGPoint {
        get { return shapeLayer.anchorPoint }
        set { shapeLayer.anchorPoint = newValue }
    }
    
    func setAffineTransform(_ m: CGAffineTransform) {
        shapeLayer.setAffineTransform(m)
    }
    
    // MARK: - layer
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }
    
    // MARK: - 动画
    private static var __layerPropertyNames: [String]? = nil
    private class func getLayerPropertyNames() -> [String] {
        if let __layerPropertyNames = __layerPropertyNames {
            return __layerPropertyNames
        } else {
            var names = [String]()
            var outCount: UInt32 = 0
            let properties = class_copyPropertyList(CAShapeLayer.self, &outCount)
            for i in 0..<outCount {
                let property = properties![Int(i)]
                let name = String(cString: property_getName(property))
                names.append(name)
            }
            __layerPropertyNames = names
            return names
        }
    }
    
    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        let propertyName = Shape.getLayerPropertyNames()
        
        if propertyName.contains(where: { str in
            return str == event
        }) {
            let dummyAction = super.action(for: layer, forKey: "backgroundColor")

            if let animation = dummyAction as? CABasicAnimation {
                animation.keyPath = event
                animation.fromValue = layer.presentation()?.value(forKey: event)
                animation.toValue = nil
                return animation
            }
        }
        return super.action(for: layer, forKey: event)
    }
}

class Line: Shape {
    init(begin: CGPoint, end: CGPoint) {
        
        let orignal = CGPoint(x: min(begin.x, end.x), y: min(begin.y, end.y))
        let size = CGSize(width: abs(begin.x - end.x), height: abs(begin.x - end.x))
        let frame = CGRect(origin: orignal, size: size)
        super.init(frame: frame)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: begin.x - orignal.x, y: begin.y - orignal.y))
        path.addLine(to: CGPoint(x: end.x - orignal.x, y: end.y - orignal.y))
        
        self.path = path.cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Circle: Shape {
    convenience init(center: CGPoint, radius: CGFloat) {
        let frame = CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius), size: CGSize(width: radius * 2, height: radius * 2))
        
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            let radius = min(bounds.width, bounds.height) * 0.5
            let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2.0, clockwise: true)
            self.path = path.cgPath
        }
    }
}
