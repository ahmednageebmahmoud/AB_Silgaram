myApp.controller("ctrlUserProfile", ["$scope", "$http", "serviceUserProfile", function (s, h, service) {
    //Config
    s.page = 1;
    s.State = State;


    //getUserData
  
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
    //Get User Data For Update
    s.getUserDataForUpdate = function () {
        if (s.UserViewModel!==undefined)
            return;

        startBlock();

        service.getUserDataForUpdate().then(function (d) {
            stopBlock();

            s.UserViewModel = d.data;

            co("UserViewModel", s.UserViewModel);


            
            s.imageeReview = s.UserViewModel.ImageUrl;
            
        });
    };

    //Get Jobs
    s.getJobs = function () {
        startBlock();
        service.getJobs().then(function (d) {
            stopBlock();
            s.AllJobs = d.data;
            co("AllJobs", s.AllJobs);
        });
    }; 


    //Get Role
    s.getRoles = function () {

        service.getRoles().then(function (d) {
            s.AllRole = d.data;
            co("AllRole", s.AllRole);
        });
    };

    //Get Countries
    s.getCountries = function () {
        startBlock();
        service.getCountries().then(function (d) {
            stopBlock();
            s.Countries = d.data;
            co("Countries", s.Countries);
        });
    }; 

 
 
    //Get Social Statuses 
    s.getSocialStatuses = function ( ) {
        startBlock();
        service.getSocialStatuses().then(function (d) {
            stopBlock();
            s.SocialStatuses = d.data;
            co("SocialStatuses", s.SocialStatuses);
        });
    };

    //Get Genders 
    s.getGenders = function ( ) {
        startBlock();
        service.getGenders().then(function (d) {
            stopBlock();
            s.Genders = d.data;
            co("Genders", s.Genders);
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
    
    //Create Phone
    s.createPhone = () => {
        if (s.UserViewModel.PhoneNumbers == null || s.UserViewModel.PhoneNumbers == undefined)
            s.UserViewModel.PhoneNumbers = [];

        if (s.NewNumber != null) {
            s.UserViewModel.PhoneNumbers.push({
                "State": State.Create,
                "Number": s.NewNumber,
            });
        }
        s.NewNumber = null;
    };

    //Remove Number
    s.removeNumber=(index)=>{
         s.UserViewModel.PhoneNumbers.splice(index, 1)
    };


    //Add Language
    s.addLanguage = () => {
        if (s.UserViewModel.Languages == null || s.UserViewModel.Languages == undefined)
            s.UserViewModel.Languages = [];

        if (s.NewLanguage != null) {
            //Check Is Not dublicated
            if (s.checkDublicatedLanguage(s.NewLanguage.Id)) 
                return;

            //Update Defult In All Languages
            if (s.NewLanguage.IsDefault)
                s.UserViewModel.Languages.forEach(lang=> {
                  
                    lang.State =lang.State==State.Create?State.Create: State.Update;
                lang.IsDefault = false;

            });

            //Push Now
            s.UserViewModel.Languages.push({
                "Id": "Xrm"+Math.random() ,
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
            s.UserViewModel.Languages.forEach(lang=> {
                if (lang.Id != language.Id && lang.State!=State.Delete) {

                lang.State = lang.State == State.Create ? State.Create : State.Update;
                lang.IsDefault = false;
                }

            });
    }   

    //Check Dublicated Language
    s.checkDublicatedLanguage =(languageTypeId,languageUsingId)=> {
        var check = false;

        if (languageUsingId != undefined) {

            s.UserViewModel.Languages.forEach(lang=> {
                if (lang.Id != languageUsingId)
                    if (lang.FKLanguageType_Id == languageTypeId && lang.State != State.Delete)
                        check = true;
            });
        }
        else {
            s.UserViewModel.Languages.forEach(lang=> {
                if (lang.FKLanguageType_Id == languageTypeId && lang.State != State.Delete)
                    check = true;
            });
        }

        if(check)
            toastr.error(Token.CanNotDublicatedLanguage);



        return check;
    };

    //Remove Language
    s.removeLanguage = (index) => {
        s.UserViewModel.Languages.splice(index, 1)
    };

    // SaveChange
    s.SaveChange = function (UserViewModel) {
        if (UserViewModel.NewPassword !== UserViewModel.ConfirmPassword) {
            toastr.warning(s.ErrorConfirmPassword, s.WarningTitle);
            return;
        }

        //Check Date
        if (!checkvaliddate(UserViewModel.dd, UserViewModel.mm, UserViewModel.yyyy)) {
            toastr.warning(s.InvalidDate, s.WarningTitle);
            return;
        } else {
            UserViewModel.BirthDate = UserViewModel.mm + "/" + UserViewModel.dd + "/" + UserViewModel.yyyy;
        }



        startBlock();

        service.SaveChange(UserViewModel, s.myImage).then(function (d) {
            stopBlock();
            switch (d.data.RequestType) {
                case RequestType.Success: {
                    toastr.success(d.data.Message, Token.Success);
                    s.getUserDataForUpdate();
                    hideDeleteConfirm();
                }
                    break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Error);
                    co("ErrorSave", d.data)

                }
                    break;
            }
        }).catch((error)=>{
            stopBlock();
            toastr.error(Token.Error,Token.Error);
        });
    };

    //Call Function
    s.CallFunctions = function () {
        s.getProvinces();
        s.getSocialStatuses();
        s.getGenders();
        s.getJobs();
        s.getCountries();
        s.getLanguages();
        s.getUserDataForUpdate();

    }; s.CallFunctions();
    s.getRoles();


}]);