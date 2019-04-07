myApp.service("serviceUserPointPackages", ["$http", function (h) {
    var fun = {},
        Controller = "/UserPointPackages/";

    
    //Get UserPointPackages
    fun.checkUserAllowForThisNotify = function (  notifyId) {
        return h({
            method: "Get",
            url: `/Notifications/CheckUserAllowForThisNotify?notifyId=${notifyId}`
        });
    };

    //Get UserPointPackages
    fun.getUserPointPackages = function (pointPackageId, notifyId, take, skip) {
        return h({
            method: "Get",
            url: Controller + `GetUserPointPackages?pointPackageId=${pointPackageId}&take=${take}&skip=${skip}&notifyId=${notifyId}`
        });
    };

 
    return fun;
}]);