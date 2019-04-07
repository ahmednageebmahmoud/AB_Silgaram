myApp.controller("ctrlReports", ["$scope", "$http", "serviceReports", "serviceView", function (s, h, service, serviceView) {
    //<!--Config-->
    s.ShowEdit = -1;
    s.AdId = getQueryStringValue("AdId");
    s.Take = 10;
    s.Skip = 0;
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.Reports = [];
    //</!--Config-->

    //Get Reports
    s.getReports = function ( ) {
        if (IsNullOrEmptyOrUndefined(s.AdId)) return;
        startBlock();
        service.getReports(s.AdId, s.Take, s.Skip).then(function (d) {
            stopBlock();
            switch (d.data.RequestType) {
                case RequestType.Success: {
                    s.AdInformation = d.data.Data.AdInformation;
                    s.Reports = s.Reports.concat(d.data.Data.Reports);
                    s.Skip += s.Take;

                    console.log("Reports");
                    console.log(s.Reports);
                }
                    break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Info)
                }
                    break;
                case 3: {
                    toastr.warning(d.data.Message, Token.Info)
                }
                    break;
                case 4: {
                    toastr.info(d.data.Message,Token.Info)
                }
            }

        });
    };  

   
    //Save Chenage
    s.SaveChenage = function (userLogins) {
        startBlock();
        service.SaveChenage(userLogins).then(function (d) {
            stopBlock();
            switch (d.data.RequestType) {
                case RequestType.Success: {
                    toastr.success(d.data.Message, d.data.Title);
                    s.GetReports();
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
        s.getReports();
    };

    //Call Function
    s.CallFunctions = function () {
        s.getReports();
    }; s.CallFunctions();
}]);