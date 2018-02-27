//
//  GetJobSeekerRecord
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import Parse
import Bolts

class GetJobSeekerRecord {
    
    let query = PFQuery(className: "Student")
    
    
    func getUserById(userEmail : String)->[AnyObject]!{
        
        query.whereKey("userEmail", equalTo: userEmail)
        return query.findObjects()!
        
    }
    
    func getUserByName(name : String)->[AnyObject]!{
        
        query.whereKey("FirsName", equalTo:  name)
        
        if(query.findObjects()?.count != 0)
        {
             return query.findObjects()!
        }
        query.whereKey("LastName", equalTo:  name)
        
        if(query.findObjects()?.count != 0)
        {
            return query.findObjects()!
        }
        return query.findObjects()!
        
    }


}
