<!--
*****************************************************
* @source       : vluj011.jsp
* @description  : 개인별 JOB PROFILE PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String prmENO_NO    = request.getParameter("ENO_NO");
	String prmENO_NM    = request.getParameter("ENO_NM");
%>

<html>
<head>
<title>개인별 JOB PROFILE(vluj011)</title>
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

        var btnList = 'TFTTTFFT';

        //var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";
        var ActiveIndex = 0;
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
        	var BASIC_YMD_SHR   = "201207";               
        	var ENO_NO   = "<%=prmENO_NO%>";    

	       //정보 조회
	       dsT_EV_JOBSPEC.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.j.vluj010.cmd.VLUJ010CMD&S_MODE=SHR&BASIC_YMD_SHR="+BASIC_YMD_SHR+"&ENO_NO="+ENO_NO;	    
		   dsT_EV_JOBSPEC.reset();

			if(dsT_EV_JOBSPEC.countrow<1){
				fnc_Add();
			}else{
		    	ifrm.fnc_Row_Clear(2); //초기화
			}
				ifrm.fnc_SearchList();

        }

        /***********************************
         * 				fnc_Add			    *
         ***********************************/
        function fnc_Add() {

            //이곳에 해당 코딩을 입력 하세요
          	var REG_YM_SHR = document.form1.cmbYMD_SHR.value;        //해당년도
          	var EMPNO 	= document.form1.txtENO_NO_SHR.value;           //피고과자

			//if(!fnc_Add_Chk()) false;

            trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.j.vluj010.cmd.VLUJ010CMD&S_MODE=SHR_00&EMPNO="+EMPNO;
            trT_EV_ABLRST.post();

		  	i = dsT_EV_ABLRST.rowposition;

		  	fnc_SetDataHeader();

		  	dsT_EV_HWORKMST.Addrow();

			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EVAYM")		= document.form1.cmbYMD_SHR.value; 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"ENO_NO")  	= dsT_EV_ABLRST.namevalue(i,"ENO_NO");   
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"HEAD_CD") 	= dsT_EV_ABLRST.namevalue(i,"HEAD_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DPT_CD")  	= dsT_EV_ABLRST.namevalue(i,"DPT_CD"); 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"TEAM_CD") 	= dsT_EV_ABLRST.namevalue(i,"TEAM_CD");  
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOB_CD") 	= dsT_EV_ABLRST.namevalue(i,"JOB_CD");  
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOBGRPH")	= dsT_EV_ABLRST.namevalue(i,"JOBGRPH"); 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOBRR")		= dsT_EV_ABLRST.namevalue(i,"JOBRR"); 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOBKIND")	= dsT_EV_ABLRST.namevalue(i,"JOBKIND"); 	

			ifrm.fnc_Row_Clear(2); //초기화
        }

        
        
        /******************************************************************************
    	Description : 데이타셋 헤드 설정 (dsT_EV_HWORKMST)
        parameter   :
       ******************************************************************************/
	    function fnc_SetDataHeader(){
	      
	          //인적사항,직무분휴,직무개요
	    	if (dsT_EV_HWORKMST.countrow<1){
	    		var s_temp = " EVAYM:STRING(6),ENO_NO:STRING(7),HEAD_CD:STRING(4),"
	    							 + " DPT_CD:STRING(4),TEAM_CD:STRING(4),JOB_CD:STRING(4),"
	    							 + " JOBGRPH:STRING(20),JOBRR:STRING(20),JOBKIND:STRING(20),JOBNAME:STRING(80),"
	    							 + " JOBSM:STRING(2000),"
				 					 + " EDU:STRING(1),MAJOR:STRING(40),SEX:STRING(1),ETC:STRING(100),EXP:STRING(200),"
				 					 + " CERTIFICATE:STRING(200),FRGRD:STRING(200),OAGRD:STRING(200),TECH:STRING(500),"	
				 					 + " STUDY:STRING(200),STUDY2:STRING(200),STUDY3:STRING(200)";					 					 
	    		dsT_EV_HWORKMST.SetDataHeader(s_temp);
	    	}
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

        	ifrm.fnc_Save();

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
        	ifrm.fnc_Print();
        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_JOBSPEC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("개인별 JOB PROFILE", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_EV_JOBSPEC.CountRow < 1) {
            	fnc_SearchList();
            }            
           
            document.form1.txtJOBNAME.focus();
        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요
         	ifrm.fnc_Add();
        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요
        	ifrm.fnc_Delete();
        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {


            dsT_EV_JOBSPEC.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            f.txtDPT_CD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            //if (dsT_EV_JOBSPEC.IsUpdated)  {
            //    if (!fnc_ExitQuestion()) return;
            //}
            
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



        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

				document.getElementById("txtENO_NO_SHR").value="<%=prmENO_NO%>";   
				document.getElementById("txtENO_NM_SHR").value="<%=prmENO_NM%>"; 
			
			    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
		    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");	
		    	
				fnc_SearchList();    	
        }

        
			/******************************************************************************************
			Descrition : 입력값 체크 (db2 입력시 입력값 2byte 변환후 자릿수 체크)
			******************************************************************************************/
			function bytelength(fe,bstr,mx) {
	
				var xx = "";
				var yy = "";
				var len = bstr.length;
		
				for (var i=0; i<bstr.length; i++) {
					xx = bstr.substr(i,1).charCodeAt(0);
					if (i!=0) yy = bstr.substr(i-1,1).charCodeAt(0);
		
					if (i==0) {
						if (xx>127) {	len++;len++; }
					} else {
						if (yy!="") {
							if (yy>127) { len++; }
							else { if (xx>127) { len++;len++; } }
						}
					}
				}
		
				if (bstr.substr(bstr.length-1,1).charCodeAt(0)>127) len++;
		
				// 클경우 메시지 뿌리기
				if (mx < len){
					alert('입력한 글이 길어서 잘릴수 있습니다.\n다시 입력하여 주십시요');
					fe.focus();
					fe.select();
				}
		
				return len;
			}

        
	        //Layer ID
	        var layerList = new Array(  "tabvluj020_01"
	                                   ,"tabvluj020_02" );

	        //검색조건
	        var searchList = new Array( "changeDate_01"
	                                   ,"changeDate_02" );        
        
	    /********************
	       * 해당 레이어 보여주고 닫기
	       * @param 클릭한 layer idx
	       *******************/
	    function TabEvent(idx) {        
        
            ActiveIndex = idx+1;
            
			if(ActiveIndex==1){   //직무기술

			}else{               //직무명세

			}	    	
			
			
			
            //Layer 보여주고 닫기
            fnc_ShowHiddenLayer(layerList, layerList[idx]);
            fnc_ShowHiddenLayer(searchList, searchList[idx]);	    	
	    	
        }
	    	
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ESTINFO)   |
    | 3. 사용되는 Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="False">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="False">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_JOBSPEC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="False">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


    <!--************************************* *
    *  Component에서 발생하는 Event 처리부  * *
    **************************************-->
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_JOBSPEC Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_JOBSPEC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별 JOB PROFILE</td>
					<td align="right" class="navigator">HOME/인사평가/고과평가/<font color="#000000">개인별 JOB PROFILE</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
	                            <col width="130"></col>
	                            <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">기준월&nbsp;</td>
				                <td class="padding2423" align="left">
									<select id="cmbYMD_SHR" style="width:80">
										<option value="201207">2012-07</option>
										<option value="200902">2009-02</option>
									</select>
				                </td>								
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="6" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>1. 직무 수행자 인적사항</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="80"></col>
                    <col width="60"></col>
                    <col width="300"></col>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id=txtENO_NO name=txtENO_NO size="7" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input id=txtHEAD_NM name=txtHEAD_NM size="12" class="input_ReadOnly" readonly>
                        <input id=txtDPT_NM  name=txtDPT_NM  size="12" class="input_ReadOnly" readonly>
                        <input id=txtTEAM_NM name=txtTEAM_NM size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id=txtJOB_NM name=txtJOB_NM size="8" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">성명</td>
                    <td class="padding2423">
                        <input id=txtENO_NM name=txtENO_NM size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>2. 직무 분류</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">직군</td>
                    <td class="padding2423">
                        <input id=txtJOBGRPH name=txtJOBGRPH size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직렬</td>
                    <td class="padding2423">
                        <input id=txtJOBRR name=txtJOBRR size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직종</td>
                    <td class="padding2423">
                        <input id=txtJOBKIND name=txtJOBKIND size="15" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직무명</td>
                    <td class="padding2423">
                        <input id=txtJOBNAME name=txtJOBNAME size="30" >
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>3. 직무 개요</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
			<textarea id="txtJOBSM" style="font-size:9pt;width:800px;height:52px;border:1 solid #708090" onBlur="bytelength(this,this.value,2000);">
			</textarea>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->
<br>





    <!-- 탭 사용 컴퍼넌트 시작 -->
    <comment id="__NSID__">
    <object id=tabvluj020 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C style="position:width:600; height:25;font-size: 12px;font-weight: bolder">
        <param name="BackColor"             		value="#F8B97B">
        <param name="DisableBackColor"  		value="#EEEEEE">
        <param name="TextColor"             		value="#000000">
        <param name="DisableTextColor"      	value="#878787">
        <param name="ActiveIndex"               value="1">
        <param  name="Format"
                value='
                    <T>divid="tabvluj010_01"    title="직무기술"</T>
                    <T>divid="tabvluj010_02"    title="직무명세"</T>
                    '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>


<!-- 내용 조회 그리드 테이블 시작-->
<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabvluj010_01" style="left:20; top:175; width:800; height:300; z-index:2;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
<br>
	<tr><td> * 본인이 수행하는 업무를 직무특성별로 분류하여 작성하시기 바랍니다 </td></tr>
	<tr><td> * 추가 버튼을 누르신 후, 비중: 가중치의 총계가 100%가 되도록, 난이도: 상/중/하, 발생빈도: 주/월/년/반기/분기중에 입력하여<br> 주시기 바랍니다 </td></tr>

	<tr>
		<td align="right">  <!-- 추가 삭제 버튼 -->
			<img src="/images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_AppendOver.gif',1)" style="cursor:hand;">
			<img src="/images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)" style="cursor:hand;">
		</td>
	</tr>
  	<tr>
  		<td>
			<table border="1"  cellpadding=0 cellspacing=0 style=width:800px;height:30px;font-size:9pt;background-color:#ffffff;>
				<tr>
					<td align="center" class="creamBold" width="30">NO</td>
					<td align="center" class="creamBold" width="80">직무</td>
					<td align="center" class="creamBold" width="120">과업</td>
					<td align="center" class="creamBold" width="360">과업 내용</td>
					<td align="center" class="creamBold" width="50">비중(%)</td>
					<td align="center" class="creamBold" width="80">난이도(상/중/하)</td>
					<td align="center" class="creamBold" width="80">발생빈도</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
	 <td >
		<iframe id="ifrm" name="ifrm" src="./vluj010_ifrm.jsp" frameborder=0 style="position:relative;top:1px;width:820;height:200px;border:1 solid #708090;"></iframe>
	 </td>
	</tr>

</table>
<!-- 내용 조회 그리드 데이블 끝-->
</div>
<!-- 탭1 조건 입력 테이블 끝 -->

<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabvluj010_02"  style="position:absolute; left:20; top:355; width:800; height:300; z-index:3; visibility:hidden">
		<tr><td height=5></td></tr>
		<tr><td> * 본 직무수행을 위한 필요한 일반적 자격요건을 명기하시기 바랍니다 (본인의 요건을 명시하는 것이 아닙니다) </td></tr>
		<br>
<!-- 조건 입력 테이블 시작 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                <colgroup>
                    <col width="70 "></col>
                    <col width="70"></col>
                    <col width="100 "></col>
                    <col width="70"></col>
                    <col width="*"></col>
                </colgroup>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table_cream">
                <tr>
                    <td align="center" class="creamBold" rowspan="2">일반자격요건</td>
                    <td align="center" class="creamBold">학력</td>
                    <td class="padding2423" >                        
                        <select id="cmbEDU" style="width:130px" >
                            <option value="1">고졸</option>
                            <option value="4">초대졸</option>
                            <option value="2">대졸</option>
                            <option value="3">대학원졸</option>                            
                        </select>
                    </td>                    
                    <td align="center" class="creamBold" width="130px">전공</td>
                    <td class="padding2423" >                        
                    	<input id=txtMAJOR name=txtMAJOR size="30" >
                    </td>                    
                </tr>
                <tr>
                    <td align="center" class="creamBold">성별</td>
                    <td class="padding2423">                        
                        <select id="cmbSEX" style="width:130px" >
                            <option value="1">남</option>
                            <option value="2">여</option>
                            <option value="3">무관</option>                                                   
                        </select>
                    </td>
                    <td align="center" class="creamBold" width="130px">기타</td>
                    <td class="padding2423">                        
                    	<input id=txtETC name=txtETC size="30" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="5">소요 역량</td>
                    <td align="center" class="creamBold">해당분야 경력</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtEXP name=txtEXP size="70" >
                    </td>                                   
                </tr>
                <tr>
                    <td align="center" class="creamBold">소요 자격/면허증</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtCERTI name=txtCERTI size="70" >
                    </td>    
                </tr>                
                <tr>
                    <td align="center" class="creamBold">외국어 능력</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtFRGRD name=txtFRGRD size="70" >
                    </td>    
                </tr>                      
                <tr>
                    <td align="center" class="creamBold">OA 능력</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtOAGRD name=txtOAGRD size="70" >
                    </td>    
                </tr>                      
                 <tr>
                    <td align="center" class="creamBold">실무지식/전문기술</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtTECH name=txtTECH size="70" >
                    </td>    
                </tr>                     
                <tr>
                    <td align="center" class="creamBold" rowspan="3">업무수행을 위한 소요교육</td>
                    <td align="center" class="creamBold">과정명</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtSTUDY name=txtSTUDY size="70" >
                    </td>                                   
                </tr>     
                 <tr>
                    <td align="center" class="creamBold">과정명</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtSTUDY2 name=txtSTUDY2 size="70" >
                    </td>   
                </tr>    
                 <tr>
                    <td align="center" class="creamBold">과정명</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtSTUDY3 name=txtSTUDY3 size="70" >
                    </td>   
                </tr>                                          
            </table>
        </td>
    </tr>
</table>
</div>
<!-- 탭2 조건 입력 테이블 끝 -->

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

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_EV_ABLRST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_JOBSPEC">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO	      	    Ctrl=txtENO_NO      	   		Param=value</C>
		<C>Col=ENO_NM			    Ctrl=txtENO_NM		   	    Param=value</C>
		<C>Col=JOBGRPH  			Ctrl=txtJOBGRPH  	   	 		Param=value</C>
		<C>Col=JOBRR    				Ctrl=txtJOBRR 	        		Param=value</C>
		<C>Col=JOBKIND		    	Ctrl=txtJOBKIND 	    		Param=value</C>
		<C>Col=JOBNAME		    	Ctrl=txtJOBNAME 	    		Param=value</C>
		<C>Col=JOBSM		    	Ctrl=txtJOBSM		    		Param=value</C>
        <C>Col=HEAD_NM    			Ctrl=txtHEAD_NM				Param=value</C>
        <C>Col=DPT_NM    			Ctrl=txtDPT_NM				Param=value</C>
        <C>Col=TEAM_NM   			Ctrl=txtTEAM_NM				Param=value</C>
        <C>Col=JOB_NM   			Ctrl=txtJOB_NM				Param=value</C>
        <C>Col=EDU					ctrl=cmbEDU         			param=value</C>
        <C>Col=MAJOR				ctrl=txtMAJOR        			param=value</C>
        <C>Col=SEX					ctrl=cmbSEX					param=value</C>
        <C>Col=ETC					ctrl=txtETC          			param=value</C>
        <C>Col=EXP					ctrl=txtEXP						param=value</C>
        <C>Col=CERTIFICATE  		ctrl=txtCERTI        			param=value</C>
        <C>Col=FRGRD					ctrl=txtFRGRD       			param=value</C>
        <C>Col=OAGRD      			ctrl=txtOAGRD       			param=value</C>
        <C>Col=TECH          		ctrl=txtTECH					param=value</C>
        <C>Col=STUDY				ctrl=txtSTUDY       			param=value</C>
        <C>Col=STUDY2				ctrl=txtSTUDY2       			param=value</C>
        <C>Col=STUDY3				ctrl=txtSTUDY3       			param=value</C>                
    '>
</object>