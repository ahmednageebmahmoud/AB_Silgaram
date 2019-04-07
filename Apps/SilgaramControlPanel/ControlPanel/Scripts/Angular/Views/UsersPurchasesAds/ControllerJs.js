myApp.controller("ctrlUsersPurchasesAds", ["$scope", "$http", "serviceUsersPurchasesAds", "serviceView", function (s, h, service, serviceView) {
    //<!--Config-->
    s.ShowEdit = -1;
    s.AdId = getQueryStringValue("AdId");
    s.Take = 10;
    s.Skip = 0;
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.UsersPurchasesAds = [];
    //</!--Config-->


    //Get UsersPurchasesAds
    s.getUsersPurchasesAds = function (callFromPage ) {
        if (IsNullOrEmptyOrUndefined(s.AdId)) return;

        if (callFromPage) {
            s.UsersPurchasesAds = [];
            s.Skip = 0;
        }

        startBlock();
        service.getUsersPurchasesAds(s.AdId, s.Take, s.Skip).then(function (d) {
            stopBlock();
            if (d.data == false || d.data=='') {
                    toastr.info(Token.NoDataMore)
            }
            else {
                s.UsersPurchasesAds = s.UsersPurchasesAds.concat(d.data);
                s.Skip += s.Take;
            }
            console.log("UsersPurchasesAds");
            console.log(s.UsersPurchasesAds);
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
                    s.GetUsersPurchasesAds();
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

    

        
    //Restart
    s.Restart = function () {
        s.UsersPurchasesAd = {};
        s.IsSubmit = false;
    };

    //get Data More
    s.getDataMore = () =>{
        s.getUsersPurchasesAds();
    };


    //Call Function
    s.CallFunctions = function () {
        s.getUsersPurchasesAds();
    }; s.CallFunctions();
}]);