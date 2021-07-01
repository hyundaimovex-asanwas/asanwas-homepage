var gData = null;
var gIdx = null;

//페이지 초기화
function fnInitPage() {
    $("#btnEdit").click(function() {
        fnSetForm("U");
    });

    $("#btnSave").click(function() {
        fnSetForm();
        fnSave();
    });

    $("#btnCancel").click(function() {
        fnSetDetail(gIdx);
        fnSetForm();
    });

    fnSelect();
}
//페이지 상태에 따라 컨트롤 제어
function fnSetForm(mode) {
    switch (mode) {
        case "U":
            $("#divEdit").hide();
            $("#divSave").show();
            $("#txtCD_VALUE").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_BIGO").addClass("ui-editable").removeAttr("readonly");
            break;
        default:
            $("#divEdit").show();
            $("#divSave").hide();
            $("#txtCD_VALUE").removeClass("ui-editable").attr("readonly", true);
            $("#txtDS_BIGO").removeClass("ui-editable").attr("readonly", true);
        
         break;
    }
}

//리스트 데이터 조회 설정
function fnSelect() {

    MOBILE.StartLoading();

    $("#list@UIPattern1@ li:not(:first)").remove();

    // 회사정보
    var params = [];
    AJAX.ParamAdd(params, "CD_SYSTEM", "");
   
    var data = {};
    data.SP = "DZZPR_CONFIGMGR_SELECT";
    data.PARAMS = params;

    // 비동기 호출
    var result = AJAX.Select(data, true, fnSuccess, fnError);

}
//리스트 조회된 데이터 셋팅
function fnSuccess(result) {
    if (result.success) {
        var html = "";
        gData = result.data;
        if (result.data.length > 0) {
            for (var i = 0; i < result.data.length; i++) {
                var title = result.data[i].CD_CODE + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].DS_SYSTEM + "]</span>";
                var desc = result.data[i].CD_VALUE;
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#page@UIPattern1@Detail", title, desc, onclick);
            }

            $("#list@UIPattern1@").append(html);
        }
        else {
            $("#list@UIPattern1@").append(LISTVIEW.EmptyData());
        }

        $("#list@UIPattern1@ li:first").removeClass("ui-screen-hidden");
        $("#list@UIPattern1@").listview("refresh");

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

//상세페이지 셋팅
function fnSetDetail(i) {
    gIdx = i;
    fnSetForm();

    if (gData.length > 0) {
        $("#hdnCD_SYSTEM").val(gData[i].CD_SYSTEM);
        $("#hdnYN_SYSTEM").val(gData[i].YN_SYSTEM);

        $("#txtDS_SYSTEM").val(gData[i].DS_SYSTEM);
        $("#txtCD_CODE").val(gData[i].CD_CODE);
        $("#txtCD_VALUE").val(gData[i].CD_VALUE);
        $("#txtDS_BIGO").val(gData[i].DS_BIGO);
   
    }
}

//상세페이지 저장설정
function fnSave() {
    var params = [];
    AJAX.ParamAdd(params, "CD_SYSTEM", $("#hdnCD_SYSTEM").val());
    AJAX.ParamAdd(params, "CD_CODE", $("#txtCD_CODE").val());
    AJAX.ParamAdd(params, "CD_VALUE", $("#txtCD_VALUE").val());
    AJAX.ParamAdd(params, "YN_SYSTEM", $("#hdnYN_SYSTEM").val());
    AJAX.ParamAdd(params, "DS_BIGO", $("#txtDS_BIGO").val());
    AJAX.ParamAdd(params, "ID_UPDATE", "ERPADMIN");
      
    var data = {};
    data.INSERTSP = "";
    data.DELETESP = "";
    data.UPDATESP = "DZZPR_CONFIG_UPDATE";
    data.SAVEGUBUN = "U";
    data.PARAMS = params;

    var result = AJAX.Save(data);

    if (result.success) {
        alert("저장되었습니다.");
        fnSetForm();
        fnSelect();
    }
    else {
        alert(result.msg);
    }
}