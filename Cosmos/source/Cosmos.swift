//  Created on 2022/10/20.

import UIKit

class Cosmos: UIView {
    
    var stars: Stars!
    var menu: Menu!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .COSMOSbkgd
        
        stars = Stars(frame: bounds)
        self.addSubview(stars)
        
        menu = Menu(frame: bounds)
        self.addSubview(menu)
        menu.selectionAction = { selection in
            delayWork(time: 0.9) {
                self.stars.goto(selection: selection)
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
