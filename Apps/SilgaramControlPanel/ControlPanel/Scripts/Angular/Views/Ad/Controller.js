/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlAds', ['$scope', '$http','$filter', 'serviceAds', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Ads = [];
    s.Skip = 0;
    s.Take = 10;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.NewImages = [];
    s.EditImages = [];




    //</!--Config-->

    //Get Ads
    s.getAds = () => {
        startBlock();
        service.getAds(s.Skip, s.Take).then((d) => {
            switch (d.RequestType) {
                case RequestType.Info:
                    toastr.info(d.data.Message);
                    break;
                default:
                    {
                        if (Array.isArray(d.data))
                        s.Ads =s.Ads.concat(d.data);
                s.Skip += s.Take;
                    }
            }
                co("R-getAds", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);

            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error getAds", error.data);
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
            s.Ads.forEach((item, index) => {
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
        var dataForSave = filter('filterIsEquals')(s.Ads, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length == 0) {

            toastr.error(Token.NoDataForSave,Token.Error);
            return;
        }

        startBlock();
        service.saveChange2(dataForSave).then(d=> {
            co("R-SaveChange", d);
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                        toastr.success(d.data.Message, Token.Success);
                        s.Skip = 0;
                        s.Ads = [];
                        s.getAds();
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
        s.getAds();
    };


    //Call Functions
    s.callFunctions = () => {
        s.getAds();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Ads, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);