import UIKit

public class MenuShadow : UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func revealAnim() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.alpha = 0.44
        }
    }
    
    func hideAnim() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.alpha = 0
        }
    }
}
