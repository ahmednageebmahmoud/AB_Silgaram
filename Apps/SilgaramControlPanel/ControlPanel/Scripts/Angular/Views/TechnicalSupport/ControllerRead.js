/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlTechnicalSupport', ['$scope', '$http','$filter', 'serviceTechnicalSupport', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.TechnicalSupport = null;
    s.TechnicalSupportId = getQueryStringValue("id");
    //</!--Config-->

    //Get TechnicalSupport
    s.getTechnicalSupport = () => {
        startBlock();
        service.getTechnicalSupportDetails(s.TechnicalSupportId).then((d) => {
    
            switch (d.data.RequestType) {
                case RequestType.Info: {
                    toastr.info(d.data.Message, Token.Info);
                } break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Error);
                } break;
                default: {
                    s.TechnicalSupport = d.data;
                }
            }
            co("R-getTechnicalSupport", s.TechnicalSupport);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
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