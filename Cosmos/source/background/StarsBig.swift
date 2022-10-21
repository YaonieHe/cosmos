import UIKit

public class StarsBig : InfiniteScrollView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        var signOrder = AstrologicalSignProvider.sharedInstance.order
        contentSize = CGSize(width: frame.width * (1 + CGFloat(signOrder.count) * gapBetweenSigns), height: 1.0)
        signOrder.append(signOrder[0])
        
        let img = UIImage(named: "7bigStar")
        for i in 0 ..< signOrder.count {
            let dx = CGFloat(i) * frame.width * gapBetweenSigns
            let t = CGAffineTransform(translationX: center.x + dx, y: center.y)
            guard let sign = AstrologicalSignProvider.sharedInstance.get(sign: signOrder[i]) else {
                continue
            }
            for point in sign.big {
                let imageView = UIImageView(image: img)
                imageView.sizeToFit()
                imageView.center = CGPointApplyAffineTransform(point, t)
                self.addSubview(imageView)
            }
        }
        
        addDashes()
        addMarkers()
        addSignNames()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addDashes() {
        let points = (CGPoint(x: 0, y: frame.maxY), CGPoint(x: contentSize.width, y: frame.maxY))
        
        let line = Line(begin: points.0, end: points.1)
        line.lineDashPattern = [2, 2]
        line.lineWidth = 10
        line.strokeColor = UIColor.COSMOSblue.cgColor
        line.opacity = 0.33
        line.lineCap = .butt
        self.addSubview(line)
    }
    
    private func addMarkers() {
        for i in 0...AstrologicalSignProvider.sharedInstance.order.count {
            let dx = CGFloat(i) * frame.width * gapBetweenSigns + frame.width / 2
            let begin = CGPoint(x: dx, y: frame.height - 20)
            let end = CGPoint(x: dx, y: frame.height)
            
            let marker = Line(begin: begin, end: end)
            marker.lineWidth = 2
            marker.strokeColor = UIColor.white.cgColor
            marker.lineCap = .butt
            marker.opacity = 0.33
            self.addSubview(marker)
        }
    }
    
    
    private func createSmallSign(name: String) -> CAShapeLayer? {
        guard let sign = AstrologicalSignProvider.sharedInstance.get(sign: name) else {
            return nil
        }
        let smallSine = CAShapeLayer()
        smallSine.lineWidth = 2
        smallSine.strokeColor = UIColor.white.cgColor
        smallSine.fillColor = UIColor.clear.cgColor
        smallSine.opacity = 0.33
        smallSine.setAffineTransform(CGAffineTransform(scaleX: 0.66, y: 0.66))
        smallSine.bounds = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        smallSine.path = sign.shape.cgPath
        return smallSine
    }
    
    private func createSmallSignTitle(name: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = name
        label.textColor = .white
        label.font = font
        label.alpha = 0.33
        label.sizeToFit()
        return label
    }
    
    private func createSmallSignDegree(degree: Int, font: UIFont) -> UILabel {
        return createSmallSignTitle(name: "\(degree)", font: font)
    }
    
    private func addSignNames() {
        var signNames = AstrologicalSignProvider.sharedInstance.order
        signNames.append(signNames[0])
        
        let y = frame.height - 86
        let dx = frame.width * gapBetweenSigns
        let offset = frame.width / 2
        let font = UIFont(name: "Menlo-Regular", size: 13)!
        
        for i in 0..<signNames.count {
            let name = signNames[i]
            
            var point = CGPoint(x: offset + dx * CGFloat(i), y: y)
            if let sign = self.createSmallSign(name: name) {
                sign.position = point
                self.layer.addSublayer(sign)
            }
            
            point.y += 26
            let title = createSmallSignTitle(name: name, font: font)
            title.center = point
            self.addSubview(title)
            
            point.y += 22
            var value = i * 30
            if value > 330 {
                value = 0
            }
            let degree = createSmallSignDegree(degree: value, font: font)
            degree.center = point
            self.addSubview(degree)
        }
    }
}
