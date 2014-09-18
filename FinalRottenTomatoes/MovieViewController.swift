//
//  MovieViewController.swift
//  FinalRottenTomatoes
//
//  Created by Navya Nidhanapati on 9/14/14.
//  Copyright (c) 2014 Navya Nidhanapati. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var networkAlert: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.delegate=self
        tableView.dataSource=self
        [MBProgressHUD .showHUDAddedTo(self.view, animated: true)]

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), { () -> Void in
            println("ygj")
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                println("hf")
                [MBProgressHUD .hideHUDForView(self.view, animated: true)]
            })
        })
        
        var url="http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=u"
        var request=NSURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            var object=NSJSONSerialization.JSONObjectWithData(data, options:nil, error: nil) as NSDictionary
            
            if(object["movies"]==nil)
            {
                self.networkAlert.text="Network Error!"
               // [TWMessageBarManager .sharedInstance() .showMessageWithTitle("Network Error", description: "Invalid URL Connection", type: TWMessageBarMessageTypeError , duration: 10, callback:{self.viewDidLoad()})]
                // self.tableView.insertSubview(myAlertView, atIndex: 0)
               // var alert=UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertCon9trollerStyle.Alert)
                
            }
            else{
                self.movies=object["movies"] as [NSDictionary]
            self.tableView.reloadData()
            }
            
            
        }

        // Do any additional setup after loading the view.
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell=tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        var movie=movies[indexPath.row]
        cell.movieTitleLabel.text=movie["title"] as? String
        cell.synopsisLabel.text=movie["synopsis"] as? String
        var posters=movie["posters"] as NSDictionary
        var posterUrl=posters["thumbnail"] as String
        cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
       if(segue.identifier=="showMovieDetail")
       {
        let vc=segue.destinationViewController as DetailViewController
        var getRow=tableView!.indexPathForSelectedRow()?.row
        var movie=movies[getRow!]
        var titleName=movie["title"] as String
        var synopsisName=movie["synopsis"] as String
        var posters=movie["posters"] as NSDictionary
        var posterUrl=posters["thumbnail"] as String
        var originalUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: NSStringCompareOptions.LiteralSearch, range: nil)
        vc.titleTextValue=titleName
        vc.synopsisTextValue=synopsisName
        vc.imageURL=originalUrl
        vc.synopsisSize=CGFloat(countElements(synopsisName))
       
        
    
        }
        
    
        
        
        
        
      //   println(titleName)
        }// Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    


