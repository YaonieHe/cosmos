import UIKit

class Menu : UIView {
    var menuRing: MenuRings!
    var menuIcons: MenuIcons!
    var menuSelector: MenuSelector!
    var menuShadow: MenuShadow!
    var shouldRevert: Bool = false
    
    var menuIsVisible = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        menuRing = MenuRings(frame: bounds)
        menuSelector = MenuSelector(frame: bounds)
        menuIcons = MenuIcons(frame: bounds)
        menuShadow = MenuShadow(frame: bounds)
        
        addSubview(menuShadow)
        addSubview(menuRing)
        addSubview(menuSelector)
        addSubview(menuIcons)
        
        createGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.addGestureRecognizer(longPress)
    }
    
    @objc func longPress(_ longPress: UILongPressGestureRecognizer) {
        self.menuSelector.longPress(longPress)
        
        switch longPress.state {
        case .began:
            self.revealMenu()
        case .cancelled, .failed, .ended:
            if menuIsVisible {
                self.hideMenu()
            } else {
                self.shouldRevert = true
            }
        default: do{}
        }
    }
    
    func revealMenu() {
        self.menuIsVisible = false
        
        menuShadow.revealAnim()
        menuRing.thickRingOut()
        menuRing.thinRingOut()
        menuIcons.signIconsOut()
        
        delayWork(time: 0.33) {
            self.menuRing.revealHideDividingLins(target: 1)
            self.menuIcons.revealSignIcons()
        }
        
        delayWork(time: 0.66) {
            self.menuRing.dashedRingsOut()
        }
        
        delayWork(time: 1.0) {
            self.menuIsVisible = true
            if self.shouldRevert {
                self.hideMenu()
                self.shouldRevert = false
            }
        }
    }
    
    func hideMenu() {
        self.menuIsVisible = false
        
        menuRing.dashedRingsIn()
        menuRing.revealHideDividingLins(target: 0)
        
        delayWork(time: 0.16) {
            self.menuIcons.hideSignIcons()
        }
        delayWork(time: 0.57) {
            self.menuRing.thinRingIn()
        }
        delayWork(time: 0.66) {
            self.menuIcons.signIconsIn()
            self.menuRing.thickRingIn()
            self.menuShadow.hideAnim()
        }
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        return menuSelector
//    }
}
