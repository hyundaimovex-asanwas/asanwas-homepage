<!--
*****************************************************
* @source      : idtc070.jsp
* @description : 주간업무확인 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/11/30      이동훈        최초작성
*-------------+-----------+--------------------------+
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>주간업무확인</title>
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
        var eno_no = '';
        var eno_nm = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
        	

            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var PIS_YMD  = document.getElementById("txtPIS_YMD").value;


            dsT_WF_WORKFORM.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc070.cmd.IDTC070CMD"
										                                + "&S_MODE=SHR"
										                                + "&ENO_NO="+ENO_NO								                                
										                                + "&PIS_YMD="+PIS_YMD.replace("-","").replace("-","");
            //prompt(this, dsT_WF_WORKFORM.DataId);
            
            dsT_WF_WORKFORM.Reset();


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

            if(fnc_SaveItemCheck()) {


            	var WEEK_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"WEEK_NO"); 
            	var ENO_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"ENO_NO"); 
    			
                trT_WF_WORKFORM.KeyValue = "tr01(I:dsT_WF_WORKFORM2=dsT_WF_WORKFORM2)";
                
                trT_WF_WORKFORM.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc070.cmd.IDTC070CMD"
    																					            + "&S_MODE=SAV"
    																					            + "&WEEK_NO="+WEEK_NO
    																								+ "&ENO_NO="+ENO_NO;            
                //prompt(this, dsT_WF_WORKFORM.text);
                
                trT_WF_WORKFORM.post();                
                
                
                
            }

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

            //DataSet의 변경 여부 확인
            if (!dsT_WF_WORKFORM2.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            return true;

        }

        
        
        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_WF_WORKFORM,0,"false","true");
            cfStyleGrid_New(form1.grdT_WF_WORKFORM2,0,"true","false");


            document.getElementById("txtPIS_YMD").value = today;
            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;

    		//관리자의 경우 년도, 사번 검색 활성화
	    	if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "2180005" && gusrid != "2070016" && gusrid != "1990071"){             
            
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	            fnc_ChangeStateElement(false, "ImgEnoNoShr");

	    	}else{
	    		
	            document.getElementById("txtENO_NO_SHR").value = "";
	            document.getElementById("txtENO_NM_SHR").value = "";		
	    		
	    	}

       		fnc_SearchList();
       		
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {



        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

        	
        	
        }


        
       
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                       *
    *                                                                                        *
    ***************************************************************************************-->


    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTO)|
    | 3. 사용되는 Table List(T_CD_MENTO)       |
    +----------------------------------------------->
    <Object ID="dsT_WF_WORKFORM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_WF_WORKFORM2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_WF_WORKFORM                        |
    | 3. Table List : T_CD_MENTO                    |
    +----------------------------------------------->
    <Object ID ="trT_WF_WORKFORM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:dsT_WF_WORKFORM=dsT_WF_WORKFORM)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_WF_WORKFORM Event="OnClick(row, col)">
    
    
    
	var WEEK_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"WEEK_NO"); 
	var ENO_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"ENO_NO"); 
    
    dsT_WF_WORKFORM2.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc020.cmd.IDTC020CMD"
																		        + "&S_MODE=SHR"
																		        + "&WEEK_NO="+WEEK_NO
																				+ "&ENO_NO="+ENO_NO;

    //prompt(this, dsT_WF_WORKFORM2.DataId);
    
	dsT_WF_WORKFORM2.Reset();	
    
	form1.grdT_WF_WORKFORM2.RowHeight = 97;          // Grid Row Height Setting
	form1.grdT_WF_WORKFORM2.TitleHeight = "30";


    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WF_WORKFORM Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_WF_WORKFORM.CountRow);

        }

        document.getElementById("txtENO_NO").disabled  = true;
        document.getElementById("txtENO_NM").disabled  = true;
        document.getElementById("ImgEnoNo").disabled   = true;

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WF_WORKFORM event="OnSuccess()">

    	alert("정상적으로 처리되었습니다.");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WF_WORKFORM event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
								<col width="80"></col>
								<col width="100"></col>
								<col width="80"></col>
								<col width="120"></col>
								<col width="120"></col>
								<col width="150"></col>
								<col width="80"></col>	
								<col width="*"></col>
							</colgroup>

                            <tr>
                            
                                <td align="right" class="searchState">일자&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YMD" style="ime-mode:disabled" size="10" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgYmd','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgStrYmd1" name="ImgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD','','20','120');"></a>
                                </td>                            
                            
                                <td align="right" class="searchState" width="40">확인자</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="7" maxlength= "7"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="left" width="800">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_WF_WORKFORM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:150px;">
                            <param name="DataID"                  value="dsT_WF_WORKFORM">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
	                                <C> id='WORK_WEEK'     		width=200   name='주차'         	align=center edit='none'</C>
	                                <C> id='DPT_NM'     		width=250   name='소속'          align=center edit='none' </C>
	                                <C> id='JOB_NM'     		width=250   name='직위'         	align=center edit='none'</C>
	                                <C> id='ENO_NM'     		width=250   name='성명'         	align=center edit='none'</C>                        
	                                
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->


<BR>

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="left" width="800">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_WF_WORKFORM2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:425px;">
                            <param name="DataID"                  value="dsT_WF_WORKFORM2">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
							<param name="Format"				value="
								<C> id='CET_NO'				width=85   	name='NO'			align=center 	suppress=1 edit=none</C>
								<C> id='PLAN_EXE'			width=30    name='구분'			align=center 	Value={Decode(PLAN_EXE,'PLAN','계획','EXE','결과')} </C>
								<C> id='WORK_DETAIL1'		width=200	name='수주영업'		align=left		wordwrap=word 		Multiline=true </C>
								<C> id='WORK_DETAIL2'		width=200	name='실행/정산'		align=left		wordwrap=word 		Multiline=true </C>
								<C> id='WORK_DETAIL3'		width=200	name='기타'			align=left		wordwrap=word 		Multiline=true </C>
								<C> id='FEED_BACK'			width=280	name='의견'			align=left		wordwrap=word 		Multiline=true edit=true </C>
								<C> id='STAT'				width=40	name='상태'			align=left		show = false 		BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>							
							">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->


</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 내용보기 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_WF_WORKFORM">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        		Ctrl=txtENO_NO        		Param=value </C>
        <C> Col=ENO_NM        		Ctrl=txtENO_NM        		Param=value </C>
        <C> Col=WORK_WEEK        	Ctrl=txtWORK_WEEK       	Param=value </C>


    '>
</object>


