myApp.service("serviceProductsSold", ["$http", function (h) {
    var fun = {},
        Controller = "/ProductsSold/";

    
    //Get ProductsSold
    fun.checkUserAllowForThisNotify = function (  notifyId) {
        return h({
            method: "Get",
            url: `/Notifications/CheckUserAllowForThisNotify?notifyId=${notifyId}`
        });
    };

    //Get ProductsSold
    fun.getProductsSold = function (productId, notifyId, take, skip) {
        return h({
            method: "Get",
            url: Controller + `GetProductsSold?productId=${productId}&take=${take}&skip=${skip}&notifyId=${notifyId}`
        });
    };

 
    return fun;
}]);