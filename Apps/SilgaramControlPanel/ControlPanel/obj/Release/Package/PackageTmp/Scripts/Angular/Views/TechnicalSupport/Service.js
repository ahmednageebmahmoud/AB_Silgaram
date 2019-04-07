/// <reference path="../../Shared/Module.js" />
myApp.service("serviceTechnicalSupport", ["$http", function (h) {
    var controller = "/TechnicalSupport/",
        functions = {

            //Get TechnicalSupport
            getTechnicalSupport(skip,take) {
                return h({
                    method: 'Get',
                    url: `${controller}GetTechnicalSupport?skip=${skip}&take=${take}`,
                });
            },
            getTechnicalSupportDetails(technicalSupportId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetTechnicalSupportDetails?technicalSupportId=${technicalSupportId}`,
                });
            },
            



        };
    return functions;
}]);