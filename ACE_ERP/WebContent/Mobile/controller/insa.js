
var gCD_CORP = "";
var gCD_DEPT = "";
var gCUR_PAGE = 1;

function fnInitPage() {

    $("#cboCorp").change(function() {
        gCD_CORP = "";
        gCD_DEPT = "";
        $("#btnDept").html("부서");
        fnChangeCorp($(this).val());
    });

    $("#btnDept").click(function() {
        if ($("#cboCorp").val() == "") {
            alert("법인을 선택하세요.");
            return;
        }
        $(":mobile-pagecontainer").pagecontainer("change", "#pageDept");
    });

    $("#btnSearch").click(function() {
        if ($("#cboCorp").val() == "") {
            alert("법인을 선택하세요.");
            return;
        }
        if (gCD_DEPT == "") {
            alert("부서를 선택하세요.");
            return;
        }
        fnSelect();
    });

    $("#listUser").on("filterablebeforefilter", function(e, data) {
        var $ul = $(this),
            $input = $(data.input),
            value = $input.val();
        if (value) {
            fnSelect(false, value);
        }
        else {
            fnSelect(false);
        }
    });

    // 법인정보
    var params = [];
    AJAX.ParamAdd(params, "TY_GUBUN", "0");
    AJAX.ParamAdd(params, "NO_SEARCH", "");

    var data = {};
    data.SP = "DZZPR_CORP_SELECT";
    data.PARAMS = params;

    var result = AJAX.Select(data);
    if (result.success) {
        var html = "";
        for (var i = 0; i < result.data.length; i++) {
            html += "<option value='" + result.data[i].CD_CORP + "'>" + result.data[i].DS_CORP + "</option>";
        }

        $("#cboCorp").append(html);

        if (result.data.length > 0) {
            $("#cboCorp").val(result.data[0].CD_CORP);
            $("#cboCorp").trigger("change");
        }

        $("#cboCorp").selectmenu("refresh");
    }
}

function fnChangeCorp(corp) {
    $("#listDept li:not(:first)").remove();
    
    // 부서정보
    var params = [];
    AJAX.ParamAdd(params, "CD_CORP", corp);
    AJAX.ParamAdd(params, "DT_SNAPSHOT", "");

    var data = {};
    data.SP = "DAAPR_ORGTREE_SELECT_M";
    data.PARAMS = params;

    var result = AJAX.Select(data);
    if (result.success) {
        var html = "";
        for (var i = 0; i < result.data.length; i++) {
            if (i == 0) {
                gCD_DEPT = result.data[i].CD_DEPT;
                $("#btnDept").html(result.data[i].DS_DEPT);
            }
            var space = "";
            for (var s = 0; s < Number(result.data[i].NO_LEVEL); s++) {
                if (s == (Number(result.data[i].NO_LEVEL) - 1))
                    space += "ㄴ";
                else
                    space += "&nbsp;&nbsp;&nbsp;&nbsp;";
            }
            html += "<li><a href='#pageInsa' onclick='fnSetDept(\"" + result.data[i].CD_DEPT + "\",\"" + result.data[i].DS_DEPT + "\");'>" + space + result.data[i].DS_DEPT + "</a></li>";
        }

        fnSelect();
        $("#listDept").append(html);
        try {
            $("#listDept").listview("refresh");
        }
        catch(e) {}
    }
}

function fnSetDept(cd_dept, ds_dept) {
    gCD_DEPT = cd_dept;
    $("#btnDept").html(ds_dept);
    fnSelect();
}

function fnSelectMore() {
    gCUR_PAGE += 1;
    fnSelect(true);
}

function fnSelect(bAppend, sDS_HNAME) {

    MOBILE.StartLoading();
    
    if (bAppend == null) bAppend = false;
    if (sDS_HNAME == null) sDS_HNAME = "";
    if (bAppend) {
        $("#listUser li:last").remove(); //더보기 버튼 삭제
    }
    else {
        gCUR_PAGE = 1;
        $("#listUser li:not(:first)").remove();
    }
    
    // 인사정보
    gCD_CORP = $("#cboCorp").val();
    
    var params = [];
    AJAX.ParamAdd(params, "TY_GUBUN", 2, "TinyInt");
    AJAX.ParamAdd(params, "CD_CORP", gCD_CORP);
    AJAX.ParamAdd(params, "CD_DEPT", gCD_DEPT);
    AJAX.ParamAdd(params, "CD_MINDATA", (gCUR_PAGE - 1) * 10, "Int");
    AJAX.ParamAdd(params, "DT_SNAPSHOT", "");
    AJAX.ParamAdd(params, "DS_HNAME", sDS_HNAME);

    var data = {};
    data.SP = "DAAPR_ORGANLIST_SELECT_M";
    data.PARAMS = params;
    
    // 비동기 호출
    var result = AJAX.Select(data, true, fnSuccess, fnError);

}

function fnSuccess(result) {
    if (result.success) {
        var html = "";
        if (result.data.length > 0) {
            for (var i = 0; i < result.data.length; i++) {
                var img = "http://123.215.234.35/Images/" + gCD_CORP + result.data[i].ID_SABUN.replace(/ /g, '') + ".jpg";
                var title = result.data[i].DS_HNAME + " " + result.data[i].DS_POSITION +
                            ($.trim(result.data[i].DS_JOBTYPE) != "" ? "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].DS_JOBTYPE + "]</span>" : "");
                var desc = ($.trim(result.data[i].ds_email) != "" ? result.data[i].ds_email + "&nbsp;<img src='/mobile/lib/images/icons-png/mail.png' width='12px' onclick='fnSendMail(\"" + result.data[i].ds_email + "\")' />" : "");
                var split = "<a href='tel:" + result.data[i].ds_handphone + "'>call</a>";

                html += LISTVIEW.AddImgSplitRow("#", img, title, desc, split);
            }

            $("#listUser").append(html);

            if (result.data.length == 10) {
                $("#listUser").append(LISTVIEW.MoreButton());
            }
        }
        else {
            $("#listUser").append(LISTVIEW.EmptyData());
        }

        $("#listUser li:first").removeClass("ui-screen-hidden");
        $("#listUser").listview("refresh");

        MOBILE.EndLoading();
    }
    else {
        MOBILE.EndLoading();
        alert(result.msg);
    }
}

function fnError(result) {
    MOBILE.EndLoading();
    if (!STR.IsNullOrEmpty(result.msg))
        alert(result.msg);
}

function fnSendMail(mail) {
    document.location.href = "mailto:" + mail;
}