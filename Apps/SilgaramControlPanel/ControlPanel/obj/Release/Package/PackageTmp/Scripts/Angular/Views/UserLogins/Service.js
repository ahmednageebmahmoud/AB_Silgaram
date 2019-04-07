myApp.service("serviceUserLogins", ["$http", function (h) {
    var fun = {},
        Controller = "/UserLogins/";

    //Get UserLogins
    fun.getUserLogins = function (userSerial,take,skip) {
        return h({
            method: "Get",
            url: Controller + `GetUserLogins?userSerial=${userSerial}&take=${take}&skip=${skip}`
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