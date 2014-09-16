//
//  IntroViewController.swift
//  Carousel
//
//  Created by Anh Tuan on 9/15/14.
//  Copyright (c) 2014 wafrat. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tile1View: UIImageView!
    @IBOutlet weak var tile2View: UIImageView!
    @IBOutlet weak var tile3View: UIImageView!
    @IBOutlet weak var tile4View: UIImageView!
    @IBOutlet weak var tile5View: UIImageView!
    @IBOutlet weak var tile6View: UIImageView!
    
    var yOffsets : [Float] = [-285, -240, -415, -408, -480, -500]
    var xOffsets : [Float] = [-30, 75, -66, 10, -200, -15]
    var scales : [Float] = [1, 1.65, 1.7, 1.6, 1.65, 1.65]
    var rotations : [Float] = [-10, -10, 10, 10, 10, -10]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize.height = 568 * 2
        scrollView.delegate = self
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = Float(scrollView.contentOffset.y)
        
        let tiles = [tile1View, tile2View, tile3View, tile4View, tile4View, tile6View]
        let offsetMin = Float(0.0)
        let offsetMax = Float(568.0)
        // somehow cannot use 0..tiles.count!
        let tileCount_1 = tiles.count - 1
        for index in 0...tileCount_1 {
            let tx = convertValue(offset, r1Min: offsetMin, r1Max: offsetMax, r2Min: xOffsets[index], r2Max: 0.0)
            let ty = convertValue(offset, r1Min: offsetMin, r1Max: offsetMax, r2Min: yOffsets[index], r2Max: 0.0)
            let scale = convertValue(offset, r1Min: offsetMin, r1Max: offsetMax, r2Min: scales[index], r2Max: 1.0)
            let angle = Double(convertValue(offset, r1Min: offsetMin, r1Max: offsetMax, r2Min: rotations[index], r2Max: 0.0)) * M_PI / 180
            let tile = tiles[index]
            tile.transform = CGAffineTransformMakeTranslation(CGFloat(tx), CGFloat(ty))
            tile.transform = CGAffineTransformScale(tile.transform, CGFloat(scale), CGFloat(scale))
            tile.transform = CGAffineTransformRotate(tile.transform, CGFloat(angle))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
}
