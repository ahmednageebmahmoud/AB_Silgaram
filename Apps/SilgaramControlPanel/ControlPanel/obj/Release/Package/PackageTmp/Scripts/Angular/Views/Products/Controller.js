/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlProducts', ['$scope', '$http','$filter', 'serviceProducts', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Products = [];
    s.Skip = 0;
    s.Take = 10;
    s.NewImages = [];
    s.EditImages = [];

    //</!--Config-->

    //Get Products
    s.getProducts = () => {

        startBlock();
        service.getProducts(s.Skip, s.Take).then((d) => {
            if (d.data == null || d.data == "") {
                if (s.coutnUserTake > 0)
                    toastr.error(Token.NoDataMore)
            } else {

                s.Products = d.data;
                co("R-getProducts", d);
                s.Skip += s.Take;
            }
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };
 
    //Delete Confirm
    s.deleteConfirm = (id) => {
        s.deleteId = id;
        showDeleteConfirm();
    };

    //Delete
    s.delete = () => {
        if (s.deleteId != null) {
            s.Products.forEach((item, index) => {
                if (item.Id === s.deleteId) {
                    if (item.State == State.Create)
                        item.State = State.Delete
                    else
                        item.State = State.Delete
                    hideDeleteConfirm();
                    s.filter();
                }
            });
        }
    };

    //Cancel Delete
    s.cancelDelete = () => {
        hideDeleteConfirm();
        s.deleteId = null;
    };

    //Undo Delete
    s.undoDelete = product=> {
        if (product.Id.toString().includes('xNew'))
            product.State = State.Create;
        else
            product.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.Products, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length == 0) {

            toastr.error(Token.NoDataForSave,Token.Error);
            return;
        }

        startBlock();
        service.saveChange(dataForSave).then(d=> {
            co("R-SaveChange", d);
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                        toastr.success(d.data.Message, Token.Success);
                        s.Skip = 0;
                        s.Products = {};
                        s.getProducts();
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
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });

    };


    //Restart
    s.rest = () => {
       
    };


    //get Data More
    s.getDataMore = () => {
        s.getProducts();
    };


    //Call Functions
    s.callFunctions = () => {
        s.getProducts();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Products, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);