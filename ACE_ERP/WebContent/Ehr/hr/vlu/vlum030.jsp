<!--
*****************************************************
* @source       : vlum030.jsp
* @description  : 평가 결과 조회 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/11/22      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>평가결과 조회</title>
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


        var GUBUN   = "";

		var strParam = new Array();

		strParam=window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;     //해당년도
            var ENO_NO 	= document.form1.txtENO_NO_SHR.value;        //피평가자
            var EVA_SEQ = document.form1.cmbEVA_SEQ.value;        	 //차수
            
            dsT_EV_EQSCORE.ClearData();
            dsT_EV_COMMENT.ClearData();            
            dsT_EV_TOTAL.ClearData(); 
            
			// 업적 평가 의견 조회
			dsT_EV_EQSCORE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.m.vlum030.cmd.VLUM030CMD"
												     + "&S_MODE=SHR_01"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO
		     										 + "&EVA_SEQ="+EVA_SEQ;            
			dsT_EV_EQSCORE.reset();

			
			// 역량 평가 의견 조회			
			dsT_EV_COMMENT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.m.vlum030.cmd.VLUM030CMD"
												     + "&S_MODE=SHR_02"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO
		     										 + "&EVA_SEQ="+EVA_SEQ;   
											
			dsT_EV_COMMENT.reset();		
			
			// 최종 평가 결과 조회
			dsT_EV_TOTAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.m.vlum030.cmd.VLUM030CMD"
												     + "&S_MODE=SHR_03"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO;
					
			dsT_EV_TOTAL.reset();				


        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요
        	return false;
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

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {


             window.close();

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

		document.getElementById("txtREG_YM_SHR").value = '2017-11';
		document.getElementById("txtENO_NO_SHR").value = gusrid;
		document.getElementById("txtENO_NM_SHR").value = gusrnm;

		cfStyleGrid_New2(form1.grdT_EV_RQSCORE);

	    //관리자가 아니면 사번 검색은 하지 못한다.
		if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "2020008" && gusrid != "2070020"){ 

	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	            fnc_ChangeStateElement(false, "ImgEnoNo");

	    }		

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

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_RQSCORE)                       |
    | 3. 사용되는 Table List(T_EV_RQSCORE)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_EQSCORE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_COMMENT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_EV_TOTAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>    

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_RQSCORE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_RQSCORE Event="OnLoadCompleted(iCount)">
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
    <Script For=dsT_EV_RQSCORE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_RQSCORE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_RQSCORE event="OnFail()">
        if (trT_EV_RQSCORE.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="30" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)">
            <img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                                <col width="200"></col>                                
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" class="input_ReadOnly"  readOnly>
                               </td>
                                <td align="right" class="searchState">성명</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="6" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
								<td align="right" class="searchState">차수</td>
                                <td class="padding2423">
										<select id="cmbEVA_SEQ" style="width:100" onChange="fnc_SearchList();">
											<option value="1">1차</option>
											<option value="2">2차</option>										
										</select>
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



<br>
<font color="#000000">* 업무목표평가 결과</font>

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_RQSCORE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:400px;">
                                <param name="DataID"                 	value="dsT_EV_EQSCORE">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="AutoReSizing"           	value="true">
                                <param name="ColSizing"  				value="true">
                                <param name="RowHeight"   				value="10">
								<param name="TitleHeight" 				value="20">
                                <param name="Format"                 	value="
                                <C> id='SEQ2'     			width=30   	name='No'    				align=center   edit=none  </C>
                                <C> id='WORKGB'    			width=90  	name='항 목'   				align=left     wordwrap=wordex Multiline=true scroll=vert edit=none </C>
                                <C> id='WKCONT'    			width=450  	name='주 요 내 용'   		align=left     wordwrap=wordex Multiline=true scroll=both </C>
								<C> id='FEEDBACK'       	width=380   name='평가의견'  			align=center   wordwrap=wordex Multiline=true scroll=both </C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
				</table>
			</td>
		</tr>
</table>

<br>
<font color="#000000">* 역량평가 결과</font>

<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60">
                            <colgroup>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right" >평가의견&nbsp;</td>
                                <td class="padding2423" align="left" id="txtComment"  style="display:">
									<textarea id="txtComment"  cols=140  rows=3"></textarea>
                               </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<br>
<font color="#000000">* 최종평가 결과</font>

<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60">
                            <colgroup>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right" ><font color ="blue">최종평가&nbsp;</font></td>
                                <td class="padding2423" align="left" id="txtTGRADE" style="display:">&nbsp;
									<textarea id="txtTGRADE"  cols=2  rows=1 style="font-size:30pt;color:black;overflow:hidden"></textarea>
                               </td>
                            </tr>
                        </table>
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


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_EV_COMMENT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_COMMENT">
	<Param Name="BindInfo", Value='
        <C>Col=CMMENT     		Ctrl=txtComment     		Param=value 	</C>
    '>
</object>

<object id="bndT_EV_TOTAL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_TOTAL">
	<Param Name="BindInfo", Value='
        <C>Col=TGRADE     		Ctrl=txtTGRADE     		Param=value 	</C>
    '>
</object>


