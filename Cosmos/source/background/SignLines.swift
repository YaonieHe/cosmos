import UIKit

class Line: CAShapeLayer {
    var begin: CGPoint = .zero {
        didSet {
            self.setNeedsLayout()
        }
    }
    var end: CGPoint = .zero {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        let path = UIBezierPath()
        path .move(to: begin)
        path.addLine(to: end)
        
        self.path = path.cgPath
    }
}

public class SignLines : InfiniteScrollView {
    var lines: [[Line]] = [[Line]]()
    var currentIndex: Int = 0
    var currentLines: [Line] {
        return lines[currentIndex]
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let count = CGFloat(AstrologicalSignProvider.sharedInstance.order.count)
        contentSize = CGSizeMake(frame.width * (count * gapBetweenSigns + 1), 1.0)
        
        var signOrder = AstrologicalSignProvider.sharedInstance.order
        signOrder.append(signOrder[0])
        
        for i in 0..<signOrder.count {
            let dx = CGFloat(i) * frame.width * gapBetweenSigns
            let t = CGAffineTransform(translationX: center.x + dx, y: center.y)
            guard let sign = AstrologicalSignProvider.sharedInstance.get(sign: signOrder[i]) else {
                continue
            }
            let connections = sign.lines
            var currentLineSet = [Line]()
            for points in connections! {
                let begin = CGPointApplyAffineTransform(points[0], t)
                let end = CGPointApplyAffineTransform(points[1], t)
                let line = Line()
                line.lineWidth = 1
                line.strokeColor = UIColor.COSMOSprpl.cgColor
                line.strokeEnd = 0
                line.opacity = 0.4
                line.begin = begin
                line.end = end
                self.layer.addSublayer(line)
                currentLineSet.append(line)
            }
            lines.append(currentLineSet)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func revealCurentSignLines() {
        UIView.animate(withDuration: 0.25) {
            for line in self.currentLines {
                line.strokeEnd = 1
            }
        }
    }
    
    func hideCurrentSignLines() {
        UIView.animate(withDuration: 0.25) {
            for line in self.currentLines {
                line.strokeEnd = 0
            }
        }
    }
}
