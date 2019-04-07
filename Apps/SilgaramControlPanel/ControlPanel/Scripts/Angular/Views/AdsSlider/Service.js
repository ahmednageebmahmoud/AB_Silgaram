/// <reference path="../../Shared/Module.js" />
myApp.service("serviceAdsSlider", ["$http", function (h) {
    var controller = "/AdsSlider/",
        functions = {

            //Get AdsSlider
            getAdsSlider() {
                return h({
                    method: 'Get',
                    url: `${controller}GetAdsSlider`,
                });
            },
           
            //save Change
            saveChange(adData) {
                var Keyes = [
                "Id",
                "NewFile",
                "State",
                "FkPositionType_Id"
                ],
                formData = new FormData();

                //Ad Another Values
                adData.forEach((ad,index) => {
                    Keyes.forEach(key=> {
                        if (ad[key] != undefined)
                            formData.append(`adsSlider[${index}].${key}`, ad[key]);
                    })
                });
                return h({
                    method: 'Post',
                    url: `${controller}SaveChanage`,
                    data: formData,
                    headers: {
                        'Content-Type': undefined
                    }
                });
            }




        };
    return functions;
}]);