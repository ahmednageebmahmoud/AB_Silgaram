/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlOfferCreateAndUpdate', ['$scope', '$http', '$filter', 'serviceOffers', 'serviceView', function (s, h, filter, service, serviceView) {

    //<!--Config-->
    var curentDate = new Date();
    s.Token = Token;
    s.State = State;
    s.NewImages = [];
    s.SkipProduct = 0;
    s.TakeProduct = 10;
    s.IsEditInStartDate = false;
    s.OfferId = getQueryStringValue("OfferId");
    s.IsUpdate = !IsNullOrEmptyOrUndefined(s.OfferId);
    s.Offer = {
        NewImages: [],
        'StartDateTime': new Date(curentDate.getYear(), curentDate.getMonth(), curentDate.getDate().toString())
    };
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

    //Get Offer
    s.getOffer = (isCallFroSaveChange) => {

        if (IsNullOrEmptyOrUndefined(s.OfferId)) return;
        startBlock();
        service.getOffer(s.OfferId).then((d) => {
            if (d.data == null || d.data == '')
                toastr.error(Token.OfferNotFound, Token.Error);

            s.Offer = d.data;
            s.Offer.StartDateTime = convartDateTimeToJavaScriptDateTime(s.Offer.StartDateTime);
            s.Offer.EndDateTime =convartDateTimeToJavaScriptDateTime(s.Offer.EndDateTime);
            s.NewImages = d.data.Images;


            co("R-getOffer", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error get Offer", error.data);
            stopBlock();
        });
    };
    s.getOffer(false);
 
   

    //Save Change
        s.saveChange = () => {
            s.Offer.State = s.IsUpdate ? State.Update : State.Create;
            s.Offer.Images = s.NewImages;


            console.log(s.Offer.StartDateTime);
            console.log(new Date());

            //Check StartDateTime Must Be More than Or Equal  current DateTime 
            if(s.IsUpdate&&s.IsEditInStartDate)
            if (s.Offer.StartDateTime <= new Date()) {
                toastr.error(Token.StartDateTimeMustBeMoreTthanOrEqualCurrent, Token.Error);
                return;
            }

            //Check EndDateTime Must Be More than StartDateTime 
            if (s.Offer.EndDateTime <= s.Offer.StartDateTime)
            {
                toastr.error(Token.EndDateTimeMustBeMoreThanStartDateTime, Token.Error);
                return;
            }

            s.Offer.StartDateTimeString = convertDateTimeToCSharpDateTime(s.Offer.StartDateTime);
          s.Offer.EndDateTimeString = convertDateTimeToCSharpDateTime(s.Offer.EndDateTime);

            //For Send To Server as Arry 
            var DataSave=[s.Offer];
        

        startBlock();
            service.saveChange(DataSave).then(d=> {
            co("R-SaveChange", d);
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                        toastr.success(d.data.Message, Token.Success);
                        s.OfferId = d.data.OfferId;
                        s.IsUpdate = true;
                        s.Offer = {};
                        s.getOffer(true);
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
                s.getOffer();
                s.getCategories();
                s.getSubCategories();
            }; s.callFunctions();

 

    //get Data More
    s.getDataMore = () => {
        if (s.Offer.IsStarted) {
            toastr.error(Token.ICanNotLoadProductsBecuseThisOfferIsStarted, Token.Error);
        }
      
    };

    //RemoveNewImage for new album with create category
    s.RemoveNewImage = (index) => {
        if (s.NewImages[index].State == 0) {
            s.NewImages[index].State = State.Delete;
        } else {
            s.NewImages.splice(index, 1)
        }
    };


    //ChangeStateImage 
    s.ChangeStateImage = (offerCategoryObject, image, index) => {
        switch (image.State) {
            case State.Create:
                offerCategoryObject.Images.splice(index, 1);
                break;
            case null:
            case undefined:
                image.State = State.Delete;
                break;
        }
    };



    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Offer, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);