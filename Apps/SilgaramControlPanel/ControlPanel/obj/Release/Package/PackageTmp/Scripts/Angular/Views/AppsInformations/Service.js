/// <reference path="../../Shared/Module.js" />
myApp.service("serviceAppsInformations", ["$http", function (h) {
    var controller = "/AppsInformations/",
        functions = {

            //Get AppsInformations
            getAppsInformations() {
                return h({
                    method: 'Get',
                    url: `${controller}GetAppsInformations`,
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