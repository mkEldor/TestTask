import UIKit
import Alamofire
import AlamofireImage

var imageDict = [String:UIImage]()

extension UIImageView {
  
  public  func load(fromUrl url: String, complation: (() -> ())?) {
    
    if let image = imageDict[url] {
      self.image = image
      return
    }
    
    imageDict[url] = UIImage()
    Alamofire.request(url).responseImage { (response) in
      if let image = response.result.value{
        let size  = CGSize(width: 130, height: 130)
        let scaledImage = image.af_imageScaled(to: size)
        DispatchQueue.main.async {
          self.image = scaledImage
          imageDict[url] = scaledImage
          complation?()
        }
      }
    }
  }
  
}
