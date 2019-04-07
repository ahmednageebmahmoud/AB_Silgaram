/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlLogin', ['$scope', '$http', 'serviceLogin', function (s,h,service) {

    //<!--Config-->

    //</!--Config-->

    //Login
    s.login = () => {
        s.rest();
        service.Login(s.userDatalogin, getQueryStringValue("ReturnUrl")).then(d=> {
            co("R-Login", d);
            debugger;
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                         window.location.href = d.data.ReturnUrl;
                    }
                    break;
                case RequestType.Error:
                    {
                        toastr.error(d.data.Message, Token.Error);

                        s.showAlertMessage = true;
                        s.AlertMessage = d.data.Message;
                    }
                    break;
                case 3:
                    break;
            }
        }).catch((error) => {
            //I Can't Login 
            s.showAlertMessage = true;
            s.AlertMessage = Token.ICantCallToServer;

            toastr.error(Token.ICantCallToServer, Token.Error);
            co("Error Login", error.data);

        });
    };

    //Restart
    s.rest = () => {
        s.showAlertMessage = false;
        s.AlertMessage = null;
    };




}]);