myApp.controller("ctrlUserLogins", ["$scope", "$http", "serviceUserLogins", "serviceView", function (s, h, service, serviceView) {
    //<!--Config-->
    s.ShowEdit = -1;
    s.UserSerialNo = getQueryStringValue("userSerial");
    s.Take = 10;
    s.Skip = 0;
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.UserLogins = [];
    //</!--Config-->


    //Get UserLogins
    s.getUserLogins = function ( ) {
        if (IsNullOrEmptyOrUndefined(s.UserSerialNo)) return;

        startBlock();
        service.getUserLogins(s.UserSerialNo, s.Take, s.Skip).then(function (d) {
            stopBlock();
            if (d.data==false){
                if (s.coutnUserTake > 0)
                    toastr.error(Token.UserNotFound, Token.error);
              //  s.UserLogins = [];

            } else if (d.data == '') {

                if (s.coutnUserTake > 0)
                    toastr.error(Token.NoDataMore)

            }
            else {
                s.UserLogins = s.UserLogins.concat(d.data);
                s.Skip += s.Take;
            }
            console.log("UserLogins");
            console.log(s.UserLogins);
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
                    s.GetUserLogins();
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
        s.UserLogin = {};
        s.IsSubmit = false;
    };

    //get Data More
    s.getDataMore = () =>{
        s.getUserLogins();
    };


    //Call Function
    s.CallFunctions = function () {
        s.getUserLogins();
    }; s.CallFunctions();
}]);