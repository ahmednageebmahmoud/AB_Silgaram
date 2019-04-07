// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlUsers', ['$scope', '$http','$filter', 'serviceUsers', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.coutnUserTake = 10;
    s.coutnUserSkip = 0;
    s.Display = { UserName: true };
    //</!--Config-->

    //Get SocialStatus
    s.getSocialStatus = () => {
        startBlock();
        service.getSocialStatus().then((d) => {
            s.SocialStatus = d.data;
            co("R-getSocialStatus", d);
            stopBlock();
        }).catch((error) => {
            toastr.error(Token.ICantCallToServer + " " + Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Provinces
    s.getProvinces = () => {
        startBlock();
        service.getProvinces().then((d) => {
            s.Provinces = d.data;
            co("R-getProvinces", d);
            stopBlock();
        }).catch((error) => {
            toastr.error(Token.ICantCallToServer + " " + Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Countries
    s.getCountries = () => {
        startBlock();
        service.getCountries().then((d) => {
            s.Countries = d.data;
            co("R-getCountries", d);
            stopBlock();
        }).catch((error) => {
            toastr.error(Token.ICantCallToServer + " " + Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Jobs
    s.getJobs = () => {
        startBlock();
        service.getJobs().then((d) => {
            s.Jobs = d.data;
            co("R-getJobs", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Genders
    s.getGenders = () => {
        startBlock();
        service.getGenders().then((d) => {
            s.Genders = d.data;
            co("R-getGenders", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Users
    s.getUsers = () => {
        startBlock();
        service.getUsers(s.coutnUserTake, s.coutnUserSkip).then((d) => {
            if (d.data == null || d.data == "") {
                if (s.coutnUserTake>0)
                toastr.error(Token.NoDataMore)
            } else {

            s.Users = d.data;
            co("R-getUsers", d);
            s.coutnUserSkip += s.coutnUserTake;
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

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.Users, 'State', State.Create, State.Delete, State.Update);
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
                        s.getUsers();
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
        s.getUsers();
        s.getSocialStatus();
        s.getProvinces();
        s.getCountries();
        s.getJobs();
        s.getGenders();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Users, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);