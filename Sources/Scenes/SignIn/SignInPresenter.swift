protocol SignInPresenting: AnyObject {
    func presentMaskedField(basedOn userInput: String)
    func presentPasswordScene()
}

final class SignInPresenter {
    private let coordinator: SignInCoordinating
    weak var viewController: SignInDisplaying?
    
    init(coordinator: SignInCoordinating) {
        self.coordinator = coordinator
    }
}

extension SignInPresenter: SignInPresenting {
    func presentMaskedField(basedOn userInput: String) {
        let cpfMask = Array("###.###.###-##").map { String($0) }
        let numbers = Array(userInput.filter { ch in ch.isNumber }).map { String($0) }
        var maskedText = ""
        var numbersIndex = 0
        
        cpfMask.enumerated().forEach { index, maskCharacter in
            guard numbersIndex < numbers.count else { return }
            
            if maskCharacter == "#" {
                maskedText.append(contentsOf: numbers[numbersIndex])
                numbersIndex += 1
            } else {
                maskedText.append(contentsOf: cpfMask[index])
            }
        }
        
        viewController?.displayMaskedField(text: maskedText)
        viewController?.displayNextStepButton(isEnabled: maskedText.count == cpfMask.count)
    }
    
    func presentPasswordScene() {
        coordinator.coordinateToPasswordScene()
    }
}
