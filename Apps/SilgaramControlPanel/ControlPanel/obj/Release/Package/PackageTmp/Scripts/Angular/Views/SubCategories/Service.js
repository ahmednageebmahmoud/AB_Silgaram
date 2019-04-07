/// <reference path="../../Shared/Module.js" />
myApp.service("serviceSubCategories", ["$http", function (h) {
    var controller = "/SubCategories/",
        functions = {

            //Get Categories
            getCategories() {
                return h({
                    method: 'Get',
                    url: `${controller}GetCategories`,
                });
            },
            //Get SubCategories
            getSubCategories(categoryId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetSubCategories?categoryId=${categoryId}`,
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