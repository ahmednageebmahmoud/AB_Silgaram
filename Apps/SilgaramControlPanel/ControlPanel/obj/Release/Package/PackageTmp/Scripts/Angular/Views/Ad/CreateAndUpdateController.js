/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlAdCreateAndUpdate', ['$scope', '$http', '$filter', 'serviceAds', 'serviceView', function (s, h, filter, service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.NewImages = [];
    s.SkipProduct = 0;
    s.TakeProduct = 10;
    s.AdId = getQueryStringValue("AdId");
    s.IsUpdate = s.AdId != null && s.AdId != undefined && s.AdId != "";
    //</!--Config-->

    //Get Categories
    s.getCategories = () => {
        startBlock();
        service.getCategories().then((d) => {
            s.Categories = d.data;
            co("R-getCategories", d);
                s.SkipProduct += s.TakeProduct;
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error getCategories", error.data);
            stopBlock();
        });
    };

    //Get SubCategories
    s.getSubCategories = () => {
        startBlock();
        service.getSubCategories().then((d) => {
            s.SubCategories = d.data;
            co("R-SubCategories", d);
            s.SkipProduct += s.TakeProduct;
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error getCategories", error.data);
            stopBlock();
        });
    };

    //Get Ad
    s.getAd = (isCallFroSaveChange) => {

        startBlock();
        service.getAd(s.AdId).then((d) => {
            if (d.data == null || d.data == '')
                toastr.error(Token.AdNotFound, Token.Error);

            s.Ad = d.data;
            s.Ad.StartDateTime = new Date(parseInt(s.Ad.StartDateTime.substr(6)));
            s.Ad.EndDateTime = new Date(parseInt(s.Ad.EndDateTime.substr(6)));


            co("R-getAd", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error get Ad", error.data);
            stopBlock();
        });
    };
    s.getAd(false);
 
   

    //Save Change
        s.saveChange = () => {
            s.Ad.State = s.IsUpdate ? State.Update : State.Create;


            console.log(s.Ad.StartDateTime);
            console.log(new Date());

            //Check StartDateTime Must Be More than Or Equal  current DateTime 
            //if (s.Ad.StartDateTime <= new Date()) {
            //    toastr.error(Token.StartDateTimeMustBeMoreTthanOrEqualCurrent, Token.Error);
            //    return;
            //}

            //Check EndDateTime Must Be More than StartDateTime 
            //if (s.Ad.EndDateTime <= s.Ad.StartDateTime)
            //{
            //    toastr.error(Token.EndDateTimeMustBeMoreThanStartDateTime, Token.Error);
            //    return;
            //}

            //For Send To Server as Arry 
            var DataSave=[s.Ad];
        

        startBlock();
            service.saveChange(DataSave).then(d=> {
            co("R-SaveChange", d);
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                        toastr.success(d.data.Message, Token.Success);
                        s.AdId = d.data.AdId;
                        s.IsUpdate = true;
                        s.Ad = {};
                        s.getAd(true);
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
            co("Error SaveChange", error.data);
            stopBlock();
        });

    };

    //Call Functions
        s.callFunctions = () => {
            if (IsNullOrEmptyOrUndefined(s.AdId)) {
                toastr.error(Token.YouCanNotCreateNewAds,Token.Error)
            }
            else {

                s.getAd();
                s.getSubCategories();
                s.getCategories();
            }
            
            }; s.callFunctions();

 

    //get Data More
    s.getDataMore = () => {
        if (s.Ad.IsStarted) {
            toastr.error(Token.ICanNotLoadProductsBecuseThisAdIsStarted, Token.Error);
        }
      
    };


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Ad, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);