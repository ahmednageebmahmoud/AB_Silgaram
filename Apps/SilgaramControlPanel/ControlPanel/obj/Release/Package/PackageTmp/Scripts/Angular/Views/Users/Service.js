/// <reference path="../../Shared/Module.js" />
myApp.service("serviceUsers", ["$http", function (h) {
    var controller = "/Users/",
        functions = {

            //Get Genders
            getGenders() {
                return h({
                    method: 'Get',
                    url: `${controller}getGenders`,
                });
            },
            //Get Jobs
            getJobs() {
                return h({
                    method: 'Get',
                    url: `${controller}GetJobs`,
                });
            },
            //Get Countries
            getCountries() {
                return h({
                    method: 'Get',
                    url: `${controller}getCountries`,
                });
            },
            //Get Provinces
            getProvinces() {
                return h({
                    method: 'Get',
                    url: `${controller}GetProvinces`,
                });
            },

            //Get SocialStatus
            getSocialStatus() {
                return h({
                    method: 'Get',
                    url: `${controller}getSocialStatus`,
                });
            },
               
            //Get Languages
            getLanguages  () {
                return h({
                    method: "Get",
                    url: `${controller}GetLanguages`
                });
            },
            //Get Users
            getUsers(coutnUserTake, coutnUserSkip) {
                return h({
                    method: 'Get',
                    url: `${controller}GetUsers?coutnUserTake=${coutnUserTake}&coutnUserSkip=${coutnUserSkip}`,
                });
            },
            //Get User For Update
            getUserForUpdate(serial) {
                return h({
                    method: 'Get',
                    url: `${controller}GetUserForUpdate?serial=${serial}`,
                });
            },
            //Get User For Update
            getRoles() {
                return h({
                    method: 'Get',
                    url: `${controller}GetRoles`,
                });
            },
            
            //save Change
            saveChange(user, image, isUpdate) {
                var formData =new    FormData();
                if (image!=undefined) 
                    formData.append("image", image);

                var keys = [
                    "Id",
                    "Serial",
                "Email",
                "UserName",
            "BirthDate",
            "FirstName",
            "MediumName",
            "LastName",
            "NationalId",
            "FkAddress_Id",
            "FKJob_Id",
                "FKGender_Id",
                "FkProvince_Id",
            "FKSocialStatus_Id",
            "City",
            "FKCountry_Id",
            "PostalCode",
            "Street1",
            "Street2",
            "CurrentPassword",
            "NewPassword",
            "ConfirmPassword",
            "IsBlocked",
            "Points"


                ,
                ],index=0;


                //add UserRoles
                if (user.UserRoles != null && user.UserRoles != undefined)
                    user.UserRoles.forEach((role) => {
                    if (role.State != null) {
                        formData.append(`userRoles[${index}].Id`, role.Id);
                        formData.append(`userRoles[${index}].FkRole_Id`, role.FkRole_Id);
                        formData.append(`userRoles[${index}].State`, role.State);
                        index++;
                    }

                });

                index = 0;
                //add Phone Numbers
                if (user.PhoneNumbers != null && user.PhoneNumbers!=undefined)
                user.PhoneNumbers.forEach((phone) => {
                    if (phone.State != null) {
                        formData.append(`PhoneNumbers[${index}].Id`, phone.Id);
                        formData.append(`PhoneNumbers[${index}].Number`, phone.Number);
                        formData.append(`PhoneNumbers[${index}].State`, phone.State);
                        index++;
                    }
                });

                index=0;
                //add Languages
                if (user.Languages != null && user.Languages != undefined)
                    user.Languages.forEach((lang) => {
                    if (lang.State != null) {
                        formData.append(`Languages[${index}].Id`, lang.Id);
                        formData.append(`Languages[${index}].FKLanguageType_Id`, lang.FKLanguageType_Id);
                        formData.append(`Languages[${index}].IsDefault`, lang.IsDefault);
                        formData.append(`Languages[${index}].State`, lang.State);
                        index++;
                    }
                });

                keys.forEach(function (key) {
                    
                        if (user[key] != undefined) {
                            formData.append(key, user[key]);
                        }
                });
                formData.append(`isUpdate`, isUpdate);
                return h({
                    method: "post",
                    url: `${controller}SaveChanage`,
                    data: formData,
                    headers: {
                        'Content-Type': undefined
                    },
                });
            }



        };
    return functions;
}]);