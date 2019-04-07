myApp.controller("ctrlUserPointPackages", ["$scope", "$http", "serviceUserPointPackages", "serviceView", function (s, h, service, serviceView) {
    //<!--Config-->
    s.ShowEdit = -1;
    s.PointPackageId = getQueryStringValue("pointPackageId");
    s.UserSerial = getQueryStringValue("UserSerial");
    s.NotifyId = getQueryStringValue("notifyId");
    s.Take = 10;
    s.Skip = 0;
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.UserPointPackages = [];
    //</!--Config-->

    ``
    //Check User Allow For This Notify
    s.checkUserAllowForThisNotify = () => {
        if (IsNullOrEmptyOrUndefined(s.NotifyId)) {
            s.getUserPointPackages();
            return;
        }
        startBlock();
        service.checkUserAllowForThisNotify(s.NotifyId).then((d) => {
            switch (d.data.RequestType) {
                case RequestType.Success: {
                    //Get UserPointPackages
                    s.getUserPointPackages();
                } break;
                case RequestType.Error: {
                    //Show Alert
                    toastr.error(d.data.Message, Token.Error);
                }
            }
            co("R-checkUserAllowForThisNotify", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error checkUserAllowForThisNotify", error.data);
            stopBlock();
        });
    };


    //Get UserPointPackages
    s.getUserPointPackages = function ( ) {
        if (IsNullOrEmptyOrUndefined(s.PointPackageId)) return;

        startBlock();
        service.getUserPointPackages(s.PointPackageId, s.NotifyId, s.Take, s.Skip).then(function (d) {
            stopBlock();

            switch (d.data.RequestType) {
                case RequestType.Info:
                    {
                    toastr.info(d.data.Message, Token.Info);
                    } break;
                case RequestType.Error:
                    {
                        toastr.error(d.data.Message, Token.Error);
                    } break;
                default: {
                    s.PointPackage = d.data.PointPackage;
                    s.UserPointPackages = s.UserPointPackages.concat(d.data.UserPointPackages);
                    s.Skip += s.Take;
                }
            }
            console.log("UserPointPackages");
            console.log(s.UserPointPackages);
        });
    };  

 

    //Save Chenage
    s.SaveChenage = function (userLogins) {
        startBlock();
        service.SaveChenage(userLogins).then(function (d) {
            stopBlock();
            switch (d.data.AlertType) {
                case RequestType.Success: {
                    toastr.success(d.data.Message, d.data.Title);
                    s.GetUserPointPackages();
                    hideDeleteConfirm();
                }
                    break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, d.data.Title)

                }
                    break;
                case 3: {
                    toastr.warning(d.data.Message, d.data.Title)

                }
                    break;
                case 4: {
                    toastr.info(d.data.Message, d.data.Title)

                }
            }
        });
    };


    //get Data More
    s.getDataMore = () =>{
        s.getUserPointPackages();
    };

    s.checkUserAllowForThisNotify();


    //Call Function
    s.CallFunctions = function () {
    }; s.CallFunctions();
}]);