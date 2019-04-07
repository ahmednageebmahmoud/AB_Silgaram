/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlCommercialBanner', ['$scope', '$http','$filter', 'serviceCommercialBanner', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.CommercialBanner = [];
    s.Skip = 0;
    s.Take = 10;
    //</!--Config-->

    //Get CommercialBanner
    s.getCommercialBanner = () => {
        startBlock();
        service.getCommercialBanner(s.Skip,s.Take).then((d) => {
    
            switch (d.data.RequestType) {
                case RequestType.Info: {
                    toastr.info(d.data.Message, Token.Info);
                } break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Error);
                } break;
                default: {
                    s.CommercialBanner = s.CommercialBanner.concat(d.data);
                    s.Skip += s.Take;
                }
            }
            co("R-getCommercialBanner", d);
            stopBlock();
        }).catch((error) => {
            if(!navigator.onLine)
                toastr.error(Token.ICantCallToServer , Token.Error);

            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };


    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.CommercialBanner, 'State', State.Create, State.Delete, State.Update);
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
                        s.getCommercialBanner();
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

    //Call Functions
    s.callFunctions = () => {
        s.getCommercialBanner();
    }; s.callFunctions();

    
 
}]);