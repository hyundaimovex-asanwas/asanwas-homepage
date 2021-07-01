<!--
    ************************************************************************************
    * @Source         : mema013.jsp                                                    *
    * @Description    : 인사기본4 PAGE                                                 *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>인사기본4</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if (form1.ENO_NO.value == "" || (parent.dsT_ME_PERSON.CountRow < 1 && parent.dsT_ME_PERSON.RowStatus(1) != 1)) {

                dsT_ME_FAMILY.ClearData();//가족사항
                dsT_ME_QUALIFICATION.ClearData();//자격면허
                dsT_ME_BHISTORY.ClearData();//입사전경력
                
                form1.grdT_ME_FAMILY.Editable = "false";
                form1.grdT_ME_QUALIFICATION.Editable = "false";
                form1.grdT_ME_BHISTORY.Editable = "false";
                
                document.getElementById("imgAppend1").disabled = true;
                document.getElementById("imgRemove1").disabled = true;
                document.getElementById("imgAppend2").disabled = true;
                document.getElementById("imgRemove2").disabled = true;
                document.getElementById("imgAppend3").disabled = true;
                document.getElementById("imgRemove3").disabled = true;

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;

            }else{
                form1.grdT_ME_FAMILY.Editable = "true";
                form1.grdT_ME_QUALIFICATION.Editable = "true";
                form1.grdT_ME_BHISTORY.Editable = "true";

	            document.getElementById("imgAppend1").disabled = false;
	            document.getElementById("imgRemove1").disabled = false;
	            document.getElementById("imgAppend2").disabled = false;
	            document.getElementById("imgRemove2").disabled = false;
	            document.getElementById("imgAppend3").disabled = false;
	            document.getElementById("imgRemove3").disabled = false;                            
            }            

            
            trT_ME_PERSON.KeyValue = "SVL(O:dsT_ME_FAMILY=dsT_ME_FAMILY, O:dsT_ME_QUALIFICATION=dsT_ME_QUALIFICATION, O:dsT_ME_BHISTORY=dsT_ME_BHISTORY)";
            trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema013.cmd.MEMA013CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            trT_ME_PERSON.post();

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

            //DataSet의 변경 여부 확인
            if (!dsT_ME_FAMILY.IsUpdated && !dsT_ME_QUALIFICATION.IsUpdated && !dsT_ME_BHISTORY.IsUpdated) {
//              document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_ME_PERSON2.KeyValue = "SVL(I:dsT_ME_FAMILY=dsT_ME_FAMILY, I:dsT_ME_QUALIFICATION=dsT_ME_QUALIFICATION, I:dsT_ME_BHISTORY=dsT_ME_BHISTORY)";
                trT_ME_PERSON2.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema013.cmd.MEMA013CMD&S_MODE=SAV";
                trT_ME_PERSON2.post();

            } else {

                return false;

            }

            return true;

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

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
        function fnc_Append(num) {
        
            if(num == "1"){
                dsT_ME_FAMILY.AddRow();
                
                form1.grdT_ME_FAMILY.setColumn(form1.grdT_ME_FAMILY.getColumnID(0));
                
                dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
                
            }else if(num == "2"){
                dsT_ME_QUALIFICATION.AddRow();
                
                form1.grdT_ME_QUALIFICATION.setColumn(form1.grdT_ME_QUALIFICATION.getColumnID(0));
                
                dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
                
            }else if(num == "3"){
                dsT_ME_BHISTORY.AddRow();
                
                form1.grdT_ME_BHISTORY.setColumn(form1.grdT_ME_BHISTORY.getColumnID(0));
                
                dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
                
            }

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove(num) {

            if(num == "1"){
	            if (dsT_ME_FAMILY.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }
	            
	            if (confirm("가족[" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"REL_NM") + "] [" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"ENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;
	
	            dsT_ME_FAMILY.DeleteRow(dsT_ME_FAMILY.RowPosition);
	            
	            form1.grdT_ME_FAMILY.setColumn(form1.grdT_ME_FAMILY.getColumnID(0));
                form1.grdT_ME_FAMILY.Focus();

            }else if(num == "2"){
	            if (dsT_ME_QUALIFICATION.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }
	            
	            if (confirm("자격면허[" + dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition,"QUA_NM") + "] 자료를 제거하시겠습니까?") == false) return;
	            
                dsT_ME_QUALIFICATION.DeleteRow(dsT_ME_QUALIFICATION.RowPosition);

                form1.grdT_ME_QUALIFICATION.setColumn(form1.grdT_ME_QUALIFICATION.getColumnID(0));
                form1.grdT_ME_QUALIFICATION.Focus();
            
            }else if(num == "3"){
	            if (dsT_ME_BHISTORY.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }
	            
	            if (confirm("회사명[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"CMP_NAM") + "] 입사일[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"STR_YMD") + "] 자료를 제거하시겠습니까?") == false) return;
	            
                dsT_ME_BHISTORY.DeleteRow(dsT_ME_BHISTORY.RowPosition);
            
                form1.grdT_ME_BHISTORY.setColumn(form1.grdT_ME_BHISTORY.getColumnID(0));
                form1.grdT_ME_BHISTORY.Focus();

            }

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_FAMILY.ClearData();
			dsT_ME_QUALIFICATION.ClearData();
			dsT_ME_BHISTORY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            var f = document.form1;
            
            for ( i = 1; i <= dsT_ME_FAMILY.CountRow; i++ ) {
                if ( dsT_ME_FAMILY.RowStatus(i) == 1 ||
                     dsT_ME_FAMILY.RowStatus(i) == 3 ) {
                     
                    // 가족관계
                    if( dsT_ME_FAMILY.NameValue(i, "REL_CD") == '' ) {
                        alert("가족관계는 필수 입력사항입니다.");
                        dsT_ME_FAMILY.RowPosition = i;
                        return false;
                    }
                    
                    // 성명
                    if( dsT_ME_FAMILY.NameValue(i, "ENO_NM") == '' ) {
                        alert("가족성명는 필수 입력사항입니다.");
                        dsT_ME_FAMILY.RowPosition = i;
                        return false;
                    }
                     
                }
            }
            
            for ( i = 1; i <= dsT_ME_QUALIFICATION.CountRow; i++ ) {
                if ( dsT_ME_QUALIFICATION.RowStatus(i) == 1 ||
                     dsT_ME_QUALIFICATION.RowStatus(i) == 3 ) {

                    // 자격면허
                    if( dsT_ME_QUALIFICATION.NameValue(i, "QUA_CD") == '' ) {
                        alert("자격면허는 필수 입력사항입니다.");
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        return false;
                    }
                    
                    // 취득일자
                    /*if( dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD") == '' ) {
                        alert("취득일자는 필수 입력사항입니다.");
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        return false;
                    } */                   

                }
            }
            
            for ( i = 1; i <= dsT_ME_BHISTORY.CountRow; i++ ) {
                if ( dsT_ME_BHISTORY.RowStatus(i) == 1 ||
                     dsT_ME_BHISTORY.RowStatus(i) == 3 ) {
                     
                    // 입사일자
                    if( dsT_ME_BHISTORY.NameValue(i, "STR_YMD") == '' ) {
                        alert("입사일자는 필수 입력사항입니다.");
                        dsT_ME_BHISTORY.RowPosition = i;
                        return false;
                    }
                    
                }
            }            
            

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";
            
            //Grid Style 적용
            cfStyleGrid(form1.grdT_ME_FAMILY, 15,"false","false");
            form1.grdT_ME_FAMILY.HiddenHScroll  = true;
            form1.grdT_ME_FAMILY.DisableNoHScroll = false;
            cfStyleGrid(form1.grdT_ME_QUALIFICATION, 15,"false","false");
            form1.grdT_ME_QUALIFICATION.HiddenHScroll  = true;
            form1.grdT_ME_QUALIFICATION.DisableNoHScroll = false;
            cfStyleGrid(form1.grdT_ME_BHISTORY, 15,"false","false");
            form1.grdT_ME_BHISTORY.HiddenHScroll  = true;
            form1.grdT_ME_BHISTORY.DisableNoHScroll = false;
            
            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_FAMILY                       |
    | 3. Table List : T_ME_FAMILY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_QUALIFICATION                       |
    | 3. Table List : T_ME_QUALIFICATION                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_BHISTORY                       |
    | 3. Table List : T_ME_BHISTORY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_BHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_PERSON2                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_FAMILY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_FAMILY.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <Script For=dsT_ME_QUALIFICATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_QUALIFICATION.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <Script For=dsT_ME_BHISTORY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_BHISTORY.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_FAMILY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
        
    </Script>
        
    <Script For=dsT_ME_QUALIFICATION Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
        
    </Script>
        
    <Script For=dsT_ME_BHISTORY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
        
    </Script>    
    
    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_FAMILY Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[관계/성명] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("관계/성명에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsT_ME_QUALIFICATION Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[자격면허/취득일] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("자격면허/취득일에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsT_ME_BHISTORY Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[입사일] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("입사일에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>
    
    <script for=trT_ME_PERSON2 event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        if (parent.savflag != '1') {
            parent.savflag = 1;
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>
    
    <script for=trT_ME_PERSON2 event="OnFail()">

        cfErrorMsg(this);

    </script>
    
    <script language="javascript"  for=grdT_ME_FAMILY event=OnExit(row,colid,olddata)>

        if(colid == "BIR_YMD"){
            if(dsT_ME_FAMILY.NameValue(row,colid) != "" && !cfDateExpr(dsT_ME_FAMILY.NameValue(row,colid))){
                alert('날짜형식에 맞지않습니다.');
                dsT_ME_FAMILY.NameValue(row,colid) = "";
            }
        }

    </script>
    
    <script language="javascript"  for=grdT_ME_QUALIFICATION event=OnExit(row,colid,olddata)>

        if(colid == "GAN_YMD"){
            if(dsT_ME_QUALIFICATION.NameValue(row,colid) != "" && !cfDateExpr(dsT_ME_QUALIFICATION.NameValue(row,colid))){
                alert('날짜형식에 맞지않습니다.');
                dsT_ME_QUALIFICATION.NameValue(row,colid) = "";
            }
        }

    </script>
    
    <script language="javascript"  for=grdT_ME_BHISTORY event=OnExit(row,colid,olddata)>

        if(colid == "STR_YMD" || colid == "END_YMD"){
            if(dsT_ME_BHISTORY.NameValue(row,colid) != "" && !cfDateExpr(dsT_ME_BHISTORY.NameValue(row,colid))){
                alert('날짜형식에 맞지않습니다.');
                dsT_ME_BHISTORY.NameValue(row,colid) = "";
            }
            
            if( dsT_ME_BHISTORY.NameValue(row, "STR_YMD") != '' && dsT_ME_BHISTORY.NameValue(row, "END_YMD") != '' ) {
                if( cfDateDiff(dsT_ME_BHISTORY.NameValue(row, "STR_YMD").replace(/\-/g,''),dsT_ME_BHISTORY.NameValue(row, "END_YMD").replace(/\-/g,'')) < 0 ) {
                    alert("입사일자가 퇴사일자보다 큽니다.");
                    dsT_ME_BHISTORY.RowPosition = row;
                    dsT_ME_BHISTORY.NameValue(row,"END_YMD") = "";
                    return false;
                }
            }
            
        }

    </script>
    
    <script language=JavaScript for=grdT_ME_FAMILY event=OnClick(row,colid)>
    
	   if(colid == "REL_NM" && dsT_ME_FAMILY.RowStatus(dsT_ME_FAMILY.RowPosition) == 1){
	       var obj =  new String();
	       obj = fnc_commonCodePopupReturn('가족관계','G1');
	       
	       if(obj != null){
	           dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "REL_CD") = obj.comm_cd;
	           dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "REL_NM") = obj.comm_nm;
	       }
       
       }
	   
	   if(colid == "EDGR_NM"){
	       var obj =  new String();
	       obj = fnc_commonCodePopupReturn('학력구분','E1');
	       
           if(obj != null){
               dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "EDGR_CD") = obj.comm_cd;
               dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "EDGR_NM") = obj.comm_nm;
           }	       
	   
	   }
	
    </script>
    
    <script language=JavaScript for=grdT_ME_QUALIFICATION event=OnClick(row,colid)>

       if(colid == "QUA_NM" && dsT_ME_QUALIFICATION.RowStatus(dsT_ME_QUALIFICATION.RowPosition) == 1){
           var obj =  new String();
           obj = fnc_commonCodePopupReturn('자격면허','H1');
           
           if(obj != null){
               dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition, "QUA_CD") = obj.comm_cd;
               dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition, "QUA_NM") = obj.comm_nm;
           }           
       
       }
	
    </script>

    
    


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>가족사항</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend1','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('1');return false;"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove1','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove('1');return false;"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
	        <comment id="__NSID__">
	        <object id="grdT_ME_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:99px;">
	            <param name="DataID"                  value="dsT_ME_FAMILY">
	            <param name="Format"                  value="
	                <C> id={currow}        width=39    name='NO'           align=center   Edit=none   </C>
	                <C> id=REL_NM          width=110   name='관계'         align=center   Edit=none   </C>
	                <C> id=ENO_NM          width=110   name='성명'         align=center               </C>
	                <C> id=BIR_YMD         width=110   name='생년월일'     align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
	                <C> id=EDGR_NM         width=110   name='학력'                        Edit=none   </C>
	                <C> id=OCC_NAM         width=169   name='근무처'                                  </C>
	                <C> id=JOB_CD          width=110   name='직위'                                    </C>
	            ">
	        </object>
	        </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="80"></col>
        <col width="215"></col>
        <col width="7"></col>
        <col width="100"></col>
        <col width=""></col>
    </colgroup>
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>자격면허</strong>
        </td>
        <td height="25" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend2','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('2');return false;"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove2','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove('2');return false;"></a>
        </td>
        <td></td>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>입사전경력</strong>
        </td>
        <td height="25" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend3','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('3');return false;"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove3','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove('3');return false;"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
	        <comment id="__NSID__">
            <object id="grdT_ME_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:99px;">
                <param name="DataID"                  value="dsT_ME_QUALIFICATION">
                <param name="Format"                  value="
                    <C> id={currow}        width=24   name='NO'           align=center   Edit=none   </C>
                    <C> id=QUA_NM          width=80   name='자격면허'                    Edit=none   </C>
                    <C> id=GAN_YMD         width=70   name='취득일'       align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
                    <C> id=APP_ADM         width=89   name='발행처'                                  </C>
                ">
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
        <td>
	        <comment id="__NSID__">
            <object id="grdT_ME_BHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:495px;height:99px;">
                <param name="DataID"                  value="dsT_ME_BHISTORY">
                <param name="Format"                  value="
                    <C> id={currow}        width=24   name='NO'           align=center   Edit=none   </C>
                    <C> id=CMP_NAM         width=90   name='회사명'                                  </C>
                    <C> id=STR_YMD         width=70   name='입사일'       align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
                    <C> id=END_YMD         width=70   name='퇴사일'       align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
                    <C> id=JOB_CD          width=50   name='직위'                                    </C>
                    <C> id=SAL_AMT         width=65   name='급여액'       align=right                </C>
                    <C> id=CHG_JOB         width=90   name='담당업무'     align=left                 </C>
                ">
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->