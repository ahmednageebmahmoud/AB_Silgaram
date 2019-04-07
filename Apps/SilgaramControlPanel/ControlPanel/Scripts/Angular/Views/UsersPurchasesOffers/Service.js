myApp.service("serviceUsersPurchasesOffers", ["$http", function (h) {
    var fun = {},
        Controller = "/UsersPurchasesOffers/";

    //Get UsersPurchasesOffers
    fun.getUsersPurchasesOffers = function (adId,take,skip) {
        return h({
            method: "Get",
            url: Controller + `GetUsersPurchasesOffers?adId=${adId}&take=${take}&skip=${skip}`
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