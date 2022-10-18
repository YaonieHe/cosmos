import UIKit
import Foundation

public class InfiniteScrollView: UIScrollView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var curr = contentOffset
        if curr.x < 0 {
            curr.x = contentSize.width - frame.width
            contentOffset = curr
        } else if curr.x >= contentSize.width - frame.width {
            curr.x = 0
            contentOffset = curr
        }
    }
}
