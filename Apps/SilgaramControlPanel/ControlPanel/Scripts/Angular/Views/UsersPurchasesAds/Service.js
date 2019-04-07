myApp.service("serviceUsersPurchasesAds", ["$http", function (h) {
    var fun = {},
        Controller = "/UsersPurchasesAds/";

    //Get UsersPurchasesAds
    fun.getUsersPurchasesAds = function (adId,take,skip) {
        return h({
            method: "Get",
            url: Controller + `GetUsersPurchasesAds?adId=${adId}&take=${take}&skip=${skip}`
        });
    };

    //Save Chenage
    fun.SaveChenage = function (jobs) {
        return h({
            method: "post",
            url: Controller + "SaveChenage",
            data:jobs
        });
    };
    return fun;
}]);