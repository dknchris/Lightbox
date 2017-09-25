import UIKit
import Hue
import AVKit
import AVFoundation

public class LightboxConfig {
  public static var hideStatusBar = true

  open static var handleVideo: (_ from: UIViewController, _ videoURL: URL) -> Void = { from, videoURL in
    let videoController = AVPlayerViewController()
    videoController.player = AVPlayer(url: videoURL)

    from.present(videoController, animated: true) {
      videoController.player?.play()
    }
  }

  public struct PageIndicator {
    public static var enabled = true
    public static var separatorColor = UIColor(hex: "3D4757")

    public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.systemFont(ofSize: 12),
      .foregroundColor: UIColor(hex: "899AB8"),
      .paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
      }()
    ]
  }

  public struct CloseButton {
    public static var enabled = true
    public static var size: CGSize?
    public static var text = NSLocalizedString("Close", comment: "")
    public static var image: UIImage?

    public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 16),
      .foregroundColor: UIColor.white,
      .paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
      }()
    ]
  }

  public struct DeleteButton {
    public static var enabled = false
    public static var size: CGSize?
    public static var text = NSLocalizedString("Delete", comment: "")
    public static var image: UIImage?

    public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 16),
      .foregroundColor: UIColor(hex: "FA2F5B"),
      .paragraphStyle: {
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
      }()
    ]
  }

  public struct InfoLabel {
    public static var enabled = true
    public static var textColor = UIColor.white
    public static var ellipsisText = NSLocalizedString("Show more", comment: "")
    public static var ellipsisColor = UIColor(hex: "899AB9")

    public static var textAttributes: [NSAttributedStringKey: Any] = [
      .font: UIFont.systemFont(ofSize: 12),
      .foregroundColor: UIColor(hex: "DBDBDB")
    ]
  }

  public struct Zoom {
    public static var minimumScale: CGFloat = 1.0
    public static var maximumScale: CGFloat = 3.0
  }

  public struct LoadingIndicator {
    public static var configure: ((UIActivityIndicatorView) -> Void)?
  }
}
