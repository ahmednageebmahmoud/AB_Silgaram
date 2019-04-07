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
            saveChange(data) {
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
                    "EndDateTimeString",
                    "StartDateTimeString",
                    "FkCategory_Id",
                    "FkSubCategory_Id",
                    "Images",
                ];



                if (Array.isArray(data)) {
                    data.forEach((offer, index) => {

                        keys.forEach((key) => {
                            if (key == "Images")
                            {
                                //Add Images
                                var ImageIndex = 0;
                                offer['Images'].forEach((img) => {
                                    if (img.State == State.Create || img.State == State.Delete) {
                                        formData.append(`offers[${index}].Images[${ImageIndex}].File`, img.File);
                                        formData.append(`offers[${index}].Images[${ImageIndex}].State`, img.State);
                                        formData.append(`offers[${index}].Images[${ImageIndex}].FileId`, img.FileId);
                                        ImageIndex++;
                                    }
                                });

                            }else if (offer[key] != undefined) {
                                console.log(offer[key])
                                formData.append(`offers[${index}].${key}`, offer[key]);
                            }
                        });
                    });
                }
          

                return h({
                    method: "post",
                    url: `${controller}SaveChanage`,
                    data: formData,
                    headers: {
                        'Content-Type': undefined
                    },
                });
            }





        };
    return functions;
}]);