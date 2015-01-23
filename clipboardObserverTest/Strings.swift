//
//  Strings.swift
//  clipboardObserverTest
//
//  Created by oky on 2015/01/23.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit

protocol StringsDelegate{
    func reloadTableViewData()
}

class Strings: NSObject {
   
    var stringsDelegate:StringsDelegate?
    private var array:[String] = ["1","2"]
    
    
    class var sharedInstance:Strings {
        struct Static {
            static let instance = Strings()
        }
        return Static.instance
    }

    
    func getArray()->[String]{
            return array
    }
    
    func addStrings(title:String){
        array.append(title)
        stringsDelegate?.reloadTableViewData()
    }
    
}
