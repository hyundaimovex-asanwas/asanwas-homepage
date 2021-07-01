<!--
***********************************************************************
* @source      : eist030.jsp
* @description : 프로젝트 관리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/01/12            이동훈            	ERP이사						
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>프로젝트 관리</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        var today = gcurdate;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {


			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");

			
			dsT_TS_PROJECT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist030.cmd.EIST030CMD&S_MODE=SHR&PIS_YM="+pis_ym;

    		dsT_TS_PROJECT.reset();

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

			if(!fnc_SaveItemCheck()) return;	//유효성 체크

			//var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
			//var eno_no = document.getElementById('txtENO_NO_SHR').value;			
			
			trT_TS_PROJECT.KeyValue = "tr01(I:dsT_TS_PROJECT=dsT_TS_PROJECT)";

			trT_TS_PROJECT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist030.cmd.EIST030CMD&S_MODE=SAV";
																					            //+ "&PIS_YM="+pis_ym
																					            //+ "&ENO_NO="+eno_no;						

			//prompt(this, trT_TS_PROJECT.action);
			
			trT_TS_PROJECT.post();

			fnc_SearchList();        	
        	
        	
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


        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

            dsT_TS_PROJECT.AddRow();

/*			
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "PJT_CD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "PJT_NM") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "DPT_CD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "SEQ") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "FROM_YMD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "TO_YMD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "USEYN") = 1;
*/

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



        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {


        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        	
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	return true;
        	
        	
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);
        
            //품의번호 조회
            dsT_CM_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist030.cmd.EIST030CMD&S_MODE=SHR_TEAM&ENO_NO="+gusrid;
            dsT_CM_TEAM.reset();
			
            document.getElementById('txtDPT_CD_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_CD");
            document.getElementById('txtDPT_NM_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_NM");  
            
    		//관리자가 아니면 사번 검색은 하지 못한다.
			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6050006" || gusrid == "2020009"){ 
            
	            document.getElementById('txtDPT_CD_SHR').value = "";
	            document.getElementById('txtDPT_NM_SHR').value = "";
	            
			}else{
				
	            document.getElementById('txtDPT_CD_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_CD");
	            document.getElementById('txtDPT_NM_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_NM");  			
							
			}

			cfStyleGrid_New(form1.grdT_TS_PROJECT,15,"true","true");      // Grid Style 적용
			
			fnc_SearchList();
            
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

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_TS_PROJECT)   |
    | 3. 사용되는 Table List()		     |
    +------------------------------------------------>
    <Object ID="dsT_TS_PROJECT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_TS_PROJECT)	    |
    | 3. 사용되는 Table List()	            |
    +--------------------------------------------------->
    <Object ID ="trT_TS_PROJECT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_TS_PROJECT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_TS_PROJECT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_TS_PROJECT Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_TS_PROJECT event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_TS_PROJECT event="OnFail()">
        cfErrorMsg(this);
    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)"><img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="ImgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>

		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="60"></col>
									<col width="100"></col>
									<col width="60"></col>
									<col width="*"></col>									
								</colgroup>
							<tr>
								<td align="right" class="searchState">년 월&nbsp;</td>
								<td class="padding2423">
                                     <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								</td>	
								
								<td align="right" class="searchState">팀&nbsp;</td>
								<td class="padding2423">								
					                <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="9"  maxlength= "8"   style="ime-mode:disabled"   >
					                <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" maxlength= "14"  >
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

<BR>

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_PROJECT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_PROJECT">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>
								<C> id='DPT_NM'	    	width=160	name='팀명'	        	align=center suppress=1</C>
								<C> id='PJT_CD'	    	width=140	name='프로젝트코드'	    align=center show=false</C>								

								<C> id='PJT_NM'	    	width=300	name='프로젝트명'	        align=left </C>

								<C> id='FROM_YMD'	    width=160	name='시작일자'	        align=center mask='XXXX-XX-XX'</C>								
								<C> id='TO_YMD'	    	width=160	name='종료일자'	        align=center mask='XXXX-XX-XX'</C>	
								<C> id='USEYN'	    	width=100	name='사용여부'	        align=center EditStyle=Combo Data='Y:사용,N:미사용' AlwaysShowEditStyle=false </C>
									
																
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




