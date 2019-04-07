/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlProductCreateAndUpdate', ['$scope', '$http', '$filter', 'serviceProducts', 'serviceView', function (s, h, filter, service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.NewImages = [];
    s.ProductId = getQueryStringValue("productId");
    s.IsUpdate = s.ProductId != null && s.ProductId != undefined && s.ProductId != "";
    //</!--Config-->

    //Get Product
    s.getProduct = () => {
        if (!s.IsUpdate)
            return;
        startBlock();
        service.getProduct(s.ProductId).then((d) => {
            switch (d.data.RequestType) {
                case RequestType.Error:
                    {
                        toastr.error(d.data.Message, Token.Error);
                    }
                default: {
                    s.Product = d.data;
                    s.NewImages = d.data.Images;
                    co("R-getProduct", d);
                }

            }
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error get Product", error.data);
            stopBlock();
        });
    };
    s.getProduct();
 
    //Save Change
    s.saveChange = () => {
        s.Product.State = s.IsUpdate ? State.Update : State.Create;
        s.Product.Images = s.NewImages;

        startBlock();
        service.saveChange(s.Product).then(d=> {
            co("R-SaveChange", d);
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                        toastr.success(d.data.Message, Token.Success);
                        s.ProductId = d.data.ProductId;
                        s.IsUpdate = true;
                        s.getProduct();
                        s.Product = {};
                    }
                    break;
                case RequestType.Error:
                    {
                        toastr.error(d.data.Message, Token.Error);
                    }
                    break;
                case 3:
                    break;
            }
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error SaveChange", error.data);
            stopBlock();
        });

    };

    //Call Functions
    s.callFunctions = () => {
        s.getProduct();
    }; s.callFunctions();


    //RemoveNewImage for new album with create category
    s.RemoveNewImage = (index) => {
        if (s.NewImages[index].State == null) {
            s.NewImages[index].State = State.Delete;
        } else {
            s.NewImages.splice(index, 1)
        }
    };



    //ChangeStateImage 
    s.ChangeStateImage = (offerCategoryObject, image, index) => {
        switch (image.State) {
            case State.Create:
                offerCategoryObject.Images.splice(index, 1);
                break;
            case null:
            case undefined:
                image.State = State.Delete;
                break;
        }
    };




    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Products, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);