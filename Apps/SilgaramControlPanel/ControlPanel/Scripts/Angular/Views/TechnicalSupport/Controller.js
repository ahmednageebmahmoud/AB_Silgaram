/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlTechnicalSupport', ['$scope', '$http','$filter', 'serviceTechnicalSupport', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.TechnicalSupport = [];
    s.Skip = 0;
    s.Take = 10;
    //</!--Config-->

    //Get TechnicalSupport
    s.getTechnicalSupport = () => {
        startBlock();
        service.getTechnicalSupport(s.Skip,s.Take).then((d) => {
    
            switch (d.data.RequestType) {
                case RequestType.Info: {
                    toastr.info(d.data.Message, Token.Info);
                } break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Error);
                } break;
                default: {
                    s.TechnicalSupport = s.TechnicalSupport.concat(d.data);
                    s.Skip += s.Take;
                }
            }
            co("R-getTechnicalSupport", d);
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
        var dataForSave = filter('filterIsEquals')(s.TechnicalSupport, 'State', State.Create, State.Delete, State.Update);
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
                        s.getTechnicalSupport();
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
        s.getTechnicalSupport();
    }; s.callFunctions();

    
 
}]);