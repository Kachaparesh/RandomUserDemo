/*Test Cases

API Test
    Check reachability
    Request URL
    Check Response
Parse Data
    Get response in JSON
    Parse data to objects
DB store
 

 Network code: You preferably only use a single class for network communication across your entire app. It makes it easy to abstract concepts common to all networking requests like HTTP headers, response and error-handling and more.
 Persistence code: You use this when persisting data to a database, Core Data or storing data on a device.
 Parsing code: You should include objects that parse network responses in the model layer. For example, in Swift model objects, you can use JSON encoding/decoding to handle parsing. This way, everything is self-contained and your network layer doesn’t have to know the details of all your model objects in order to parse them. Business and parsing logic is all self-contained within the models.
 Managers and abstraction layers/classes: Everyone uses them, everyone needs them, nobody knows what to call them or where they belong. It’s normal to have the typical “manager” objects that often act as the glue between other classes. These can also be wrappers around lower-level, more robust API: a keychain wrapper on iOS, a class to help with notifications or a model to help you work with HealthKit.
 Data sources and delegates: Something that may be less common is developers relying on model objects to be the data source or delegate of other components such as table or collection views. It’s common to see these implemented in the controller layer even when there’s a lot of custom logic that’s best kept compartmentalized.
 Constants: It’s good practice to have a file with constants. Consider putting these within a structure of structures or variables. That way, you can reuse storyboard names, date formatters, colors, etc.
 Helpers and extensions: In your projects, you will often add methods to extend the capabilities of strings, collections, etc. These too can be considered part of the model.


 
*/

// Uodate logs
// Check swift 5 implementation for CoreData












import UIKit

var str = "Hello, playground"
