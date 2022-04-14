import UIKit

enum ExtractDetailAction {
    case share
    case cancelTransaction
}

protocol ExtractDetailCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: ExtractDetailAction)
}

final class ExtractDetailCoordinator {
    weak var viewController: UIViewController?

}

private extension ExtractDetailCoordinator {
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let imageViewScale = max(inputImage.size.width / viewWidth,
                                 inputImage.size.height / viewHeight)

        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                              y:cropRect.origin.y * imageViewScale,
                              width:cropRect.size.width * imageViewScale,
                              height:cropRect.size.height * imageViewScale)

        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
        else {
            return nil
        }

        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
}

// MARK: - ExtractDetailCoordinating
extension ExtractDetailCoordinator: ExtractDetailCoordinating {
    func perform(action: ExtractDetailAction) {
        switch action {
        case .share:
            UIGraphicsBeginImageContextWithOptions((viewController?.view.frame.size)!, false, 3.0)
            viewController?.view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let vc = UIActivityViewController(activityItems: [screenshot as Any], applicationActivities: [])
            viewController?.present(vc, animated: true)
            
        case .cancelTransaction:
            print("Cancelar Transferência")
        }
    }
}
