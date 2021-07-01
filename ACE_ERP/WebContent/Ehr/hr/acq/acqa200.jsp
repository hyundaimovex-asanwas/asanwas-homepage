<!--*************************************************************************
* @source      : acqa100.jsp												*
* @description : Action Plan > 사용 기록 > 얼마나 잘 쓰는지 두고보자!!!! 	*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2019/03/13            이동훈       번갯불에 콩을 구워먹어도 유분수지		*
**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>사용 기록</title>
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

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
        	
            trT_ACT_ACCESS.KeyValue = "tr(O:dsT_ACT_ACCESS=dsT_ACT_ACCESS)";
            trT_ACT_ACCESS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa200.cmd.ACQA200CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd;
            trT_ACT_ACCESS.post();               

        }


        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {


        }


        /***********************************
         * 			03. 저장 함수  			*
         ***********************************/
        function fnc_Save() {


        }


        
        /***********************************
         * 			04. 삭제 함수  			*
         ***********************************/
        function fnc_Delete() {

			//이곳에 해당 코딩을 입력 하세요

        }

        
        
        /***********************************
         * 			05. 인쇄 함수  			*
         ***********************************/
        function fnc_Print() {


        }

        
        
        /***********************************
         * 			06. 엑셀 저장 함수  	*
         ***********************************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }


        /***********************************
         * 			07. 신규 함수  			*
         ***********************************/
        function fnc_AddNew() {

			

        }

        
        /***********************************
         * 			08. 추가 함수 		 	*
         ***********************************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요
			
        }

        /***********************************
         * 			09. 제거 함수  			*
         ***********************************/
        function fnc_Remove() {

			
        }

        /***********************************
         * 			10. 초기화 함수  		*
         ***********************************/
        function fnc_Clear() {


        }

        /***********************************
         * 			11. 화면 종료(닫기) 	*
         ***********************************/
        function fnc_Exit() {


        }


        /***********************************
         * 		12. 검색 조건 유효성 검사  *
         ***********************************/
        function fnc_SearchItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        
        /***********************************
         * 		13. 저장 유효성 체크  		*
         ***********************************/
        function fnc_SaveItemCheck() {


        }

        

        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtSTR_YMD_SHR").value = addDate("M", today, -1);
            document.getElementById("txtEND_YMD_SHR").value = addDate("M", today, +1);        	
        	
			cfStyleGrid_New(form1.grdT_ACT_ACCESS,0,"false","true");      // Grid Style 적용		
			
			fnc_SearchList();
			

        }


    </script>

    </head>




    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <Object ID="dsT_ACT_ACCESS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_ACT_ACCESS)	    |
    | 3. 사용되는 Table List(T_ACT_PLAN)	                |
    +------------------------------------------------------->
    <Object ID ="trT_ACT_ACCESS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-----------------------------------------------------+
    | 			Transaction Successful 처리  			   |
    +------------------------------------------------------>
    
    <script for=trT_ACT_ACCESS event="OnSuccess()">

    </script>    
    
  
    <!-----------------------------------------------------+
    | 			Transaction Failure 처리  			   	   |
    +------------------------------------------------------>
    <script for=trT_ACT_ACCESS event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s22.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5" align="right" >
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageSearch','','../../images/button/btn_SearchOver.gif',1)">
				<img src="../../images/button/btn_SearchOn.gif" name="ImageSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()">
			</a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="50"></col>			
				<col width="*"></col>
			</colgroup>
			<tr>
					<td class="searchState" align="center">기간&nbsp;</td>
					<td>
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
					    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
					</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>

				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 문서 현황 정보 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<comment id="__NSID__">
			<object	id="grdT_ACT_ACCESS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:600px;">
				<param name="DataID"				value="dsT_ACT_ACCESS">
				<param name="Editable"              value="false">
				<param name="SortView" 				value="Left">				
				<param name="Format"				value="
					<C> Name='No'		  		ID={currow} 	  		Width=50 	align=center	</C>
					<C> Name='플랫폼'       	ID=ACCESS_GB	        Width=60 	align=center   sort=true</C>					
					<C> Name='프로그램'       	ID=PROG_ID	          	Width=100 	align=center   sort=true</C>                    
					<C> Name='소속'  	    	ID=DPT_NM          		Width=100 	align=center   sort=true </C>
					<C> Name='직위'  	        ID=JOB_NM          		Width=80 	align=center   sort=true </C>					
					<C> Name='성명'  	        ID=ACCESS_NM          	Width=60 	align=center   sort=true </C>
					<C> Name='접속일시'  	    ID=ACCESS_TIME         	Width=120 	align=center   sort=true </C>
					<C> Name='IP'	      		ID=IPADDRESS 	        Width=100 	align=center   sort=true </C>
					<C> Name='수행\\업무'       ID=ACT_GBN	          	Width=80 	align=center   sort=true value={decode(ACT_GBN, 'S','조회','D','다운로드')}</C> 
					<C> Name='FILE명'	      	ID=FILE_NM 	        	Width=220 	align=left     sort=true </C>					
				">
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
    </tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




