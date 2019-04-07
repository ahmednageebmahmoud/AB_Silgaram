/// <reference path="../../Shared/Module.js" />
myApp.service("serviceCountries", ["$http", function (h) {
    var controller = "/Countries/",
        functions = {

            //Get Countries
            getCountries() {
                return h({
                    method: 'Get',
                    url: `${controller}GetCountries`,
                });
            },
            //Get Flags
            getFlags() {
                return h({
            method: 'Get',
            url: `${controller}GetFlags`,
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