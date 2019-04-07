// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlUserCreateAndUpdate', ['$scope', '$http','$filter', 'serviceUsers', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.coutnUserTake = 10;
    s.coutnUserSkip = 0;
    s.UserSerialNo = getQueryStringValue("userSerial");
    s.IsUpdate = s.UserSerialNo != null && s.UserSerialNo != undefined && s.UserSerialNo!="";
    
    //</!--Config-->
    
    //Get SocialStatus
    s.getSocialStatus = () => {
        startBlock();
        service.getSocialStatus().then((d) => {
       
            s.SocialStatus = d.data;
            co("R-getSocialStatus", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
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
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
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
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
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

    //Get Provinces
    s.getProvinces = () => {
        startBlock();
        service.getProvinces().then((d) => {
            s.Provinces = d.data;
            co("R-getProvinces", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error getProvinces", error.data);
            stopBlock();
        });
    };
   
    //Get User For Update 
    s.getUserForUpdate = () => {
        if (!s.IsUpdate) return;

        startBlock();
        service.getUserForUpdate(s.UserSerialNo).then((d) => {
            switch (d.data.RequestType) {
                case RequestType.Error:
                    {
                        toastr.error(d.data.Message, Token.error)
                    }
                default:
                    {
                        s.User = d.data;
                        s.imageeReview = s.User.ImageUrl;
                    }
            }

            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error getUserForUpdate", error.data);
            stopBlock();
        });
    };

    //Get Languages 
    s.getLanguages = function () {
        startBlock();
        service.getLanguages().then(function (d) {
            stopBlock();
            s.Languages = d.data;
            co("Languages", s.Languages);
        });
    };

    

    //Get Roles 
    s.getRoles = function () {
        startBlock();
        service.getRoles().then(function (d) {
            stopBlock();
            s.Roles = d.data;
            co("Roles", s.Roles);
        });
    };

    //Create Phone
    s.createPhone = () => {
        if (s.User.PhoneNumbers == null || s.User.PhoneNumbers == undefined)
            s.User.PhoneNumbers = [];

        if (s.NewNumber != null) {
            s.User.PhoneNumbers.push({
                "State": State.Create,
                "Number": s.NewNumber,
            });
        }
        s.NewNumber = null;
    };

    //Remove Number
    s.removeNumber = (index) => {
        s.User.PhoneNumbers.splice(index, 1)
    };


    //Add Language
    s.addLanguage = () => {
        if (s.User.Languages == null || s.User.Languages == undefined)
            s.User.Languages = [];

        if (s.NewLanguage != null) {
            //Check Is Not dublicated
            if (s.checkDublicatedLanguage(s.NewLanguage.Id))
                return;

            //Update Defult In All Languages
            if (s.NewLanguage.IsDefault)
                s.User.Languages.forEach(lang=> {

                    lang.State = lang.State == State.Create ? State.Create : State.Update;
                    lang.IsDefault = false;

                });

            //Push Now
            s.User.Languages.push({
                "Id": "Xrm" + Math.random(),
                "FKLanguageType_Id": s.NewLanguage.Id,
                "State": State.Create,
                "IsDefault": s.NewLanguage.IsDefault,

            });
        }
        s.NewLanguage = null;
    };

    //Update Language
    s.updateLanguage = language => {
        if (!s.checkDublicatedLanguage(language.FKLanguageType_Id, language.Id)) {
            language.langIndex = -1;
            language.State = State.Update;
        }

        //Update Defult In All Languages
        if (language.IsDefault)
            s.User.Languages.forEach(lang=> {
                if (lang.Id != language.Id && lang.State != State.Delete) {

                    lang.State = lang.State == State.Create ? State.Create : State.Update;
                    lang.IsDefault = false;
                }

            });
    }

    //Check Dublicated Language
    s.checkDublicatedLanguage = (languageTypeId, languageUsingId) => {
        var check = false;

        if (languageUsingId != undefined) {

            s.User.Languages.forEach(lang=> {
                if (lang.Id != languageUsingId)
                    if (lang.FKLanguageType_Id == languageTypeId && lang.State != State.Delete)
                        check = true;
            });
        }
        else {
            s.User.Languages.forEach(lang=> {
                if (lang.FKLanguageType_Id == languageTypeId && lang.State != State.Delete)
                    check = true;
            });
        }

        if (check)
            toastr.error(Token.CanNotDublicatedLanguage);



        return check;
    };  

    //Remove Language
    s.removeLanguage = (index) => {
        s.User.Languages.splice(index, 1)
    };

    //

    //Add Role
    s.addRole = () => {
        if (s.User.UserRoles == null || s.User.UserRoles == undefined)
            s.User.UserRoles = [];

        if (s.NewRole != null) {
            //Check Is Not dublicated
            if (s.checkDublicatedRole(s.NewRole.Id))
                return;

            //Push Now
            s.User.UserRoles.push({
                "Id": "Xrm" + Math.random(),
                "FkRole_Id": s.NewRole.Id,
                "State": State.Create,

            });
        }
        s.NewRole = null;
    };


    //Update Role
    s.updateRole = role => {
        if (!s.checkDublicatedRole(role.FkRole_Id, role.Id)) {
            role.langIndex = -1;
            role.State = State.Update;
        }
    }

    //Check Dublicated Role
    s.checkDublicatedRole = (roleId, languageUsingId) => {
        var check = false;

        if (languageUsingId != undefined) {

            s.User.UserRoles.forEach(role=> {
                if (role.Id != languageUsingId)
                    if (role.FkRole_Id == roleId && role.State != State.Delete)
                        check = true;
            });
        }
        else {
            s.User.UserRoles.forEach(role=> {
                if (role.FkRole_Id == roleId && role.State != State.Delete)
                    check = true;
            });
        }

        if (check)
            toastr.error(Token.CanNotDublicatedRole);
                return check;
    };

    //Remove Role
    s.removeRole = (index) => {
        s.User.UserRoles.splice(index, 1)
    };

    //Save Change
    s.saveChange = () => {
        if (s.User.NewPassword !== s.User.ConfirmPassword) {
            toastr.warning(Token.ErrorConfirmPassword, Token.Warning);
            return;
        }

        //Check Date
        if (!IsNullOrEmptyOrUndefined(s.User.dd)||!IsNullOrEmptyOrUndefined(s.User.mm)||!IsNullOrEmptyOrUndefined(s.User.yyyy))
        if (!checkvaliddate(s.User.dd, s.User.mm, s.User.yyyy)) {
            toastr.warning(Token.InvalidDate, Token.Warning);
            return;
        } else {
            s.User.BirthDate = s.User.mm + "/" + s.User.dd + "/" + s.User.yyyy;
        }

        startBlock();
        service.saveChange(s.User,s.myImage,s.IsUpdate).then(d=> {
            co("R-SaveChange", d);
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                        toastr.success(d.data.Message, Token.Success);
                        if (s.IsUpdate)
                            s.getUserForUpdate();
                        else {
                            s.IsUpdate = true;
                            s.User = d.data.User;
                            s.UserSerialNo = s.User.Serial;
                        }
                    }
                    break;
                case RequestType.Error:
                    {
                        toastr.error(d.data.Message, Token.Error);
                        co("ErrorSave",d.data)
                    }
                    break;
                case 3:
                    {
                        toastr.warning(d.data.Message, Token.warning);

                    }
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
        s.getUserForUpdate();
        s.getSocialStatus();
        s.getCountries();
        s.getJobs();
        s.getGenders();
        s.getLanguages();
        s.getRoles();
        s.getProvinces();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Users, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);