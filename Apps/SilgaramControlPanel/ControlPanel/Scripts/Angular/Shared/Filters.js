myApp.filter("FilterIsEqual", function () {
    /*
    prop  : string
    */
    return function (data, prop, model) {
        if (data == null || prop == null || model == undefined)
            return;
        var dataReturn = [];
        data.forEach(function (item) {
            if (item[prop] == model) {
                dataReturn.push(item);
            }
        });
        return dataReturn;
    };
});


myApp.filter("filterIsNotNull", function () {
    /*
    props  : Array Of String
    */
    return function (data, ...props) {
        var dataReturn = [];

        data.forEach((item) => {
            var isNotNull = false;
            props.forEach(prop=> {
                if (item[prop] == null) {
                    isNotNull = true;
                }
            });
            if (!isNotNull) dataReturn.push(item);
        });

        return dataReturn;
    };
});

myApp.filter("filterIsEquals", function () {
    /*
    prop  : string
    */
    return function (data, prop, ...models) {
        var dataReturn = [];
        if (data == null || prop == null)
            return dataReturn;

        data.forEach(function (item) {
            models.forEach(x=> {
                if (item[prop] == x) {
                    dataReturn.push(item);
                }
            });
        });
        
        return dataReturn;
    };


    
});


myApp.filter("filterMenu", function () {
    /*
    props  : Array Of String
    */
    return function (data, prop, model) {
        var dataReturn = [];
        var subMenus = [];

        if (IsNullOrEmptyOrUndefined(data)) return data;
        if (IsNullOrEmptyOrUndefined(prop)) return data;
        if (IsNullOrEmptyOrUndefined(model)) {
            data.forEach((menu) => {
                menu.isOpen = false;
            });
            return data;
        }

        data.forEach((menu) => {
            subMenus = [];
            menu.isOpen = false;

            //من اجل عدم التعامل مع المنيو الفرعية الا فى حالة البحس
            menu.isSubMenusVr = false;
            //تفريغ المنيو الفرعية
            menu.SubMenusVr = [];

            menu.SubMenus.forEach(subMenu=> {
                if (subMenu[prop].toLowerCase().includes(model.toLowerCase())) {
                    //اضافة المنيو الحاليةالمنيوهات الفرعية الجديدة
                    subMenus.push(subMenu);
                }
            });

            if (subMenus.length > 0) {
                menu.isOpen = true;
                //من اجل فتح المنيو
                menu.isSubMenusVr = true;
                //وضع المنيوهات الفرعية الجديدة فى المنيو الهومبة التى سوف تعرض فى حالةالبحث
                menu.SubMenusVr = subMenus;
                dataReturn.push(menu);
            }

        });
        return dataReturn;
    };
});

myApp.filter("filterIsNotConstantWithDelete", function () {
    /*
    prop  : string
    */
    return function (data, prop, ...models) {
        var dataReturn = [];
        if (data == null || prop == null)
            return dataReturn;

        data.forEach(function (item) {
            models.forEach(x=> {
                if (!(item[prop].toString().includes(x) && item.State==State.Delete)) {
                    dataReturn.push(item);
                }
            });
        });
        return dataReturn;
    };
});