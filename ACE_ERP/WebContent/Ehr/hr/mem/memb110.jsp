<!--
*****************************************************
* @source       : memb110.jsp
* @description : 파견사원관리대장 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/22      김학수        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>파견사원관리대장(memb110)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
    var nscp = (navigator.appName == "Netscape")
    
    var btnList = 'TFTTFFTT';
    /***********************************
     * 01. 조회 함수_List 형태의 조회  *
     ***********************************/
    function fnc_SearchList() {
        var f = document.form1;
      
        var str_ymd = f.txtSTR_YMD_SHR.value;
        var dpt_cd  = f.txtDPT_CD_SHR.value;
        var eno_no  = f.txtENO_NO_SHR.value;
   
        if ( f.txtSTR_YMD_SHR.value == "" ||  f.txtSTR_YMD_SHR.value == null ) 
        {
            alert("기간을 선택하십시오.");
            f.txtSTR_YMD_SHR.focus();
            return false;
        }
        
        if ( f.txtDPT_CD_SHR.value == "" ||  f.txtDPT_CD_SHR.value == null ) 
        {
            alert("소속을 선택하십시오.");
            f.txtDPT_CD_SHR.focus();
            return false;
        } 

        dsT_ME_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb110.cmd.MEMB110CMD&S_MODE=SHR&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&STR_YMD="+str_ymd;
        dsT_ME_PERSON.reset();

        f.str_ymd.value = str_ymd;
    }

    /***********************************
     * 02. 조회 함수_Item 형태의 조회  *
     ***********************************/
    function fnc_SearchItem() {

        //이곳에 해당 코딩을 입력 하세요

    }

    /******************
     * 03. 저장 함수  *
     ******************/
    function fnc_Save() {
        var f = document.form1;
        var eno_no;
        var str_ymd;

        eno_no  = dsT_ME_DAYLEDGER.NameValue(1,"ENO_NO");
        str_ymd = f.txtSTR_YMD_SHR.value;

        if(!fnc_SaveItemCheck()) return;

        trT_ME_DAYLEDGER.KeyValue = "tr01(I:dsT_ME_DAYLEDGER=dsT_ME_DAYLEDGER)";
        trT_ME_DAYLEDGER.action = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb110.cmd.MEMB110CMD&S_MODE=SAV_02&ENO_NO="+eno_no;
        trT_ME_DAYLEDGER.post();
    }

    /******************
     * 04. 삭제 함수  *
     ******************/
    function fnc_Delete() {

    }

    /******************
     * 05. 인쇄 함수  *
     ******************/
    function fnc_Print() {
        var f = document.form1;
        if ( f.print_go.value == "Y" ) {
            var eno_no;
            var str_ymd;

            eno_no  = dsT_ME_DAYLEDGER.NameValue(1,"ENO_NO");
            str_ymd = f.txtSTR_YMD_SHR.value;

            var url = "memb110_PV.jsp?eno_no="+eno_no+"&str_ymd="+str_ymd;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        } else {
            alert("조회후 인쇄하시기 바랍니다.");
        }
    }

    /***********************
     * 06. 엑셀 저장 함수  *
     ***********************/
    function fnc_ToExcel() {
		if (dsT_ME_DAYLEDGER.CountRow < 1) {
            alert("엑셀로 변환할 자료가 없습니다!");
            return;
        }
        
        form1.grdT_ME_DAYLEDGER.GridToExcel("파견사원관리대장", '', 225);
    }

    /******************
     * 07. 신규 함수  *
     ******************/
    function fnc_AddNew() {

  //이곳에 해당 코딩을 입력 하세요

    }

    /******************
     * 08. 추가 함수  *
     ******************/
    function fnc_Append() {

  //이곳에 해당 코딩을 입력 하세요

    }

    /******************
     * 09. 제거 함수  *
     ******************/
    function fnc_Remove() {

  //이곳에 해당 코딩을 입력 하세요

    }

    /********************
     * 10. 초기화 함수  *
     ********************/
    function fnc_Clear() {
        fnc_ClearInputFieldAll(new Array("txtENO_NO_SHR", "txtENO_NO_SES"));
        document.getElementById("txtENO_NO_SHR").value = "";
        
        dsT_ME_PERSON.ClearData();
        dsT_ME_DAYLEDGER.ClearData();
        dsT_ME_DAYLEDGER_INPUT.ClearData();

        fnc_SetVariable();
    }

    /************************
     * 11. 화면 종료(닫기)  *
     ***********************/
    function fnc_Exit() {

        frame = window.external.GetFrame(window);

        frame.CloseFrame();

   }

    /******************************
     * 12. 검색 조건 유효성 검사  *
     ******************************/
    function fnc_SearchItemCheck(year) {

  //이곳에 해당 코딩을 입력 하세요

    }

    /*************************
     * 13. 저장 유효성 체크  *
     *************************/
    function fnc_SaveItemCheck() {
            if (!dsT_ME_DAYLEDGER.IsUpdated) {
                alert("저장할 자료가 없습니다.");
//                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;
    }

    /********************************************
     * 14. Form Load 시 Default 작업 처리 부분  *
     *******************************************/
    function fnc_OnLoadProcess() {
        cfStyleGrid(form1.grdT_ME_PERSON,15,"false","right")      // Grid Style 적용
        cfStyleGrid(form1.grdT_ME_DAYLEDGER,15,"true","false")    // Grid Style 적용

        fnc_SetVariable();
     }

    /********************
    * 15. 단축키 처리  *
    *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }
    
    
    /********************
    * 16. 기본값들 설정  *
    *******************/
    function fnc_SetVariable() {
        //담당자 소속 설정
        document.getElementById("txtENO_NO_SES").value = "<%=ls_UserId %>";
        
        var eno = fnc_GetEnoNm("txtENO_NO_SES");
        document.getElementById("txtDPT_CD_SHR").value = eno.dpt_cd;
        document.getElementById("txtDPT_NM_SHR").value = eno.dpt_nm;
       
        //기간 설정
        var oSTR_YMD = document.getElementById("txtSTR_YMD_SHR");
        oSTR_YMD.value = getTodayArray()[0]+"-"+getTodayArray()[1];
        oSTR_YMD.focus();
    }
    
    
    
    /********************************************
    * 날짜 형식 유효성 체크                     *
    ********************************************/
    function fncCheckDate(obj) {
        if (obj.value == '') return; 
        if(!cfDateExpr(obj.value)) { 
            alert('유효한 날짜가 아닙니다.'); 
            obj.focus();
        }
    }

    /********************************************
    * 시간 형식 유효성 체크                     *
    ********************************************/
    function fncCheckHour(obj) {
        if (obj.value == '') return; 
        if(!cfHourExpr(obj.value)) { 
            alert('시각 기입을 잘못하셨습니다.'); 
            obj.value = '';
            obj.focus();
        }
    }
    
    /********************************************
    * ez-gen 버튼 클릭 이벤트                   *
    ********************************************/
    function winclose()
    {
        window.close();
    }
    function goclick(x)
    {   
        if( !document.form1.aaa.RunButton(x)) alert("개체가 없습니다.");
    }    
    
    </script>
    
    <script>
    /********************************************
    * 시각 형식 유효성 체크                     *
    ********************************************/
    //숫자만 들어가도록 체크
    //onkeypress="cfCheckNumber();"
    function cfHourCheckNumber(){
        if((event.keyCode < 48)||(event.keyCode > 57)){
                event.returnValue=false;
        }
    }

    //시각을 체크하여 자동으로 ':'(콜론) 삽입
    //onkeyup="cfDateHyphen(this);"
    function cfHourColon(target){

        switch (target.value.length){
            case 2:
                target.value +=  ":";
                break;
      }
    }

    /**
     * 시각 검증용.
     */
    function cfHourExpr(p_value) {
        var gs_DateStr = p_value.replaceStr(":","");
        if ( gs_DateStr.length != 4 ) {
            return false;
        }

        var hh = gs_DateStr.substring(0,2);
        var mm = gs_DateStr.substring(2,4);

        if ( hh < 0 || hh > 24 ) {
            return false;
        }
        if ( mm < 0 || mm > 59 ) {
            return false;
        }
        return true;
    }

    /***************************
    * 일괄생성                 *
    ***************************/ 
    function fnc_CreateBatch() {
        var f = document.form1;
        var rownum     = f.rownum.value;
        if ( f.txtSTR_HMS.value == "" || f.txtSTR_HMS.value == null )
        {
            alert("시업시각을 입력하십시오.");
            f.txtSTR_HMS.focus();
            return false;
        }
        if ( f.txtEND_HMS.value == "" || f.txtEND_HMS.value == null )
        {
            alert("종업시각을 입력하십시오.");
            f.txtEND_HMS.focus();
            return false;
        }
  
        var str_hms_h  = f.txtSTR_HMS.value.substr(0,2);
        var end_hms_h  = f.txtEND_HMS.value.substr(0,2);

        var str_hms_m  = f.txtSTR_HMS.value.substr(3,2);
        var end_hms_m  = f.txtEND_HMS.value.substr(3,2);

        var str_hms_val  = (str_hms_h * 3600)  + (str_hms_m * 60);
        var end_hms_val  = (end_hms_h * 3600)  + (end_hms_m * 60);

        if ( Number(end_hms_val) - Number(str_hms_val) < 1 )
        {
            alert("종업시각이 시업시각보다 커야 합니다.");
            f.txtSTR_HMS.value = "";
            f.txtEND_HMS.value = "";
            f.txtSTR_HMS.focus();
            return false;
        }

        var str_ymd    = f.str_ymd.value;
        var eno_no     = dsT_ME_PERSON.NameValue(rownum,"ENO_NO");
        var discomp_cd = dsT_ME_PERSON.NameValue(rownum,"DISCOMP_CD");
        var dpt_cd     = dsT_ME_PERSON.NameValue(rownum,"DPT_CD");
        var syduty_cd  = dsT_ME_PERSON.NameValue(rownum,"DUTY_CD");
        var syeno_no   = dsT_ME_PERSON.NameValue(rownum,"SYENO_NO");
        var str_hms    = f.txtSTR_HMS.value; 
        var end_hms    = f.txtEND_HMS.value;
 //       var gun_hns    = 
        var job_tag    = dsT_ME_PERSON.NameValue(rownum,"JOB_TAG");

        dsT_ME_DAYLEDGER_INPUT.SetDataHeader("partno:STRING(3)");
        dsT_ME_DAYLEDGER_INPUT.ImportData('22');
        dsT_ME_DAYLEDGER_INPUT.ImportData('32');

//        alert(dsT_ME_DAYLEDGER_INPUT.countRow);
 //       if(!fnc_SaveItemCheck_01()) return;

        trT_ME_DAYLEDGER.KeyValue = "JSP(I:dsT_ME_DAYLEDGER_INPUT=dsT_ME_DAYLEDGER_INPUT)";
        trT_ME_DAYLEDGER.Action   = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb110.cmd.MEMB110CMD&S_MODE=SAV&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&STR_YMD="+str_ymd+"&DISCOMP_CD="+discomp_cd+"&SYDUTY_CD="+syduty_cd+"&SYENO_NO="+syeno_no+"&STR_HMS="+str_hms+"&END_HMS="+end_hms+"&JOB_TAG="+job_tag;
        trT_ME_DAYLEDGER.post();

        biz1.style.display = "none";
        biz2.style.display = "";
        
        dsT_ME_DAYLEDGER.dataid = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb110.cmd.MEMB110CMD&S_MODE=SHR_02&ENO_NO="+eno_no+"&STR_YMD="+str_ymd;
        dsT_ME_DAYLEDGER.reset();
        
        if ( dsT_ME_DAYLEDGER.countRow > 0 ) {
            document.form1.print_go.value = "Y";
        } else { 
            alert("해당월에 대한 자료가 근태사항 테이블에 존재하지 않습니다.");
            document.form1.print_go.value = "N";
        }
    }   
    </script>


    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_ME_PERSON)   |
    | 3. 사용되는 Table List(T_ME_PERSON)		     |
    +------------------------------------------------>
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_ME_DAYLEDGER)|
    | 3. 사용되는 Table List(T_ME_DAYLEDGER)		 |
    +------------------------------------------------>
    <Object ID="dsT_ME_DAYLEDGER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_ME_DAYLEDGER_INPUT)|
    | 3. 사용되는 Table List(T_ME_DAYLEDGER)		 |
    +------------------------------------------------>
    <Object ID="dsT_ME_DAYLEDGER_INPUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_ME_DAYLEDGER)		|
    | 3. 사용되는 Table List(T_ME_DAYLEDGER, T_DI_HOLIDAY)  |
    +------------------------------------------------------->
    <Object ID ="trT_ME_DAYLEDGER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {

          //alert("검색하신 조건의 자료가 없습니다.");
          fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

          fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
          document.form1.grdT_ME_PERSON.focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=dsT_ME_PERSON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=dsT_ME_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------------+
    | Grid를 더블클릭했을때의 이벤트처리  |
    +------------------------------------->
    <script language=JavaScript for=grdT_ME_PERSON event=OnDblClick(row,colid)>
        var f = document.form1;
        var eno_no;
        var str_ymd;

        eno_no  = dsT_ME_PERSON.NameValue(row,"ENO_NO")
        str_ymd = f.txtSTR_YMD_SHR.value;

        dsT_ME_DAYLEDGER.dataid = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb110.cmd.MEMB110CMD&S_MODE=SHR_02&ENO_NO="+eno_no+"&STR_YMD="+str_ymd;
        dsT_ME_DAYLEDGER.reset();
        
        var RowCnt = dsT_ME_DAYLEDGER.CountRow;

        if ( RowCnt == 0 )
        {
            alert("해당사원에대한 자료가 없습니다. 일괄생성 버튼을 클릭하십시오");
            document.form1.print_go.value = "N";
            biz1.style.display = "";
            biz2.style.display = "none";
        } else {
            biz1.style.display = "none";
            biz2.style.display = "";
            f.print_go.value = "Y";
        }
        f.rownum.value = row;

    </script>

    <!--------------------------+
    | Grid 이벤트 처리  |
    +--------------------------->
    <script language=JavaScript for=grdT_ME_DAYLEDGER event=OnClick(row,colid)>
        var f = document.form1;
        f.click_rownum.value = row;
        f.colid.value = colid;
    </script>

    <script language="javascript"  for=grdT_ME_DAYLEDGER event=onKeyPress(keycode)>
    /*
        var f = document.form1;
        var row_num = f.click_rownum.value;
        var colid   = f.colid.value;

        if((keycode < 48)||(keycode > 57) && keycode != 8 && keycode != 32 ){
            alert(row_num+ ".."+colid);
            dsT_ME_DAYLEDGER.NameValue(row_num,colid) = "";
        }
    */
    </script>

    <script language="javascript"  for=grdT_ME_DAYLEDGER event=OnColumnPosChanged(Row,Colid)>


    </script>
    
    <script language="javascript"  for=grdT_ME_DAYLEDGER event=OnExit(row,colid,olddata)>

        var f = document.form1;
        var row_num  = f.click_rownum.value;
        var str_hms  = dsT_ME_DAYLEDGER.NameValue(row_num,"STR_HMS") ==null?"0":dsT_ME_DAYLEDGER.NameValue(row_num,"STR_HMS");
        var end_hms  = dsT_ME_DAYLEDGER.NameValue(row_num,"END_HMS") ==null?"0":dsT_ME_DAYLEDGER.NameValue(row_num,"END_HMS");
//        var gun_hms  = dsT_ME_DAYLEDGER.NameValue(row_num,"GUN_HMS") ==null?"0":dsT_ME_DAYLEDGER.NameValue(row_num,"GUN_HMS");
        var rest_hms = dsT_ME_DAYLEDGER.NameValue(row_num,"REST_HMS")==null?"0":dsT_ME_DAYLEDGER.NameValue(row_num,"REST_HMS");

        var str_hms_h  = str_hms.substr(0,2);
        var end_hms_h  = end_hms.substr(0,2);
//        var gun_hms_h  = gun_hms.substr(0,2);
        var rest_hms_h = rest_hms.substr(0,2);

        var str_hms_m  = str_hms.substr(2,2);
        var end_hms_m  = end_hms.substr(2,2);
//        var gun_hms_m  = gun_hms.substr(2,2);
        var rest_hms_m = rest_hms.substr(2,2);
        
        if ( end_hms_h < 0 || end_hms_h > 24 || (end_hms.length < 4 && end_hms.length > 0 && dsT_ME_DAYLEDGER.NameValue(row_num,"GUN_HMS") != "") || dsT_ME_DAYLEDGER.NameValue(row_num,"END_HMS") == "0000" ) {
            alert("종업시각을 잘못 입력하셨습니다.");
            dsT_ME_DAYLEDGER.NameValue(row,"END_HMS") = "";
            return false;
        }
        if ( end_hms_m < 0 || end_hms_m > 59 || (end_hms.length < 4 && end_hms.length > 0 && dsT_ME_DAYLEDGER.NameValue(row_num,"GUN_HMS") != "") || dsT_ME_DAYLEDGER.NameValue(row_num,"END_HMS") == "0000" ) {
            alert("종업시각을 잘못 입력하셨습니다.");
            dsT_ME_DAYLEDGER.NameValue(row,"END_HMS") = "";
            return false;
        }
        if ( str_hms_h < 0 || str_hms_h > 24 || (str_hms.length < 4 && str_hms.length > 0 && dsT_ME_DAYLEDGER.NameValue(row_num,"GUN_HMS") != "") || dsT_ME_DAYLEDGER.NameValue(row_num,"STR_HMS") == "0000" ) {
            alert("시업시각을 잘못 입력하셨습니다.");
            dsT_ME_DAYLEDGER.NameValue(row,"STR_HMS") = "";
            return false;
        }
        if ( str_hms_m < 0 || str_hms_m > 59 || (str_hms.length < 4 && str_hms.length > 0 && dsT_ME_DAYLEDGER.NameValue(row_num,"GUN_HMS") != "") || dsT_ME_DAYLEDGER.NameValue(row_num,"STR_HMS") == "0000" ) {
            alert("시업시각을 잘못 입력하셨습니다.");
            dsT_ME_DAYLEDGER.NameValue(row,"STR_HMS") = "";
            return false;
        }
        var str_hms_val  = (str_hms_h * 3600)  + (str_hms_m * 60);
        var end_hms_val  = (end_hms_h * 3600)  + (end_hms_m * 60);
//        var gun_hms_val  = (gun_hms_h * 360)  + (gun_hms_m * 60);
        var rest_hms_val = (rest_hms_h * 3600) + (rest_hms_m * 60);
   
        if ( (end_hms_val - str_hms_val - rest_hms_val) > 0 ) {
            var hour = parseInt((end_hms_val - str_hms_val - rest_hms_val)/3600);
            var min  = parseInt(((end_hms_val - str_hms_val - rest_hms_val)%3600)/60);

            if ( String(hour).length == "0" || String(hour).length == "1" ) {
                hour = "0" + String(hour);
            }
            if ( String(min).length == "0" || String(min).length == "1" ) {
                min  = "0" + String(min);
            }
            var tot = String(hour) + String(min);
      //      alert(tot);
            dsT_ME_DAYLEDGER.NameValue(row_num,"GUN_HMS") = String(hour) + String(min);
        } else if ( end_hms_val == "" && str_hms_val == "" && rest_hms_val == "" ) {
             dsT_ME_DAYLEDGER.NameValue(row,"GUN_HMS") = "";
        } else if ( end_hms_val == "" ) {
            alert("종업시각을 기입해 주십시오.");
        } else { 
            alert("잘못 기입하셨습니다. 다시 입력해 주십시오.");
            dsT_ME_DAYLEDGER.NameValue(row,"STR_HMS") = "";
            dsT_ME_DAYLEDGER.NameValue(row,"END_HMS") = "";
            dsT_ME_DAYLEDGER.NameValue(row,"GUN_HMS") = "";
            dsT_ME_DAYLEDGER.NameValue(row,"REST_HMS") = "";
        }
    </script>
<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
  <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">파견사원관리대장</td>
          <td align="right" class="navigator">HOME/인사관리/파견사원/<font color="#000000">파견사원관리대장</font></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="35" class="paddingTop5" align="right">
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a -->
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a -->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState" width="80">해당년월&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input type="text" id="txtSTR_YMD_SHR"  name="txtSTR_YMD_SHR" style="ime-mode:disabled" size="7" value="" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtSTR_YMD_SHR','','108','113');">
                                    <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td class="searchState" align="right" width="70">소속&nbsp;</td>
							    <td class="padding2423" align="left">
								    <input id="txtDPT_CD_SHR" size="3" maxlength="2"> 
                                    <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly" readonly>
		                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
                                    </a>
							    </td>
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SES name=txtENO_NO_SES type="hidden">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetEnoNm('txtENO_NO_SHR')"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR', '2');}">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl3Popup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="paddingTop8">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ME_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
							<param name="DataID"					value="dsT_ME_PERSON">
                            <param name="Format"					value='
                                <C> id={currow}		    width=60    name="NO"		        align=center   </C>
                                <C> id="DPT_CD"	        width=70	name="근무소속코드"	    align=center   </C>
                                <C> id="DPT_NM"		    width=100	name="근무소속명"		align=center   </C>
                                <G> name="업무관리자"  HeadBgColor="#F7DCBB"
                                <C> id="DUTY_CD"	    width=70	name="직책코드"         align=center   </C>
                                <C> id="DUTY_NM"	    width=70	name="직책명"           align=center   </C>
                                <C> id="SYENO_NO"	    width=60	name="사번"             align=center   </C>
                                <C> id="SYENO_NM"       width=60	name="성명"             align=center   </C>
                                </G>
                                <G> name="파견사원"  HeadBgColor="#F7DCBB"
                                <C> id="DISCOMP_CD"     width=70	name="회사코드"         align=center   </C>
							    <C> id="DISCOMP_NM"	    width=100	name="회사명"           align=center   </C>
                                <C> id="ENO_NO"		    width=60	name="사번"             align=center   </C>
                                <C> id="ENO_NM"	        width=60	name="성명"             align=center   </C>
                                <C> id="JOB_TAG"	    width=100	name="업무내용"         align=center   </C>
                                </G>
							'>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 그리드 테이블 끝-->

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
			    <tr>
			        <td class="paddingTop5">
			        
                        <div id="biz2" >
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="right">
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                                    </td>
                                </tr>
                            </table>                                
                        </div>
                        
                        <div id="biz1" style="display:none">                        	        
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
	                                <td width="420"></td>
	                                <td class="searchState" align="right">시업시각&nbsp;</td>
	                                <td>
	                                    <input id="txtSTR_HMS" name="txtSTR_HMS" size="8" maxlength="5" onblur="fncCheckHour(this);" onkeypress="cfHourColon(this);cfHourCheckNumber();"> 
	                                </td>
	                                <td width="10"></td>
	                                <td class="searchState" align="right">종업시각&nbsp;</td>
	                                <td>
	                                    <input id="txtEND_HMS" name="txtEND_HMS" size="8" maxlength="5" onblur="fncCheckHour(this);" onkeypress="cfHourColon(this);cfHourCheckNumber();"> 
	                                </td>
	                                <td align="right">
	                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnReflect','','/images/button/BatchCreateOver.gif',1)">
	                                    <img src="/images/button/BatchCreateOn.gif" id="btnReflect" name="btnReflect" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CreateBatch()">
	                                    </a>
	                                </td>
	                            </tr>
	                        </table>
	                    </div>
	                    
                    </td>
			    </tr>
            </table>
        </td>
    </tr>    
</table>

<!-- 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3" >
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ME_DAYLEDGER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
							<param name="DataID"					value="dsT_ME_DAYLEDGER">
                            <param name="Format"					value='
                                <C> id={currow}		    width=60    name="NO"		        align=center   	    Edit=none</C>
                                <C> id="PIS_YMD"	    width=60	name="일자"	            align=center   	    Edit=none</C>
                                <C> id="N1_CD"		    width=60	name="근태코드"		    align=center   	    Edit=none</C>
                                <G> name="업무관리자"  HeadBgColor="#F7DCBB"
                                <C> id="STR_HMS"	    width=60	name="시업시각"         align=center        mask="XX:XX"</C>
                                <C> id="END_HMS"	    width=60	name="종업시각"         align=center        mask="XX:XX"</C>
                                <C> id="GUN_HMS"	    width=60	name="근무시간"         align=center    mask="XX:XX"    Edit=none</C>
                                </G>
                                <C> id="REST_HMS"       width=60	name="휴식시간"         align=center        mask="XX:XX"</C>
							    <C> id="JOB_TAG"	    width=60	name="업무내용"         align=center   	    Edit=none</C>
                                <C> id="FLAG"		    width=60	name="담당확인"         align=center   </C>
							'>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 그리드 테이블 끝-->

<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">
<input type="hidden" name="rownum">
<input type="hidden" name="str_ymd">
<input type="hidden" name="click_rownum" value="1">
<input type="hidden" name="print_go" value="N">
<input type="hidden" name="colid">
</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
