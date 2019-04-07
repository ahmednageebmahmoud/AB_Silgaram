/// <reference path="../../Shared/Module.js" />
myApp.service("serviceOffers", ["$http", function (h) {
    var controller = "/Offers/",
        functions = {

            //Get Offers
            getOffers(skip,take) {
                return h({
                    method: 'Get',
                    url: `${controller}GetOffers?skip=${skip}&take=${take}`,
                });
            },
            //Get Offer
            getOffer(offerId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetOfferById?offerId=${offerId}`,
                });
            },
            //Get SubCategories
            getSubCategories(skip, take) {
                return h({
                    method: 'Get',
                    url: `${controller}getSubCategories`,
                });
            },
            //Get Categories
            getCategories(skip, take) {
                return h({
                    method: 'Get',
                    url: `${controller}getCategories`,
                });
            },

            //save Change
            saveChange(offerData,images) {
                var formData = new FormData();

                var keys = [
                    "Id",
                    "State",
                    "Title",
                    "Price",
                    "DiscountRate",
                    "SmallDiscription",
                    "Description",
                    "IsTop",
                        "EndDateTime",
                    "StartDateTime",
                    "FkCategory_Id",
                    "FkSubCategory_Id",
                    "Images",
                ];

                //Offer Images
                images.forEach((img, index) => {
                    formData.append(`offers[0].Files[${index}].AlbumFileId`, img.AlbumFileId);
                    formData.append(`offers[0].Files[${index}].State`, img.State);
                    formData.append(`offers[0].Files[${index}].File`, img.File);
                });

                //Offer Another Values
                keys.forEach(key=> {
                    if (offerData[key] != undefined)
                        formData.append(`offers[0].${key}`, offerData[key]);
                });

                return h({
                    method: "post",
                    url: `${controller}SaveChanage`,
                    data: formData,
                    headers: {
                        'Content-Type': undefined
                    },
                });
            },
            //save Change
            saveChange2(offers) {
                return h({
                    method: "post",
                    url: `${controller}SaveChanage`,
                    data: offers,
                });
            }





        };
    return functions;
}]);