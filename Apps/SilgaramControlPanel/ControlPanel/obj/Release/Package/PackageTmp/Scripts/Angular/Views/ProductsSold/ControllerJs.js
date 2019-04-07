myApp.controller("ctrlProductsSold", ["$scope", "$http", "serviceProductsSold", "serviceView", function (s, h, service, serviceView) {
    //<!--Config-->
    s.ShowEdit = -1;
    s.ProductId = getQueryStringValue("productId");
    s.UserSerial = getQueryStringValue("UserSerial");
    s.NotifyId = getQueryStringValue("notifyId");
    s.Take = 10;
    s.Skip = 0;
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.ProductsSold = [];
    //</!--Config-->


    //Check User Allow For This Notify
    s.checkUserAllowForThisNotify = () => {
        if (IsNullOrEmptyOrUndefined(s.NotifyId)) {
            s.getProductsSold();
            return;
        }
        startBlock();
        service.checkUserAllowForThisNotify(s.NotifyId).then((d) => {
            switch (d.data.RequestType) {
                case RequestType.Success: {
                    //Get ProductsSold
                    s.getProductsSold();
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
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error checkUserAllowForThisNotify", error.data);
            stopBlock();
        });
    };


    //Get ProductsSold
    s.getProductsSold = function ( ) {
        if (IsNullOrEmptyOrUndefined(s.ProductId)) return;

        startBlock();
        service.getProductsSold(s.ProductId, s.NotifyId, s.Take, s.Skip).then(function (d) {
            stopBlock();

            switch (d.data.RequestType) {
                case RequestType.Info: {
                    toastr.info(d.data.Message, Token.Info);
                } break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Error);
                } break;
                default: {
                    s.ProductsSold = s.ProductsSold.concat(d.data);
                    s.Skip += s.Take;
                }
            }
            console.log("ProductsSold");
            console.log(s.ProductsSold);
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
                    s.GetProductsSold();
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
        s.getProductsSold();
    };

    s.checkUserAllowForThisNotify();


    //Call Function
    s.CallFunctions = function () {
    }; s.CallFunctions();
}]);