myApp.controller("ctrlHome", ["$scope", "$http", "serviceHome", function (s,h,service) {

    var pageName = document.location.pathname.replace('/', '');
    s.page = pageName;
    s.Skip = 0;
    s.Take = 10;
    s.TechnicalSupportSkip = 0;
    s.TechnicalSupportTake = 10;
    s.AllNotifications = [];
    s.TechnicalSupport = [];

    //Gat User Data
    s.FillUserData = function () {
        service.FillUserData().then(function (d) {
            s.UserData = d.data;
            console.log("UserData");
            console.log(s.UserData);
        });
    }; 
 
    //Get Menu
    s.GetMenu = function () {
        service.GetMenu().then(function (d) {
            s.AllMenu = d.data;
            co('All Menu', s.AllMenu);

        });
    }; 

     //Get Notifications
    s.getNotifications = function (isCallFroPage) {

        if (isCallFroPage)
            showDropDown("header_notification_bar");

        service.getNotifications(s.Skip,s.Take).then(function (d) {
            switch (d.data.RequestType) {
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Error);
                }
                default:
                    {
                        if (isCallFroPage) {

                            showDropDown("header_notification_bar");

                            s.Skip += s.Take;
                        s.AllNotifications =s.AllNotifications.concat( d.data);
                        }
                        s.AllNotifications = d.data;

                        s.NotificationCount = d.data[0].NotificationCount;
                        co('AllNotifications', s.AllNotifications);
                    }

            }


        });
    }; 


    //Get TechnicalSupport
    s.getTechnicalSupport = (isCallFroPage) => {
        if (isCallFroPage)
            showDropDown("header_inbox_bar");


        service.getTechnicalSupport(s.TechnicalSupportSkip, s.TechnicalSupportTake).then((d) => {

            switch (d.data.RequestType) {
                case RequestType.Info: {
                    if (isCallFroPage) 
                    toastr.info(d.data.Message, Token.Info);
                } break;
                case RequestType.Error: {
                    toastr.error(d.data.Message, Token.Error);
                } break;
                default: {
                    if (isCallFroPage) {
                        showDropDown("header_inbox_bar");
                        s.Skip += s.Take;
                        s.TechnicalSupport = s.TechnicalSupport.concat(d.data);
                    }
                    s.TechnicalSupport = d.data;
                    s.TechnicalSupportCount = d.data[0].TechnicalSupportCount;


                }
            }
            co("R-getTechnicalSupport", d);
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
        });
    };




    //Call Function
    s.CallFunctionsShared = function () {
        s.GetMenu();
        s.FillUserData();
        s.getNotifications();
        s.getTechnicalSupport();

    }; s.CallFunctionsShared();


	//Active Menu
    s.activeMenu = function (subMenus) {

        var activeMenu = false;
    	subMenus.forEach(function (item) {
    		if (item.Url == pageName) {
    			activeMenu = true;
    			//s.CurrentName = currentName;
    		//	s.ParentUrl = parentUrl;
    		}
    	});
    	return activeMenu;
    };
    //active SubMenu
    s.activeSubMenu = (subMenuName) => {
        return pageName == subMenuName;
    };

    setInterval(() => {
        s.getNotifications();
        s.getTechnicalSupport();
    }, 30000);
    setInterval(() => {

    	s.GetMenu();
    }, 180000);

}]);