myApp.service("serviceHome", ["$http", function (h) {
    var controller = "/Service/",
   functions = {

       //Get TechnicalSupport
       getTechnicalSupport(skip, take) {
           return h({
               method: 'Get',
               url: `${controller}GetTechnicalSupport?skip=${skip}&take=${take}`,
           });
       },
       //Gat User Data
       FillUserData   () {
           return h({
               method: "Get",
               url: controller + "FillUserData"
           });
       },
       //Get Menu
       GetMenu   () {
           return h({
               method: "Get",
               url: controller + "GetControlPanelMenu"
           });
       },

       //GetNotifications
       getNotifications   (skip, take) {
           return h({
               method: "Get",
               url: `${controller}GetNotifications?skip=${skip}&take=${take}`
           });
       },

   };

return functions;
  
}]);