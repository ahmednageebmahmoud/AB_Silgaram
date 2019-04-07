/// <reference path="../../Shared/Module.js" />
myApp.service("serviceSubMenus", ["$http", function (h) {
    var controller = "/SubMenus/",
        functions = {

            //Get SubMenus
            getSubMenus() {
                return h({
                    method: 'Get',
                    url: `${controller}GetSubMenus`,
                });
            },
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