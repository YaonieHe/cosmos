import UIKit

public class StarsSmall : InfiniteScrollView {
    convenience public init(frame: CGRect, speed: CGFloat) {
        self.init(frame: frame)

        var signOrder = AstrologicalSignProvider.sharedInstance.order
        contentSize = CGSizeMake(frame.width * (1 + CGFloat(signOrder.count) * gapBetweenSigns), 1.0)
        signOrder.append(signOrder[0])
        
        let img = UIImage(named: "6smallStar")
        for i in 0..<signOrder.count {
            let dx = CGFloat(i) * frame.width * speed * gapBetweenSigns
            
            let t = CGAffineTransform(translationX: center.x + dx, y: center.y)
            
            guard let sign = AstrologicalSignProvider.sharedInstance.get(sign: signOrder[i]) else {
                continue
            }
            for point in sign.small {
                let p = CGPointApplyAffineTransform(point, t)
                let imageView = UIImageView(image: img)
                imageView.sizeToFit()
                imageView.center = p
                self.addSubview(imageView)
            }
        }
    }
}
