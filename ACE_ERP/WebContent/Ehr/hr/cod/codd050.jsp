<!--
*****************************************************
* @source       : codd050.jsp
* @description : 통합 메세지 현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/02/18            이동훈            	최초작성									
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>
<%@ page import="sales.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>


<html>
<head>
<title>받은 메세지 현황</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>



<%	
		// ContextPath 변수 설정.
		SmartRequest sr = new SmartRequest(request);
		String dirPath  = request.getContextPath(); //HDASan
		
		String ssID = session.getId().substring(0,40);
		try {
		
		//String ssID	= sr.getString("ssID");

%>




    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO_SHR  = gusrid;//사번

            dsT_AA_MESSAGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.d.codd050.cmd.CODD050CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_AA_MESSAGE.reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

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

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {


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

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

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


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

        	// Grid Style 적용
            cfStyleGrid_New(form1.grdT_AA_MESSAGE,0,"false","false")      

          	//자동조회
            fnc_SearchList();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        
        
		/********************************************
         * 16. 확인 처리    						*
         ********************************************/
        function fnc_Confirm() {

            if (confirm("모든 메세지를 확인처리 하시겠습니까?\n\n확인 처리시 더 이상 조회되지 않습니다.") == false) return;
			

		    for(var i=1; i<=dsT_AA_MESSAGE.CountRow; i++) {				    
		    	dsT_AA_MESSAGE.UserStatus(i) = 1;
		    }	            
            
            trT_AA_MESSAGE.KeyValue = "tr01(I:dsT_AA_MESSAGE=dsT_AA_MESSAGE)";
            trT_AA_MESSAGE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.d.codd050.cmd.CODD050CMD&S_MODE=SAV&ENO_NO="+gusrid;
            trT_AA_MESSAGE.post();
            
        }
        
        
    </script>

    </head>



    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->


    <!----------------------------------------------+
    | 1. 조회용 DataSet                            |
    | 2. 이름 : dsT_AA_MESSAGE                     |
    | 3. Table List : T_AA_MESSAGE                 |
    +----------------------------------------------->
    <Object ID="dsT_AA_MESSAGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)           |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>

    <Object ID="trT_AA_MESSAGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_AA_MESSAGE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            //alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>



    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_AA_MESSAGE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>



    <!-----------------------------------------------------+
    | Transaction Successful 처리                          |
    +------------------------------------------------------>
    <script for=trT_AA_MESSAGE event="OnSuccess()">
    
        alert("정상적으로 모두 확인 처리 되었습니다.");


        
    	//window.opener.location.href = window.opener.location.href;  
		<%
		System.out.println("ssID -->" + ssID);
		%>
		
        window.close();	
		
        
        opener.document.FormPortal.submit();
        
        //opener.document.location.reload();
        
		//window.parent.location.href = "<%=dirPath%>/portal.jsp?ssID="+<%=ssID%>;

		//opener.document.location.reload();

		//session.getId().substring(0,40)
		
    	//window.close();
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- form 시작 -->
<form name="form1">


<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="center" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    
					<td height="30" class="paddingTop5" align="right">
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','../../images/button/btn_ConfirmOver.gif',1)">  
			            <img src="../../images/button/btn_ConfirmOn.gif"     name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm();">
			            </a>
					</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->


<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td style="padding-top:2px;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_AA_MESSAGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:600px;">
                            <param name="DataID"                value="dsT_AA_MESSAGE">
                            <param name="Format"                value="
                                <FC> id='{CUROW}'    		width=50    name='NO'           	align=center    value={String(Currow)}</C>
                                <FC> id='MSG_TYPE' 			width=120   name='메세지구분'     	align=center </FC>
                                <FC> id='MSG_CONTENT'  		width=550   name='제목'         	align=left   </FC>
                                <FC> id='IPT_YMD'    		width=150   name='전송일자'     	align=center </FC>
                                <FC> id='STATUS'    		width=110   name='상태값'     		align=center </FC>                                
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


<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>
