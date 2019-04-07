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
            saveChange(adData,images) {
                var Keyes = [
                "Id",
                "Title",
                "Description",
                "StartDateTime",
                "EndDateTime",
                "Price",
                 "IsTop",
                 "IsApprove",
                "FkSubCategory_Id",
                "FkCategory_Id",
                "FkAlbum_Id",
                "FkLog_Id",
                "FkUser_Id",
                "FkLocation_Id",
                 "PhoneNumber",
                 "IsAllowMessaging",
                 "IsPostWithOutPhoneNumber",
                 "IsAutoPost",
                 "State",
                                            "PhoneNumber",
                                            "Latitude",
                                            "Longitude"

                ],
                formData = new FormData();

                //Ad Images
                images.forEach((img,index) => {
                    formData.append(`ads[0].Files[${index}].AlbumFileId`, img.AlbumFileId);
                    formData.append(`ads[0].Files[${index}].State`, img.State);
                    formData.append(`ads[0].Files[${index}].File`, img.File);
                });

                //Ad Another Values
                Keyes.forEach(key=> {
                    if(adData[key]!=undefined)
                        formData.append(`ads[0].${key}`, adData[key]);
                });


                return h({
                    method: 'Post',
                    url: `${controller}SaveChanage`,
                    data: formData,
                    headers: {
                        'Content-Type': undefined
                    }
                });
            },
            saveChange2(ads) {


                return h({
                    method: 'Post',
                    url: `${controller}SaveChanage`,
                    data: ads,
                });
            }



        };
    return functions;
}]);