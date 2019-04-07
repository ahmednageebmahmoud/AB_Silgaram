/// <reference path="../../Shared/Module.js" />
myApp.service("serviceCategories", ["$http", function (h) {
    var controller = "/Categories/",
        functions = {

            //Get Categories
            getCategories() {
                return h({
                    method: 'Get',
                    url: `${controller}GetCategories`,
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