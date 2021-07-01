
function fnInitPage() {
    if ($.cookie("ID") != null && $.cookie("ID") != "") {
        $("#txtID").val($.cookie("ID"));
        $("#txtPWD").focus();
    }
    else {
        $("#txtID").focus();
    }

    if ($.cookie("AUTO") != null && $.cookie("AUTO") == "true") {
        $("#chkAuto").prop("checked", true).checkboxradio("refresh");

        // true 이면 자동로그인처리
        if ($.cookie("AUTH") != null && $.cookie("AUTH") != "") {
            RSA.initKey();
            var json = {};
            json.AUTH = $.cookie("AUTH");
            var result = AJAX.Login(json);

            if (result.success) {
                location.href = "main.html";
            }
        }
        else {
            alert(result.msg);
        }
    }
    else {
        $("#chkAuto").prop("checked", false).checkboxradio("refresh");
    }

    fnInitEvent();
}

function fnInitEvent() {
    $("#btnLogin").click(function() {
        fnLoginProccess();
    });

    $("#txtPWD").keypress(function(event) {
        if (event.which == 13) {
            fnLoginProccess();
        }
    });

}

function fnCheckLogin() {
    if ($("#txtID").val() == "") {
        alert("아이디를 입력하세요.");
        $("#txtID").focus();
        return false;
    }
    else if ($("#txtPWD").val() == "") {
        alert("비밀번호를 입력하세요.");
        $("#txtPWD").focus();
        return false;
    }

    return true;
}

function fnLoginProccess() {
    if (fnCheckLogin()) {
        
        RSA.initKey();
        var json = {};
        json.AUTH = RSA.encryptedString(BASE64.Encode($("#txtID").val()) + "|" + BASE64.Encode($("#txtPWD").val()));
        var result = AJAX.Login(json);

        if (result.success) {
            $.cookie("ID", $("#txtID").val(), { expires: 30, path: '/' });
            $.cookie("AUTO", $("#chkAuto").prop("checked"), { expires: 30, path: '/' });
            if ($("#chkAuto").prop("checked") == true) {
                $.cookie("AUTH", json.AUTH, { expires: 30, path: '/' });
            }
            
            location.href = "main.html";
        }
        else {
            alert(result.msg);
        }
    }
}