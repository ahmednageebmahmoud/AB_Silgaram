/// <reference path="../../Shared/Module.js" />
myApp.service("serviceSubCategories", ["$http", function (h) {
    var controller = "/SubCategories/",
        functions = {

            //Get Categories
            getCategories() {
                return h({
                    method: 'Get',
                    url: `${controller}GetCategories`,
                });
            },
            //Get SubCategories
            getSubCategories(categoryId) {
                return h({
                    method: 'Get',
                    url: `${controller}GetSubCategories?categoryId=${categoryId}`,
                });
            },
            //save Change
            //save Change
            saveChange(adData) {
                var Keyes = [
                "Id",
                "NameAr",
                "NameEn",
                "NewFile",
                "State",
                "FkCategory_Id"
                ],
                formData = new FormData();

                //Ad Another Values
                adData.forEach((ad, index) => {
                    Keyes.forEach(key=> {
                        if (ad[key] != undefined)
                            formData.append(`subCategories[${index}].${key}`, ad[key]);
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