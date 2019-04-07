/// <reference path="../../Shared/Module.js" />
myApp.service("serviceReportTypes", ["$http", function (h) {
    var controller = "/ReportTypes/",
        functions = {

            //Get ReportTypes
            getReportTypes() {
                return h({
                    method: 'Get',
                    url: `${controller}GetReportTypes`,
                });
            },
            //save Change
            saveChange(data) {
                return h({
                    method: 'Post',
                    url: `${controller}SaveChange`,
                    data: data
                });
            }
        };
    return functions;
}]);