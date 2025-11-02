import UIKit

class CardScannerHostingController: UIViewController, CardScannerControllerDelegate {
  var completion: (([String: Any]) -> Void)?
  private var scannerController: CardScannerController!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black

    scannerController = CardScannerController()
    scannerController.delegate = self
    addChild(scannerController)
    scannerController.view.frame = view.bounds
    view.addSubview(scannerController.view)
    scannerController.didMove(toParent: self)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scannerController.start()
  }

  func cardScannerController(_ controller: CardScannerController, didScanCard card: Card?) {
    guard let card = card else { return }
    controller.stop()
    dismiss(animated: true) {
      self.completion?([
        "number": card.number ?? "",
        "name": card.name ?? "",
        "expiryMonth": card.expiryMonth ?? NSNull(),
        "expiryYear": card.expiryYear ?? NSNull()
      ])
    }
  }

  func cardScannerControllerDidCancel(_ controller: CardScannerController) {
    controller.stop()
    dismiss(animated: true) {
      self.completion?(["cancelled": true])
    }
  }
}