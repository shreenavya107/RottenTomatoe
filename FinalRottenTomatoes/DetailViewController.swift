//
//  DetailViewController.swift
//  
//
//  Created by Navya Nidhanapati on 9/14/14.
//
//

import UIKit

class DetailViewController: UIViewController {

   // @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterDetailed: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    var titleTextValue=""
    var synopsisTextValue=""
    var imageURL = ""
    var sizeValue=""
    var contentSi=""
    var synopsisSize:CGFloat=0
    
    
    @IBOutlet weak var scrollIt: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       titleLabel.text=titleTextValue
       synopsisLabel.text=synopsisTextValue
       posterDetailed.setImageWithURL(NSURL(string: imageURL))

        scrollIt.contentSize=CGSizeMake(scrollIt.frame.size.width, synopsisSize)
        // Do any additional setup after loading the view.
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

}
