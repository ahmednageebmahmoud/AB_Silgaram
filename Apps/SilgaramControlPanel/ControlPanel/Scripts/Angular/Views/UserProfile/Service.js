myApp.service("serviceUserProfile", ["$http", function (h) {
    var fun = {},
        Controller = "/UserProfile/";

    //getUserData
    fun.getUserData = function () {
        return h({
            method: "Get",
            url: Controller + "GetUserData"
        });
    };
    //Get User Data For Update
    fun.getUserDataForUpdate = function () {
        return h({
            method: "Get",
            url: Controller + "GetUserDataForUpdate"
        });
    };
    //Get Jobs
    fun.getJobs = function () {
        return h({
            method: "Get",
            url: Controller + "GetJobs"
        });
    };


    //Get Provinces
    fun.getProvinces=function() {
        return h({
            method: 'Get',
            url: Controller+'GetProvinces',
        });
    };
    //Get Roles
    fun.getRoles = function () {
        return h({
            method: "Get",
            url: Controller + "GetRoles"
        });
    };

    
    //Get Languages
    fun.getLanguages = function () {
        return h({
            method: "Get",
            url: Controller + "GetLanguages"
        });
    };

    //Get Countries
    fun.getCountries = function () {
        return h({
            method: "Get",
            url: Controller + "GetCountries"
        });
    };
    
    //Get SocialStatuses
    fun.getSocialStatuses = function ( ) {
        return h({
            method: "Get",
            url: Controller + "GetSocialStatuses"
        });
    };


    //Get Genders 
    fun.getGenders = function () {
        return h({
            method: "Get",
            url: Controller + "GetGenders"
        });
    };

    // SaveChange
    fun.SaveChange = function (userViewModel,image) {
        var formData =new    FormData();
        if (image!=undefined) 
        formData.append("image", image);

        var keys = [
        "Email",
    "BirthDate",
    "FirstName",
    "MediumName",
    "LastName",
    "PhoneNumber",
    "NationalId",
    "FkAddress_Id",
    "FKJob_Id",
        "FKGender_Id",
                "FkProvince_Id",
    "FKSocialStatus_Id",
    "NameAr",
    "City",
    "FKCountry_Id",
    "PostalCode",
    "Street",
    "CurrentPassword",
    "NewPassword",
             "Street1",
            "Street2",
    "ConfirmPassword",
        ];

        //add Languages
        if (userViewModel.Languages != null && userViewModel.Languages != undefined)
            userViewModel.Languages.forEach((lang, index) => {
            formData.append(`Languages[${index}].Id`, lang.Id);
            formData.append(`Languages[${index}].FKLanguageType_Id`, lang.FKLanguageType_Id);
            formData.append(`Languages[${index}].IsDefault`, lang.IsDefault);
            formData.append(`Languages[${index}].State`, lang.State);
        });

    

        keys.forEach(function (key) {
            
                if (userViewModel[key] != undefined) {
                    formData.append(key, userViewModel[key]);
                }
        });
        return h({
            method: "post",
            url: Controller + "SaveChange",
            data: formData,
            headers: {
                'Content-Type': undefined
            },
        });
    };
    return fun;
}]);