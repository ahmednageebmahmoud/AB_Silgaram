myApp.service("serviceReports", ["$http", function (h) {
    var fun = {},
        Controller = "/Reports/";

    //Get Reports
    fun.getReports = function (adId,take,skip) {
        return h({
            method: "Get",
            url: Controller + `GetReports?adId=${adId}&take=${take}&skip=${skip}`
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