/// <reference path="../../Shared/Module.js" />
myApp.service("serviceAds", ["$http", function (h) {
    var controller = "/Ads/",
        functions = {

            //Get Ads
            getAds(skip,take) {
                return h({
                    method: 'Get',
                    url: `${controller}GetAllAds?skip=${skip}&take=${take}`,
                });
            },
            //Get Ad
            getAd(adId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetAdById?adId=${adId}`,
                });
            },
            //Get SubCategories
            getSubCategories(skip,take) {
                return h({
                    method: 'Get',
                    url: `${controller}getSubCategories`,
                });
            },
            //Get Categories
            getCategories(skip,take) {
                return h({
                    method: 'Get',
                    url: `${controller}getCategories`,
                });
            },
            
                
            


            //save Change
            saveChange(data) {
                return h({
                    method: 'Post',
                    url: `${controller}SaveChanage`,
                    data: data
                });
            }



        };
    return functions;
}]);