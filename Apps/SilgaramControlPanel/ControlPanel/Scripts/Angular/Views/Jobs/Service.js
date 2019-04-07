/// <reference path="../../Shared/Module.js" />
myApp.service("serviceJobs", ["$http", function (h) {
    var controller = "/Jobs/",
        functions = {

            //Get Jobs
            getJobs() {
                return h({
                    method: 'Get',
                    url: `${controller}GetJobs`,
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