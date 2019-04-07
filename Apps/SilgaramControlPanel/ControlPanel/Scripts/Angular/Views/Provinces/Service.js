/// <reference path="../../Shared/Module.js" />
myApp.service("serviceProvinces", ["$http", function (h) {
    var controller = "/Provinces/",
        functions = {

            //Get Countries
            getCountries() {
                return h({
                    method: 'Get',
                    url: `${controller}GetCountries`,
                });
            },
            //Get Provinces
            getProvinces(countryId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetProvinces?countryId=${countryId}`,
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