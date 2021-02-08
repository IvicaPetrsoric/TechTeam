import UIKit

//enum CustomAnimationTransitionType {
//    case fromLeftToRight
//    case fromRightToLeft
//    case fromTopToBottom
//    case fromBottopmToTop
//}

class CustomAnimationPresenter: NSObject, UIViewControllerAnimatedTransitioning {
    
//    private var transitionType: CustomAnimationTransitionType = .fromLeftToRight
    
//    init(transitionType: CustomAnimationTransitionType) {
//        self.transitionType = transitionType
//        super.init()
//    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        containerView.addSubview(toView)
        
        
        
        let starrtingFrame = CGRect(x: -toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
        toView.frame = starrtingFrame
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            fromView.frame = CGRect(x: fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
            
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
//    private func getStartXPosition() -> CGFloat {
//        switch transitionType {
//        case .fromLeftToRight:
//            return -toView.frame.width
//        default:
//            <#code#>
//        }
//    }
    
}
