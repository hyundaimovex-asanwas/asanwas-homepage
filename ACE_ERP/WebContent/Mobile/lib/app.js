
requirejs.config({
    baseUrl: '/Mobile/',
    paths: {
        jquery: 'lib/jquery-1.11.1.min',
        jqm: 'lib/jquery.mobile-1.4.2.min',
        cookie: 'lib/jquery.cookie',
        form: 'lib/jquery.form',
        ajax: 'lib/ajax.v2',
        base64: 'lib/base64',
        json2: 'lib/json2',
        rsa: 'lib/rsa',
        xdate: 'lib/xdate',
        xdatelo: 'lib/xdate.locale',
        mobipick: 'lib/mobipick',
        common: 'controller/common.v2'
    },
    shim: {
        jquery: {
            exports: '$'
        },
        jqm: {
            deps: ['jquery'],
            exports: '$.Mobile'
        },
        cookie: {
            deps: ['jquery']
        },
        form: {
            deps: ['jquery']
        },
        mobipick: {
            deps: ['jquery', 'jqm']
        }
    }
});

requirejs(['jquery'],
    function() {
        requirejs(['jqm', 'cookie', 'form', 'ajax', 'base64', 'json2', 'rsa', 'common', 'xdate', 'xdatelo', 'mobipick'],
            function() {
                $(document).pagecontainer({
                    create: function(event, ui) {

                        $("body").show();
                        AJAX.CheckUser();

                        MOBILE.Menu();
                        fnInitPage(this);

                    }
                });
            }
        );
    }
);