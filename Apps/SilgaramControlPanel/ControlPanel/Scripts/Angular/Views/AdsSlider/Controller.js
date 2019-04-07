/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlAdsSlider', ['$scope', '$http','$filter', 'serviceAdsSlider', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.PositionTypes = PositionTypes;
    s.AdsSlider = [];
    s.AdSliderImageUpdateReview = null;
    s.AdSliderImageUpdate = null;
    s.PositionTypes=[
{'Id':PositionTypes.P1 ,'Name':'1'},
{ 'Id': PositionTypes.P2, 'Name': '2' },
{ 'Id': PositionTypes.P3, 'Name': '3' },
{ 'Id': PositionTypes.P4, 'Name': '4' },
{ 'Id': PositionTypes.P5, 'Name': '5' }
];
    //</!--Config-->

    //Get AdsSlider
    s.getAdsSlider = () => {
    startBlock();
    service.getAdsSlider().then((d) => {
        if (Array.isArray(d.data))
            s.AdsSlider = d.data;
        co("R-getAdsSlider", d);
        stopBlock();
    }).catch((error) => {
        if (!navigator.onLine)
            toastr.error(Token.ICantCallToServer, Token.Error);
        toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
        stopBlock();
    });
};


    //Create
    s.create = () => {
        if(IsNullOrEmptyOrUndefined(s.AdSliderImageReview))
        {
            s.AdSlider.ImageFieldReuierd = true;
            s.IsIsSubmit = true;
            return;
        }
        //Added To List
        s.AdSlider.State = State.Create;
        s.AdSlider.Id = "xNew" + Math.floor(Math.random() * 1000000);
       
        s.AdSlider.Image = s.AdSliderImageReview;

   var lengthPushed=  s.AdsSlider.push(angular.copy(s.AdSlider));
   s.AdsSlider[lengthPushed - 1].NewFile = s.AdSliderImage;


        s.AdSlider.ImageFieldReuierd = false;
        s.IsIsSubmit = false;
        s.AdSliderImage = null;
        s.AdSliderImageReview = null;
        s.AdSlider.NewFile = null;
        s.filter();
    };

    //Update
    s.update = (ad, fileImage, imageSrc) => {

        if (!IsNullOrEmptyOrUndefined(imageSrc)) {
            ad.Image = imageSrc;
            ad.NewFile = fileImage;
        }

        if (ad.State != State.Create)
            ad.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.AdsSliderRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.AdsSliderRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.AdsSlider.forEach((adSlider,index) => {
                if(adSlider.Id==s.RowUpdateBackup.Id)
                {
                    s.AdsSlider[index] = s.RowUpdateBackup;
                }
            });
            s.filter();
        }
        s.ShowUpdate = -1;
        s.IsUpdate = false;
    };

    //Delete Confirm
    s.deleteConfirm = (id) => {
        s.deleteId = id;
        showDeleteConfirm();
    };

    //Delete
    s.delete = () => {
        if (s.deleteId != null) {
            s.AdsSlider.forEach((item, index) => {
                if (item.Id === s.deleteId) {
                    if (item.State == State.Create)
                        item.State = State.Delete
                    else
                        item.State = State.Delete
                    hideDeleteConfirm();
                    s.filter();
                }
            });
        }
    };

    //Cancel Delete
    s.cancelDelete = () => {
        hideDeleteConfirm();
        s.deleteId = null;
    };

    //Undo Delete
    s.undoDelete = adSlider=> {
        if (adSlider.Id.toString().includes('xNew'))
            adSlider.State = State.Create;
        else
            adSlider.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.AdsSlider, 'State', State.Create, State.Delete, State.Update);
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
                        s.getAdsSlider();
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
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
            stopBlock();
        });

    };


    //Restart
    s.rest = () => {
       
    };

    //Call Functions
    s.callFunctions = () => {
        s.getAdsSlider();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.AdsSlider, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);