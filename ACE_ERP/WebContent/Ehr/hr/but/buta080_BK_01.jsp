<!--
*****************************************************
* @source       : buta080.jsp
* @description : 철도이용계약할인신청 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/21      김학수        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>철도이용계약할인신청(buta080)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
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
          if ( f.flag.value == "Y" ) 
          {
              var CD_GBN = "7771-110";
              var CD_GBN_VAL;
      //        dsT_DI_BUSINESSTRIP_KORAIL.SetDataHeader("partno:STRING(3)");
      //        dsT_DI_BUSINESSTRIP_KORAIL.ImportData('22');
              var today_ymd_val = f.today_ymd_val.value;           // 발행일
              var ymd1_ins_val = f.ymd1_ins_val.value;               // 출장일1
              var str_code1 = f.str_code1.value;                         // 출발구간코드값1
              var end_code1 = f.end_code1.value;                     // 도착구간코드값1
              var kor_type1 = f.kor_type1.value;                          // 차종1
              var ymd2_ins_val = f.ymd2_ins_val.value;              // 출장일2
              var str_code2 = f.str_code2.value;                        // 출발구간코드값2
              var end_code2 = f.end_code2.value;                    // 도착구간코드값2
              var kor_type2 = f.kor_type2.value;                         // 차종2
              var user_name = f.user_name.value;                   // 입력자
              var user_no = f.user_no.value;  
              var gubun2_flag = f.gubun2_flag.value;
              
              var param_dao = "&today_ymd_val="+today_ymd_val+"&ymd1_ins_val="+ymd1_ins_val+"&str_code1="+str_code1+"&end_code1="+end_code1+"&kor_type1="+kor_type1+"&ymd2_ins_val="+ymd2_ins_val+"&str_code2="+str_code2+"&end_code2="+end_code2+"&kor_type2="+kor_type2+"&user_name="+user_name+"&user_no="+user_no+"&gubun2_flag="+gubun2_flag;
    /*  
              dsT_DI_BUSINESSTRIP_KORAIL.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta080.cmd.BUTA080CMD&S_MODE=SHR&CD_GBN=" + CD_GBN + param_dao;
              dsT_DI_BUSINESSTRIP_KORAIL.reset();
             
              if(!fnc_SaveItemCheck()) return;
      */ 
              trT_DI_BUSINESSTRIP_KORAIL.KeyValue = "tr01(O:DS_ONE=dsT_DI_BUSINESSTRIP_KORAIL)";
              trT_DI_BUSINESSTRIP_KORAIL.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta080.cmd.BUTA080CMD&S_MODE=SHR&CD_GBN=" + CD_GBN + param_dao;
              trT_DI_BUSINESSTRIP_KORAIL.post();
              
              CD_GBN_VAL = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(0,"ORD_NO") + 1;
              if ( String(CD_GBN_VAL).length == "1" ) {
                  CD_GBN_VAL = "00" + CD_GBN_VAL;
              } else if (String(CD_GBN_VAL).length == "2" ) {
                  CD_GBN_VAL = "0" + CD_GBN_VAL;
              }
              CD_GBN = CD_GBN + "-" + CD_GBN_VAL;
    //          alert(CD_GBN_VAL);
              fnc_report(CD_GBN, CD_GBN_VAL);
              form1.aaa.RunButton('print_go');
    //          goclick('print');
          }
          else
          {
              alert("미리보기 화면을 클릭하여, 출력물을 확인 후 인쇄하실 수 있습니다.");
          }
        }
        
        function goclick(x) {
           if( !form1.aaa.RunButton(x) ) {	
               alert("개체가 없습니다.");
           }
        }
        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

      // 엑셀로 변환 할 자료가 있는지 체크하고
      // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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
           var f = document.form1;
           obj1 = getObj("imgYMD_TRUE"); 
           obj2 = getObj("imgSTR_TRUE"); 
           obj3 = getObj("imgEND_TRUE"); 
  
           f.txtBUT_YMD2_INS.readOnly  = true;
           f.cmbKOR_TYPE2_INS.disabled  = true;
  
           obj1.visibility = "hidden";
           obj2.visibility = "hidden";
           obj3.visibility = "hidden";
           f.txtBUT_YMD2_INS.value = "";
           f.txtSTR_CITY2_INS.value = "";
           f.txtEND_CITY2_INS.value = "";
           f.chkGUBUN_INS2.checked = false;
           f.txtBUT_YMD1_INS.value = "";
           f.txtSTR_CITY1_INS.value = "";
           f.txtEND_CITY1_INS.value = "";
           f.flag.value = "N";
           document.form1.aaa.OpenHnw("/hr/but/buta080.hnw","");
           f.flag.value = "N";
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

          if (dsT_DI_BUSINESSTRIP_KORAIL.IsUpdated)  {
    
            if (!fnc_ExitQuestion()) return;

          }
    
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

          if (!dsT_DI_BUSINESSTRIP_KORAIL.IsUpdated) {
                    alert("저장할 자료가 없습니다.");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                    return false;
          }
          return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

 //         cfStyleGrid(form1.grdT_DI_BUSINESSTRIP_KORAIL,15,"false","right")      // Grid Style 적용

//          document.form1.txtDPT_CD_SHR.focus();

         }

    /********************
     * 15. 단축키 처리        *
     *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }

    /********************************************
    * 날짜 형식 유효성 체크                           			     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return; 
            if(!cfDateExpr(obj.value)) { 
                alert('유효한 날짜가 아닙니다.'); 
                obj.focus();
            }
        }
    /********************************************
    * ez-gen (미리보기)                          			     *
    ********************************************/
        function fnc_report(CD_GBN, CD_GBN_VAL) {
            var f = document.form1;
            var param = "";
            var param1 = "";
            var param2 = "";
            var param3 = "";
            
            var user_name = "<%=box.get("SESSION_ENONM")%>";   // 사원이름
            var user_no = "<%=box.get("SESSION_ENONO")%>";    // 사원번호
            
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var s_year  = String(year);
            var s_month = String(month);
            var s_day = String(day);
            var s_month_val = "";
            var s_day_val = "";
            
            if ( s_month.length == "1") s_month_val = "0"+s_month;
            else s_month_val = s_month;
            if ( s_day.length == "1") s_day_val = "0"+s_day;
            else s_day_val = s_day;
            
            var CDay = new Date(s_year, 6, 30, 18, 0, 0);
            
            var ymd_val;
            var today_ymd_val = s_year + s_month_val + s_day_val;
            var today_ymd = s_year + "년 " + s_month + "월 " + s_day + "일";
            
            var CDay_sec =  CDay.getTime();
            var date_sec = date.getTime(); 
            
            if ( date_sec <= CDay_sec )
                ymd_val = s_year + "년 1월 1일 ~ 6월 30일 승차분";
            else 
                ymd_val = s_year + "년 7월 1일 ~ 12월 31일 승차분";
//            alert(ymd_val);
            param3 = "[@InitPage]=Page1[:cd_gbn]=" + CD_GBN + "[:cd_gbn_val]=" + CD_GBN_VAL + "[:user_name]=" + user_name + "[:user_no]=" + user_no+ "[:today_ymd]=" + today_ymd+"[:ymd_val]=" + ymd_val;
            var ymd1_ins = f.txtBUT_YMD1_INS.value;
            var ymd1_ins_val = ymd1_ins.substr(0,4) + ymd1_ins.substr(5,2) + ymd1_ins.substr(8,2);
            var str_city1 = f.txtSTR_CITY1_INS.value;
            var end_city1 = f.txtEND_CITY1_INS.value;
            var kor_type1 = f.cmbKOR_TYPE1_INS.value;
            var kor_type1_val;
            if ( kor_type1 == "0" ) kor_type1_val = "KTX";
            else if ( kor_type1 == "1" ) kor_type1_val = "새마을호";
            else if ( kor_type1 == "2" ) kor_type1_val = "무궁화호";
            
            //-------------------------------------------------------------- 철도이용-1
            if ( f.txtBUT_YMD1_INS.value == "" || f.txtBUT_YMD1_INS.value == null ) {
                alert("이용일자를 입력해 주십시오!");
                f.txtBUT_YMD1_INS.focus();
                return false;
            }
            if ( f.txtSTR_CITY1_INS.value == "" || f.txtSTR_CITY1_INS.value == null ) {
                alert("구간란을 입력해 주십시오!");
                f.txtSTR_CITY1_INS.focus();
                return false;
            }
            if ( f.txtEND_CITY1_INS.value == "" || f.txtEND_CITY1_INS.value == null ) {
                alert("구간란을 입력해 주십시오!");
                f.txtEND_CITY1_INS.focus();
                return false;
            }
            param1 = "[:ymd1_ins]=" + ymd1_ins + "[:str_city1]=" + str_city1+ "[:end_city1]=" + end_city1+"[:kor_type1_val]=" + kor_type1_val;
            
            //-------------------------------------------------------------- 철도이용-2
            if ( f.chkGUBUN_INS2.checked == true ) {   
                var ymd2_ins = f.txtBUT_YMD2_INS.value;
                var ymd2_ins_val = ymd2_ins.substr(0,4) + ymd2_ins.substr(5,2) + ymd2_ins.substr(8,2);
                var str_city2 = f.txtSTR_CITY2_INS.value;
                var end_city2 = f.txtEND_CITY2_INS.value;
                var kor_type2 = f.cmbKOR_TYPE2_INS.value;
                var kor_type2_val;
                if ( kor_type2 == "0" ) kor_type2_val = "KTX";
                else if ( kor_type2 == "1" ) kor_type2_val = "새마을호";
                else if ( kor_type2 == "2" ) kor_type2_val = "무궁화호";
                
                if ( f.txtBUT_YMD2_INS.value == "" || f.txtBUT_YMD2_INS.value == null ) {
                    alert("이용일자를 입력해 주십시오!");
                    f.txtBUT_YMD2_INS.focus();
                    return false;
                }
                if ( f.txtSTR_CITY2_INS.value == "" || f.txtSTR_CITY2_INS.value == null ) {
                    alert("구간란을 입력해 주십시오!");
                    f.txtSTR_CITY2_INS.focus();
                    return false;
                }
                if ( f.txtEND_CITY2_INS.value == "" || f.txtEND_CITY2_INS.value == null ) {
                    alert("구간란을 입력해 주십시오!");
                    f.txtEND_CITY2_INS.focus();
                    return false;
                }
                
                param2 = "[:ymd2_ins]=" + ymd2_ins + "[:str_city2]=" + str_city2 + "[:end_city2]=" + end_city2 +"[:kor_type2_val]=" + kor_type2_val;
                f.gubun2_flag.value = "Y";
                f.ymd2_ins_val.value = ymd2_ins_val;                       // 출장일2
                f.str_code2.value = f.txtSTR_CODE2_INS.value;         // 출발구간코드값2
                f.end_code2.value = f.txtEND_CODE2_INS.value;       // 도착구간코드값2
                f.kor_type2.value = kor_type2;                                    // 차종2
            } else {
                f.gubun2_flag.value = "";
                f.ymd2_ins_val.value = "";    // 출장일2
                f.str_code2.value = "";         // 출발구간코드값2
                f.end_code2.value = "";       // 도착구간코드값2
                f.kor_type2.value = "";                                    // 차종2
            }
            //-------------------------------------------------------------------
            param = param3 + param1 + param2;
            
            f.today_ymd_val.value = today_ymd_val;                   // 발행일
            f.ymd1_ins_val.value = ymd1_ins_val;                       // 출장일1
            f.str_code1.value = f.txtSTR_CODE1_INS.value;         // 출발구간코드값1
            f.end_code1.value = f.txtEND_CODE1_INS.value;       // 도착구간코드값1
            f.kor_type1.value = kor_type1;                                    // 차종1
            
            f.user_name.value = user_name;                              // 입력자
            f.user_no.value = user_no;
 
            f.flag.value = "Y";
            if ( CD_GBN == "" )
            {
                document.form1.aaa.OpenHnw("/hr/but/buta080.hnw",param);
            } else {
                document.form1.aaa.SetValues("[:cd_gbn]=" + CD_GBN);
                document.form1.aaa.SetValues("[:cd_gbn_val]=" + CD_GBN_VAL);
            }
            
        }
    
     /********************************************
    * 철도이용-2 선택시 활성, 비활성화                			     *
    ********************************************/    
        function fnc_GUBUN(gb) {
            var f = document.form1;
            obj1 = getObj("imgYMD_TRUE"); 
            obj2 = getObj("imgSTR_TRUE"); 
            obj3 = getObj("imgEND_TRUE"); 
            if ( gb == true ) {
                f.txtBUT_YMD2_INS.readOnly  = false;
                f.cmbKOR_TYPE2_INS.disabled  = false;

                obj1.visibility = "visible";
                obj2.visibility = "visible";
                obj3.visibility = "visible";
            } else if ( gb == false ) {
                f.txtBUT_YMD2_INS.readOnly  = true;
                f.cmbKOR_TYPE2_INS.disabled  = true;

                obj1.visibility = "hidden";
                obj2.visibility = "hidden";
                obj3.visibility = "hidden";
                f.txtBUT_YMD2_INS.value = "";
                f.txtSTR_CITY2_INS.value = "";
                f.txtEND_CITY2_INS.value = "";
            }
        }
        
        function getObj(obj) { 
            if (nscp) { 
                compLayr = document.layers[obj] 
            }else{ 
                compLayr = eval("document.all." + obj + ".style") 
            } 
            return compLayr 
        } 
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_BUSINESSTRIP_KORAIL                      |
    | 3. Table List : VI_T_CM_PERSON, T_DI_BUSINESSTRIP_KORAIL, T_CM_DEPT                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_KORAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-----------------------------------------------------+
    | 1. 조회용 DataSet(copy)									   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_KORAIL_CP)			   |
    | 3. 사용되는 Table List(dsT_DI_BUSINESSTRIP_KORAIL, ) 				   |
    +------------------------------------------------------>
    <Object ID="dsT_DI_BUSINESSTRIP_KORAIL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_KORAIL)		|
    | 3. 사용되는 Table List(T_CM_PERSON, T_DI_BUSINESSTRIP_KORAIL)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_KORAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

          alert("검색하신 조건의 자료가 없습니다.");
          fnc_Message(document.getElementById("resultMessage"), "MSG_02");
   //       document.form1.txtENO_NO_SHR.focus();

        } else {

          fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
 //         document.form1.grdT_DI_BUSINESSTRIP_KORAIL.focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_KORAIL event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_KORAIL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | Grid 이벤트 처리  |
    +--------------------------->

    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">철도이용계약할인신청</td>
                    <td align="right" class="navigator">HOME/근태관리/출장관리/<font color="#000000">철도이용계약할인신청</font></td>
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
            <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a -->
            <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!--  a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<table border="0"><tr><td height="10"></td></tr></table>

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="800" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">   
                <tr>
                    <td align="center" class="creamBold" width="100">구    분</td>
                    <td class="padding2423" align="center" width="350">
                        <input type="checkbox" name="chkGUBUN_INS1" border="0" checked>철도이용-1
                    </td>
                    <td class="padding2423" align="center" width="350">
                        <input type="checkbox" name="chkGUBUN_INS2" border="0" onClick="fnc_GUBUN(this.checked)">철도이용-2
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" width="100">이용일자</td>
                    <td class="padding2423" align="center" width="350">
                        <input type="text" id="txtBUT_YMD1_INS" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_INS1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtBUT_YMD1_INS','','108','113');">
                        <img src="/images/button/btn_HelpOn.gif" name="img_YMD_INS1" width="21" height="20" border="0" align="absmiddle">
                        </a>
                    </td>
                    <td class="padding2423" align="center" width="350">
                        <input type="text" id="txtBUT_YMD2_INS" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" readOnly>
                        <span id="imgYMD_TRUE" style="position:absolute; z-index:1; visibility: hidden">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_INS1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtBUT_YMD2_INS','','108','113');">
                            <img src="/images/button/btn_HelpOn.gif" name="img_YMD_INS1" width="21" height="20" border="0" align="absmiddle">
                            </a>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">구    간</td>
                    <td class="padding2423" align="center">
                        <input type="hidden" id=txtSTR_CODE1_INS name=txtSTR_CODE1_INS>
                        <input id=txtSTR_CITY1_INS name=txtSTR_CITY1_INS size="10" class="input_ReadOnly" readonly> 
                        <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSTR_CODE1_INS','txtSTR_CITY1_INS','구간','T5')" style="cursor:hand">
                        &nbsp;->
                        <input type="hidden" id=txtEND_CODE1_INS name=txtEND_CODE1_INS>
                        <input id=txtEND_CITY1_INS name=txtEND_CITY1_INS size="10" class="input_ReadOnly" readonly> 
                        <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEND_CODE1_INS','txtEND_CITY1_INS','구간','T5')" style="cursor:hand">
               
                    </td>
                    <td class="padding2423" align="center">
                        <input type="hidden" id=txtSTR_CODE2_INS name=txtSTR_CODE2_INS>
                        <input id=txtSTR_CITY2_INS name=txtSTR_CITY2_INS size="10" class="input_ReadOnly" readonly> 
                        <span id="imgSTR_TRUE" style="position:absolute; z-index:1; visibility: hidden">
                            <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSTR_CODE2_INS','txtSTR_CITY2_INS','구간','T5')" style="cursor:hand">
                        </span>
                        &nbsp;->
                        <input type="hidden" id=txtEND_CODE2_INS name=txtEND_CODE2_INS>
                        <input id=txtEND_CITY2_INS name=txtEND_CITY2_INS size="10" class="input_ReadOnly" readonly> 
                        <span id="imgEND_TRUE" style="position:absolute; z-index:1; visibility: hidden">
                            <img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEND_CODE2_INS','txtEND_CITY2_INS','구간','T5')" style="cursor:hand">
                        </span>
                    </a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">차    종</td>
                    <td class="padding2423" align="center">
                        <select id="cmbKOR_TYPE1_INS" name="cmbKOR_TYPE1_INS" style="WIDTH: 50%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                            <option value='0'>KTX</option>
                            <option value='1'>새마을호</option>
                            <option value='2'>무궁화호</option>
                        </select>
                    </td>
                    <td class="padding2423" align="center">
                        <select id="cmbKOR_TYPE2_INS" name="cmbKOR_TYPE2_INS" style="WIDTH: 50%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" disabled>
                            <option value='0'>KTX</option>
                            <option value='1'>새마을호</option>
                            <option value='2'>무궁화호</option>
                        </select>
                    </td>
                 </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->
<table width="800" height="10" border="0" cellspacing="0" cellpadding="0">
    <tr><td>&nbsp;</td></tr>
</table>
<center>
<table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="padding2423">
            1. 철도를 이용한 출장시 철도요금 할인신청서를 출력하며 사용하시기 바랍니다.<br>
            &nbsp;&nbsp;&nbsp;( 할인율 : 주중 20% 주말 5% )<br>
            2. 동행인이 있을 경우 개인별로 신청서를 출력하며 사용하여야 합니다.<br>
            3. 신청서 1장에 왕복입력 가능함으로 3회이상 철도이용시에는 추가로 입력하여 사용하시기 바랍니다.<br>
            4. <font color=blue><b>인쇄</b></font> 버튼을 누르면 자동출력 되오니 출력물을 확인해 보시기 바랍니다.<br>
            &nbsp;&nbsp;&nbsp;(<font color=blue><b> 미리보기</b></font> 버튼을 클릭하여 출력물을 미리 확인해 보실 수 있습니다. )
            
        </td>
    </tr>
    <tr><td height="10"></td></tr>
    <tr>
        <td align="center">
            <input type="button" name="btnREPORT" value="미리보기" style="background:white;cursor:hand" onClick="fnc_report('','')" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">&nbsp;&nbsp;
        </td>
    </tr>
</table>
</center>
<!--************************************************************** ezgen -->
<table border=0>
    <tr height="150">
        <td width="800">
            <table border="00" bordercolordark="white" bordercolorlight="gray" bordercolor="gray">
              <comment id="__NSID__">
              <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <!-- param name="hnwsrc"    VALUE="buta080.hnw" -->
              <param name="initvalue" VALUE="[@InitPage]=Page1[:aaa]=aa[:bbb]=aa">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
              </comment><script> __ShowEmbedObject(__NSID__); </script>
           </table>
        </td>
    </tr>
</table>
<!--************************************************************** ezgen -->
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

<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">

<input type="hidden" name="today_ymd_val">
<input type="hidden" name="ymd1_ins_val">
<input type="hidden" name="str_code1">
<input type="hidden" name="end_code1">
<input type="hidden" name="kor_type1">
<input type="hidden" name="gubun2_flag">
<input type="hidden" name="ymd2_ins_val">
<input type="hidden" name="str_code2">
<input type="hidden" name="end_code2">
<input type="hidden" name="kor_type2">
<input type="hidden" name="user_name">
<input type="hidden" name="user_no">


</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
