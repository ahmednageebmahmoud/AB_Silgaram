/// <reference path="../../Shared/Module.js" />
myApp.service("serviceProducts", ["$http", function (h) {
    var controller = "/Products/",
        functions = {

            //Get Products
            getProducts(skip, take) {
                return h({
                    method: 'Get',
                    url: `${controller}GetProducts?skip=${skip}&take=${take}`,
                });
            },
            //Get Product
            getProduct(productId) {
                return h({
            method: 'Get',
            url: `${controller}GetProduct?productId=${productId}`,
    });
    },
            //save Change
            saveChange(data) {
                var formData = new FormData();

                var keys = [
                    "Id",
                    "State",
                    "NameAr",
                    "NameEn",
                    "DescriptionAr",
                    "DescriptionEn",
                    "Price"
                ];
                
                
                if (Array.isArray(data)) {
                    data.forEach((prod, index) => {
                        keys.forEach((key) => {
                            if (prod[key] != undefined) {
                                console.log(prod[key])
                                formData.append(`Products[${index}].${key}`, prod[key]);
                            }
                        });
                    });
                }
                else {
                    //Add Images
                    if (Array.isArray(data['Images'])) {
                        var index=0;
                        data['Images'].forEach((img) => {
                            if (img.State!=null) {

                            formData.append(`Products[0].Images[${index}].File`, img.File);
                            formData.append(`Products[0].Images[${index}].State`, img.State);
                            formData.append(`Products[0].Images[${index}].FileId`, img.FileId);

                            index++;
                        }
                            
                        });
                    }
                        //Add Data
                    keys.forEach((key) => {
                        if (data[key] != undefined) {
                            console.log(data[key])
                            formData.append(`Products[0].${key}`, data[key]);
                        }
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