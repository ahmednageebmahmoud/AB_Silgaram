/// <reference path="../../Shared/Module.js" />
myApp.service("servicePagesRoles", ["$http", function (h) {
    var controller = "/PagesRoles/",
        functions = {

            //get Pages
            getPages() {
                return h({
                    method: 'Get',
                    url: `${controller}getPages`,
                });
            },
            //Get PagesRoles
            getPagesRoles(PageId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetPagesRoles?pageId=${PageId}`,
                });
            },
            //Get Roles
            getRoles() {
                return h({
                    method: 'Get',
                    url: `${controller}GetRoles`,
                });
            },
            //Get Pages Role Types
            getPagesRoleTypes() {
                return h({
                    method: 'Get',
                    url: `${controller}GetPagesRoleTypes`,
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