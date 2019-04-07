myApp.controller("ctrlUsersPurchasesOffers", ["$scope", "$http", "serviceUsersPurchasesOffers", "serviceView", function (s, h, service, serviceView) {
    //<!--Config-->
    s.ShowEdit = -1;
    s.OfferId = getQueryStringValue("OfferId");
    s.Take = 10;
    s.Skip = 0;
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.UsersPurchasesOffers = [];
    //</!--Config-->


    //Get UsersPurchasesOffers
    s.getUsersPurchasesOffers = function (callFromPage ) {
        if (IsNullOrEmptyOrUndefined(s.OfferId)) return;

        if (callFromPage) {
            s.UsersPurchasesOffers = [];
            s.Skip = 0;
        }

        startBlock();
        service.getUsersPurchasesOffers(s.OfferId, s.Take, s.Skip).then(function (d) {
            stopBlock();
            if (d.data == false || d.data=='') {
                    toastr.info(Token.NoDataMore)
            }
            else {
                s.UsersPurchasesOffers = s.UsersPurchasesOffers.concat(d.data);
                s.Skip += s.Take;
            }
            console.log("UsersPurchasesOffers");
            console.log(s.UsersPurchasesOffers);
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
                    s.GetUsersPurchasesOffers();
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
        s.UsersPurchasesOffer = {};
        s.IsSubmit = false;
    };

    //get Data More
    s.getDataMore = () =>{
        s.getUsersPurchasesOffers();
    };


    //Call Function
    s.CallFunctions = function () {
        s.getUsersPurchasesOffers();
    }; s.CallFunctions();
}]);