/// <reference path="../../Shared/Module.js" />
myApp.service("serviceNotifications", ["$http", function (h) {
    var controller = "/Notifications/",
        functions = {

            //Check User Allow For This Notify
            checkUserAllowForThisNotify(notifyId) {
                return h({
                    method: 'Get',
                    url: `${controller}checkUserAllowForThisNotify?notifyId=${notifyId}`,
                });
            },
            //Get Notify
            getNotify(notifyId) {
                return h({
                    method: 'Get',
                    url: `${controller}getNotify?notifyId=${notifyId}`,
                });
            },



        };
    return functions;
}]);