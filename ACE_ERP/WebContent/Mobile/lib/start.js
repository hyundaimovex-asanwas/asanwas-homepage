
requirejs.config({
    baseUrl: '/mobile/',
    paths: {
        jquery: 'lib/jquery-1.11.1.min',
        jqm: 'lib/jquery.mobile-1.4.2.min',
        cookie: 'lib/jquery.cookie',
        ajax: 'lib/ajax',
        base64: 'lib/base64',
        json2: 'lib/json2',
        rsa: 'lib/rsa',
        common: 'controller/common.v2'
    },
    shim: {
        jquery: {
            exports: '$'
        },
        jqm: {
            deps: ['jquery'],
            exports: '$.mobile'
        },
        cookie: {
            deps: ['jquery']
        }
    }
});

requirejs(['jquery'],
    function() {
        requirejs(['jqm', 'cookie', 'ajax', 'base64', 'json2', 'rsa', 'common'],
            function() {
                $(document).pagecontainer({
                    create: function(event, ui) {
                        $("body").show();

                        var result = AJAX.PublicKey();
                        if (result.success) {
                            RSA_E = result.data.E;
                            RSA_M = result.data.M;
                            fnInitPage();
                        }
                        else {
                            alert(result.msg);
                        }
                    }
                });
            }
        );
    }
);