/*
هى من اجل اعادة تفعيل العداد لا اكثر
*/
myApp.directive('ngCounterup', function ($compile) {
    return {
        restrict: 'A',
        link: function ($scope, elem, attr, ctrl) {
//للشعور بـ الاتربيوت اذا حدث بة تغير
            attr.$observe('ngCounterup', function (value) {
                debugger;
                $(elem).counterUp({
                    delay: 10,
                    time: 1000
                });
            });
        }   
    };
})