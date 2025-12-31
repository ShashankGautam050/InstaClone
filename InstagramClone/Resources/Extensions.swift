//
//  Extensions.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 01/01/26.
//

import UIKit

extension UIView {
    public var width : CGFloat {
        return frame.width
    }
    public var height : CGFloat {
        return frame.height
    }
    public var bottom : CGFloat {
        return frame.maxY
    }
    public var left : CGFloat {
        return frame.minX
    }
    public var right : CGFloat {
        return frame.maxX
    }
    public var top : CGFloat {
        return frame.minY
    }
    
}


extension String  {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "")
    }
}
