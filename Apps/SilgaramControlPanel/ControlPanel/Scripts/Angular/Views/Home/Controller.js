/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlHome', ['$scope', '$http','$filter', 'serviceHome', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    //</!--Config-->

    //Get Home
    s.getHomeDate = () => {
        startBlock();
        service.getHomeData().then((d) => {
            s.HomeInfromation = d.data;
            co("R-getHomeDate", s.HomeInfromation);
            stopBlock();

        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("getHomeDate", error.data);
            stopBlock();
        });
    };

 
    //Call Functions
    s.callFunctions = () => {
        s.getHomeDate();
    }; s.callFunctions();


    window.onload = () => {
    }
}]);