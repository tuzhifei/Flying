//  GameScene.swift
//  FlyingPenguin
//

import UIKit
import SpriteKit
import GameplayKit


public let SCENE_WIDTH:CGFloat  = 2048
public let SCENE_HEIGHT:CGFloat = 1536

class GameViewController: UIViewController,GameSceneDelegate {
  
    override func viewDidLoad() {
        
        if let view = self.view as! SKView? {
            if let scene = GameScene(fileNamed: "GameScene") {
                /*
                 * self=>GameViewController,委托scene代理去做二件事
                 * 第一件：screenShot() ，第二件：shareUrl,GameScene做完了后
                 * GameViewController 就调用并实现上面这二件方法
                 */
                scene.gameSceneDelegate = self             // 设置代理为本身(GameViewController)
                scene.anchorPoint = CGPoint(x: 0, y: 0)    // 把场景的中心点设为左下角;
                scene.size = CGSize(width: SCENE_WIDTH, height: SCENE_HEIGHT)
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            /// view.showsPhysics = true 
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
    }
    // 实现GameScene的代理的二个方法
    //MARK:- 抓屏
    func screenShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 1.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //MARK:- 分享链接
    func shareUrl(_ string: String, url: URL, image: UIImage) {
        print("viewController 分享链接")
        let activityViewController = UIActivityViewController(activityItems: [string, url, image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
