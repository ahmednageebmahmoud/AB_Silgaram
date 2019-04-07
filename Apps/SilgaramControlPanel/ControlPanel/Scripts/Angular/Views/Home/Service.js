/// <reference path="../../Shared/Module.js" />
myApp.service("serviceHome", ["$http", function (h) {
    var controller = "/Home/",
        functions = {

            //Get Home
            getHomeData() {
                return h({
                    method: 'Get',
                    url: `${controller}GetHomeDate`,
                });
            },
        };
    return functions;
}]);