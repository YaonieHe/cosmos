import UIKit

public class SignLines : InfiniteScrollView {
    private var lines: [[Line]] = [[Line]]()
    var currentIndex: Int = 0
    private var currentLines: [Line] {
        var result = lines[currentIndex]
        if currentIndex == 0 {
            if let tmp = lines.last {
                result.append(contentsOf: tmp)
            }
        }
        if currentIndex == lines.count - 1 {
            if let tmp = lines.first {
                result.append(contentsOf: tmp)
            }
        }
        return result
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
                let line = Line(begin: begin, end: end)
                line.lineWidth = 1
                line.strokeColor = UIColor.COSMOSprpl.cgColor
                line.strokeEnd = 0
                line.opacity = 0.4
                self.addSubview(line)
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
