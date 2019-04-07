/// <reference path="../../Shared/Module.js" />
myApp.service("serviceCommercialBanner", ["$http", function (h) {
    var controller = "/CommercialBanners/",
        functions = {

            //Get CommercialBanner
            getCommercialBanner(skip,take) {
                return h({
                    method: 'Get',
                    url: `${controller}GetCommercialBanner?skip=${skip}&take=${take}`,
                });
            },
            getCommercialBannerDetails(technicalSupportId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetCommercialBannerDetails?technicalSupportId=${technicalSupportId}`,
                });
            },
            



        };
    return functions;
}]);