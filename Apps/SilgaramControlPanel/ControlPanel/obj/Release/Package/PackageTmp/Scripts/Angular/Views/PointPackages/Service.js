/// <reference path="../../Shared/Module.js" />
myApp.service("servicePointPackages", ["$http", function (h) {
    var controller = "/PointPackages/",
        functions = {

            //Get PointPackages
            getPointPackages() {
                return h({
                    method: 'Get',
                    url: `${controller}GetPointPackages`,
                });
            },
            //save Change
            saveChange(data) {
                return h({
                    method: 'Post',
                    url: `${controller}SaveChenage`,
                    data: data
                });
            }



        };
    return functions;
}]);