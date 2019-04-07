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