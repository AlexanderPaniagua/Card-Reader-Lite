import ExpoModulesCore

public class CardReaderLiteModule: Module {
  public func definition() -> ModuleDefinition {
    Name("CardReaderLite")

    AsyncFunction("scanCard") { (promise: Promise) in
      DispatchQueue.main.async {
        guard let root = UIApplication.shared.keyWindow?.rootViewController else {
          promise.reject("E_NO_ROOT", "Cannot find root view controller")
          return
        }

        let scannerVC = CardScannerHostingController()
        scannerVC.completion = { result in
          promise.resolve(result)
        }

        root.present(scannerVC, animated: true)
      }
    }
  }
}