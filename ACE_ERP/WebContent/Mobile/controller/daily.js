
function fnInitPage() {

    if ($.cookie("CD_SITE") != null) {
        $("#hdnCD_SITE").val($.cookie("CD_SITE"));
        $("#spDS_SITE").text($.cookie("DS_SITE"));
    }
    
    var dtNow = new Date();
    $("#txtDT_WORK").val(dtNow.toString("yyyy-MM-dd"));

    $("#btnSite").click(function() {
        $(":mobile-pagecontainer").pagecontainer("change", "/mobile/codefind/site.html");
    });

    $("#btnSearch").click(function() {
        if ($("#hdnCD_SITE").val() == "") {
            alert("현장을 선택하세요.");
            return;
        }
        if ($("#txtDT_WORK").val() == "") {
            alert("출역일을 선택하세요.");
            return;
        }
        fnSelect();
    });

    CODEFIND.Site();

    $("#txtDT_WORK").mobipick();
}

function fnSetSite(code, text) {
    $("#hdnCD_SITE").val(code);
    $("#spDS_SITE").text(text);

    $.cookie("CD_SITE", code, { expires: 30, path: '/' });
    $.cookie("DS_SITE", text, { expires: 30, path: '/' });
}

function fnSelect(bAppend, sDS_HNAME) {

    MOBILE.StartLoading();

    $("#listDaily table, #listDaily li:not(:first)").remove();

    var params = [];
    AJAX.ParamAdd(params, "CD_SITE", $("#hdnCD_SITE").val());
    AJAX.ParamAdd(params, "DT_WORK", DATE.ClearFormat($("#txtDT_WORK").val()));

    var data = {};
    data.SP = "DSBPR_DAILY_SELECT_M";
    data.PARAMS = params;

    // 비동기 호출
    var result = AJAX.Select(data, true, fnSuccess, fnError);

}

function fnSuccess(result) {
    if (result.success) {

        var html = "";
        gData = result.data;
        if (result.data.length > 0) {
            var table = "<table width='100%' class='tbList'><tr><th>이름</th><th>기본</th><th>연장</th><th>공수</th></tr>";

            var group = "";
            var cnt = 0;
            var sum = 0;
            var titles = [];

            for (var i = 0; i < result.data.length; i++) {
                if (i == 0) {
                    group = result.data[i].DS_JIKJONG;
                }

                if (group != result.data[i].DS_JIKJONG) {
                    titles.push("<tr><td colspan='3' class='b'>" + group + " (" + cnt + ")</td><td class='b r'>" + sum.toFixed(1) + "</td></tr>");
                    group = result.data[i].DS_JIKJONG;
                    sum = 0;
                    cnt = 0;
                }

                sum += Number(result.data[i].RT_GS);
                cnt++;
            }
            // 마지막 추가
            titles.push("<tr><td colspan='3' class='b'>" + group + " (" + cnt + ")</td><td class='b r'>" + sum.toFixed(1) + "</td></tr>");

            group = "";
            cnt = 0;
            for (var i = 0; i < result.data.length; i++) {
                
                var title = result.data[i].DS_NAME + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].NO_ID + "]</span>";
                var desc = result.data[i].TM_RW + "," + result.data[i].TM_OT + "," + result.data[i].RT_GS;
                html += LISTVIEW.AddRow("#", title, desc);

                if (group != result.data[i].DS_JIKJONG) {
                    group = result.data[i].DS_JIKJONG;
                    table += titles[cnt];
                    cnt++;
                }

                table += "<tr><td>" + result.data[i].DS_NAME + " <span style='font-size:12px;'>(" + result.data[i].NO_ID.substr(0, 6) + ")</span></td><td class='r'>" + Number(result.data[i].TM_RW).toFixed(1) + "</td><td class='r'>" + Number(result.data[i].TM_OT).toFixed(1) + "</td><td class='r'>" + Number(result.data[i].RT_GS).toFixed(1) + "</td></tr>";
            }

            table += "</table>";
            
            $("#listDaily").append(table);
        }
        else {
            $("#listDaily").append(LISTVIEW.EmptyData());
        }

        $("#listDaily li:first").removeClass("ui-screen-hidden");
        $("#listDaily").listview("refresh");

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
