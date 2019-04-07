myApp.service("serviceView", ["$filter", function ($filter) {

    var func = {};
   
    //Check single value
    func.CheckedValueEdit = function (key, value, data, objectId) {
        var checked = false;
        if (data.length > 0)
            data.forEach(function (item) {
                debugger;
                if (item.State !== 'Delete' || item.State === undefined)
                    if (item.Id !== objectId)
                        if (item[key] === value)
                            checked = true;
            });
        return checked;
    };

    //is Duplicated
    func.isDuplicated = function (objectKeyAndValue, data, objectIdForNotChecked) {
        if (data == null || data == "" || data == undefined) return false;
        var checked = false;
        if (data.length > 0) {
            var objectNames = Object.getOwnPropertyNames(objectKeyAndValue);
            
            if (objectIdForNotChecked == undefined)
                data.forEach(function (item, index) {
                    if (item.State != State.Delete)
                        for (var i in objectNames) {
                            if (objectKeyAndValue[objectNames[i]] == item[objectNames[i]])
                                checked = true;
                        }
                });
            else
                data.forEach(function (item, index) {
                    if (item.State != State.Delete  && item.Id != objectIdForNotChecked)
                        for (var i in objectNames) {
                            if (objectKeyAndValue[objectNames[i]] == item[objectNames[i]])
                                checked = true;
                        }
                });
        }

        return checked;
    };

    
    return func;
}]);