import UIKit

public class MenuIcons : UIView {
    var signIcons: [String: Shape] = [String: Shape]()
    
    var innerTargets: [CGPoint] = [CGPoint]()
    var outerTargets: [CGPoint] = [CGPoint]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSignIcons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animOut() {
        delayWork(time: 1.0) {
            self.signIconsOut()
        }
        delayWork(time: 1.5) {
            self.revealSignIcons()
        }
        
        delayWork(time: 2.5) {
            self.animIn()
        }
    }

    func animIn() {
        delayWork(time: 0.25) {
            self.hideSignIcons()
        }
        
        delayWork(time: 1.0) {
            self.signIconsIn()
        }
        
        delayWork(time: 2.5) {
            self.animOut()
        }
    }
    
    func createSignIcons() {
        let anchorArray = [
            "pisces": CGPoint(x: 0.099, y: 0.004),
            "aries": CGPoint(x: 0.0777, y: 0.536),
            "taurus": CGPoint(x: 0.0, y: 0.0),
            "gemini": CGPoint(x: 0.996, y: 0.0),
            "cancer": CGPoint(x: 0.0, y: 0.275),
            "leo": CGPoint(x: 0.379, y: 0.636),
            "virgo": CGPoint(x: 0.750, y: 0.387),
            "libra": CGPoint(x: 1.0, y: 0.559),
            "scorpio": CGPoint(x: 0.255, y: 0.775),
            "sagittarius": CGPoint(x: 1.0, y: 0.349),
            "capricorn": CGPoint(x: 0.288, y: 0.663),
            "aquarius": CGPoint(x: 0.0, y: 0.263),
        ]
        
        for name in AstrologicalSignProvider.sharedInstance.order {
            let path = AstrologicalSignProvider.sharedInstance.get(sign: name)!.shape!
            let shape = Shape(frame: path.bounds)
            shape.strokeEnd = 0.001
            shape.lineCap = .round
            shape.lineJoin = .round
            shape.setAffineTransform(CGAffineTransform(scaleX: 0.64, y: 0.64))
            shape.lineWidth = 2
            shape.strokeColor = UIColor.white.cgColor
            shape.fillColor = UIColor.clear.cgColor
            shape.anchorPoint = anchorArray[name]!
            shape.path = path.cgPath
            
            signIcons[name] = shape
        }
        
        positionSignIcons()
    }
    
    func positionSignIcons() {
        let provider = AstrologicalSignProvider.sharedInstance
        let r = 10.5
        let dx = bounds.midX
        let dy = bounds.midY
        
        let angleUnit = CGFloat.pi * 2 / CGFloat(provider.order.count)
        
        for i in 0..<provider.order.count {
            let angle = angleUnit * CGFloat(i)
            let name = provider.order[i]
            
            if let sign = signIcons[name] {
                sign.center = CGPoint(x: r * CoreGraphics.cos(angle) + dx, y: r * CoreGraphics.sin(angle) + dy)
                self.addSubview(sign)
                let anchorPoint = sign.anchorPoint;
                sign.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                innerTargets.append(sign.center)
                sign.anchorPoint = anchorPoint
            }
        }
        
        for i in 0..<provider.order.count {
            let r = 129.0
            let angle = angleUnit * CGFloat(i) + CGFloat.pi / 12
            outerTargets.append(CGPoint(x: r * CoreGraphics.cos(angle) + dx, y: r * CoreGraphics.sin(angle) + dy))
        }
    }
    
    
    func signIconsOut() {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseOut) {
            let count = AstrologicalSignProvider.sharedInstance.order.count
            for i in 0..<count {
                let name = AstrologicalSignProvider.sharedInstance.order[i]
                if let sign = self.signIcons[name] {
                    sign.center = self.outerTargets[i]
                }
            }
        }
    }
    
    func signIconsIn() {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseOut) {
            let count = AstrologicalSignProvider.sharedInstance.order.count
            for i in 0..<count {
                let name = AstrologicalSignProvider.sharedInstance.order[i]
                if let sign = self.signIcons[name] {
                    sign.center = self.innerTargets[i]
                }
            }
        }
    }
    
    func revealSignIcons() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            for sign in self.signIcons.values {
                sign.strokeEnd = 1
            }
        }
    }
    
    func hideSignIcons() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            for sign in self.signIcons.values {
                sign.strokeEnd = 0.001
            }
        }
    }
}
