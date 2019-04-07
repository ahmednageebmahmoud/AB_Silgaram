/// <reference path="../../Shared/Module.js" />
myApp.service("servicePagesAllow", ["$http", function (h) {
    var controller = "/PagesAllow/",
        functions = {

            //get Pages
            getPages() {
                return h({
                    method: 'Get',
                    url: `${controller}getPages`,
                });
            },
            //Get PagesAllow
            getPagesAllow() {
                return h({
                    method: 'Get',
                    url: `${controller}GetPagesAllow`,
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