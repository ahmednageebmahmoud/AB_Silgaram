/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlOffers', ['$scope', '$http','$filter', 'serviceOffers', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Offers = [];
    s.Skip = 0;
    s.Take = 10;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.NewImages = [];
    s.EditImages = [];

    //</!--Config-->

    //Get Offers
    s.getOffers = (ifCallingFromPage) => {
        startBlock();
        service.getOffers(s.Skip, s.Take).then((d) => {
            switch (d.data.RequestType) {
                case RequestType.Info:
                    toastr.info(d.data.Message);
                    break;
                default:
                    {
                        s.Offers = d.data;
                        s.Skip += s.Take;
                    }
            }
                co("R-getOffers", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);

            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error getOffers", error.data);
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
            s.Offers.forEach((item, index) => {
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
        var dataForSave = filter('filterIsEquals')(s.Offers, 'State', State.Create, State.Delete, State.Update);
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
                        s.Offers = {};
                        s.getOffers();
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
            co("Error saveChange", error.data);
            stopBlock();
        });

    };


    //Restart
    s.rest = () => {
       
    };


    //get Data More
    s.getDataMore = () => {
        s.getOffers(true);
    };


    //Call Functions
    s.callFunctions = () => {
        s.getOffers();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Offers, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);