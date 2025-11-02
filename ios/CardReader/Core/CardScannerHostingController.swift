import UIKit

class CardScannerHostingController: UIViewController, CardScannerDelegate {
    
    var completion: (([String: Any]) -> Void)?
    private var scannerController: CardScannerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        scannerController = CardScannerController(
            configuration: .init(watermarkText: "Align your card within the frame",
                                 font: .systemFont(ofSize: 18, weight: .medium),
                                 accentColor: .systemBlue,
                                 watermarkWidth: 240,
                                 watermarkHeight: 120,
                                 drawBoxes: true,
                                 localizedCancelButton: "Cancel",
                                 localizedDoneButton: "Done")
        )
        scannerController.delegate = self
        
        addChild(scannerController)
        scannerController.view.frame = view.bounds
        view.addSubview(scannerController.view)
        scannerController.didMove(toParent: self)
    }
    
    // MARK: - CardScannerDelegate
    
    func didTapCancel() {
        dismiss(animated: true) {
            self.completion?(["cancelled": true])
        }
    }
    
    func didTapDone(number: String?, expDate: String?, holder: String?) {
        dismiss(animated: true) {
            self.completion?([
                "number": number ?? "",
                "expDate": expDate ?? "",
                "holder": holder ?? ""
            ])
        }
    }
    
    func didScanCard(number: String?, expDate: String?, holder: String?) {
        print("🔍 Intermediate scan:", number ?? "nil")
    }
}
