/// <reference path="../../Shared/Module.js" />
myApp.service("serviceMenus", ["$http", function (h) {
    var controller = "/Menus/",
        functions = {

            //Get Menus
            getMenus() {
                return h({
                    method: 'Get',
                    url: `${controller}GetMenus`,
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