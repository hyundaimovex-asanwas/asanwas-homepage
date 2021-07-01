
function fnInitPage() {
    //fnSelect();
}

function fnSelect() {

    MOBILE.StartLoading();

    $("#listNotice li:not(:first)").remove();

    // 회사정보
    var params = [];
    AJAX.ParamAdd(params, "TY_SEARCH", "1");
    AJAX.ParamAdd(params, "DS_SEARCH", "");

    var data = {};
    data.SP = "DZZPR_DOTNET_NOTICELIST_SELECT";
    data.PARAMS = params;

    // 비동기 호출
    var result = AJAX.Select(data, true, fnSuccess, fnError);
}


function fnSuccess(result) {
    if (result.success) {
        var html = "";
        gData = result.data;
        if (result.data.length > 0) {
            for (var i = 0; i < result.data.length; i++) {
                var title = result.data[i].NM_TITLE;
                var desc = result.data[i].DT_UPDATE;
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#", title, desc, onclick);
            }

            $("#listNotice").append(html);
        }
        else {
            $("#listNotice").append(LISTVIEW.EmptyData());
        }

        $("#listNotice").listview("refresh");

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
        alert(result);
}


function fnSetDetail(i) {
    alert("준비중..");
}