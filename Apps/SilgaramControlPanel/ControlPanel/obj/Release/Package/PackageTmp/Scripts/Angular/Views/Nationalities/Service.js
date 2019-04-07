/// <reference path="../../Shared/Module.js" />
myApp.service("serviceNationalities", ["$http", function (h) {
    var controller = "/Nationalities/",
        functions = {

            //Get Nationalities
            getNationalities() {
                return h({
                    method: 'Get',
                    url: `${controller}GetNationalities`,
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