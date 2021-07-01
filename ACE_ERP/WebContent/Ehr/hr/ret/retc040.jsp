<!--*************************************************************************
* @source      : retc040.jsp                                                *
* @description : 퇴직보험사별원장 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/08            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>퇴직보험사별원장(retc040)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
                    
        var today = getToday(); 
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.c.retc040.cmd.RETC040CMD";
        var params = null;
        
        //STR - 시작
        //INS - 입력
        //UPT - 수정
        var p_mode = null;        

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YY = document.getElementById("txtPIS_YY_SHR");   
            var oBNK_CD = document.getElementById("cmbBNK_CD_SHR");   
            
            if(oPIS_YY.value == "") {
                alert("검색년도가 비어 있습니다.");
                return;
            }
            
            params = "&S_MODE=SHR"
                   + "&PIS_YY="+oPIS_YY.value
                   + "&BNK_CD="+oBNK_CD.value
                   ;            
            
            trT_AC_RETINTEREST_SHR.KeyValue = "tr(O:dsT_AC_RETINTEREST=dsT_AC_RETINTEREST)";
            trT_AC_RETINTEREST_SHR.action = dataClassName+params;
            trT_AC_RETINTEREST_SHR.post();            
        }   

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {
            dsT_CM_COMMON_BK.DataID = dataClassName+"&S_MODE=ITM_SHR";
            dsT_CM_COMMON_BK.Reset();       
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            if(!fnc_SaveItemCheck()) return;

            trT_AC_RETINTEREST.KeyValue = "tr(I:dsT_AC_RETINTEREST=dsT_AC_RETINTEREST)";
            trT_AC_RETINTEREST.action = dataClassName+"&S_MODE=SAV";
            trT_AC_RETINTEREST.post();

            fnc_SearchList();   
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_AC_RETINTEREST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_AC_RETINTEREST.ColumnString(dsT_AC_RETINTEREST.RowPosition,5) + "]의 자료를 제거하시겠습니까?") == false) return;
            dsT_AC_RETINTEREST.DeleteRow(dsT_AC_RETINTEREST.RowPosition);

            trT_AC_RETINTEREST.KeyValue = "SVL(I:dsT_AC_RETINTEREST=dsT_AC_RETINTEREST)";
            trT_AC_RETINTEREST.Action = dataClassName+"&S_MODE=DEL";
            trT_AC_RETINTEREST.post();       
        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETINTEREST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETINTEREST.GridToExcel("퇴직보험사별원장", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {
            // 해당 Dataset의 Header가 없으면 검색이 되지 않았다는 것으로 간주하고 종료
            if (dsT_AC_RETINTEREST.CountColumn == 0) {
                alert("퇴직보험사별원장을 조회하지 않았습니다.");
                return;
            }        

            dsT_AC_RETINTEREST.AddRow();
            
            var oPIS_YY = document.getElementById("txtPIS_YY_SHR");   
            
            document.getElementById("txtPIS_YY").value    = oPIS_YY.value;
            
            
            p_mode = "INS";  
        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {
           
        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {
          
        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_AC_RETINTEREST.ClearData();
            
            document.getElementById("cmbBNK_CD_SHR").selectedIndex = 0;
            
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETINTEREST.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();           
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            if (!dsT_AC_RETINTEREST.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {            
            //보험회사명 가져오기
            fnc_SearchItem();
            
            var oSelect = null;
            var oOption = null;
        
            // 근로구분 구분 검색 콤보박스 생성
            fnc_BindingCommonCode(dsT_CM_COMMON_BK, "cmbBNK_CD_SHR");
        
            //첫번째 인수 : 그리드명                                        
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)                
            cfStyleGrid(form1.grdT_AC_RETINTEREST,0,"false","false");      // Grid Style 적용
            
            //년도 분기 미리 선택
            var oPIS_YY = document.getElementById("txtPIS_YY_SHR").value = getToday().substr(0,4);   
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {
           
        }
        
        /********************************************
         * 기타 함수              *
         ********************************************/

                         
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETINTEREST)                |
    | 3. 사용되는 Table List(T_AC_RETINTEREST)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETINTEREST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      
    
    <Object ID="dsT_CM_COMMON_BK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      
    
    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETINTEREST)                |
    | 3. 사용되는 Table List(T_AC_RETINTEREST)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETINTEREST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>       
    <Object ID="trT_AC_RETINTEREST_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>       


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->  

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINTEREST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINTEREST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINTEREST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>  

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETINTEREST event="OnSuccess()">        
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINTEREST event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    <!-- 데이타 그리드를 더블 클릭할때 -->
    <script for=grdT_AC_RETINTEREST event=OnDblClick(Row,Colid)>
        if(Row < 1) {
            return;
        } else {
            var href_page = "/hr/ret/retc041.jsp"
                          + "?PIS_YY="+dsT_AC_RETINTEREST.NameValue(Row, "PIS_YY")
                          + "&BNK_CD="+dsT_AC_RETINTEREST.NameValue(Row, "BNK_CD")
                          + "&BNK_NM="+dsT_AC_RETINTEREST.NameValue(Row, "BNK_NM")
                          + "&ROW="+Row;                  

            window.showModalDialog(href_page, "", "dialogWidth:540px; dialogHeight:470px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList();
        }
    </script>   

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- 캘린더 프레임-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">퇴직보험사별원장</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직보험관리/<font color="#000000">퇴직보험사별원장</font></td>
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
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="80"></col>
					<col width="80"></col>
					<col width="90"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td class="searchState" align="right">기준연도</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="cfDateHyphen(this); if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY_SHR','','100','108');"></a>                        
                    </td>                
                    <td class="searchState" align="right">보험회사구분</td>
                    <td class="padding2423" align="left">
                        <select id="cmbBNK_CD_SHR" name="cmbBNK_CD_SHR">
                            <option value="">선택하세요</option>
                        </select>
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
    					<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->


    <!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_RETINTEREST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_AC_RETINTEREST">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
                            <C> id="{CUROW}"    width=60    align=center    name="NO"         value={String(Currow)}</C>
                            <C> id=BNK_NM       width=160   align=center    name=보험회사명     Suppress=1</C>
                            <C> id=PIS_QQ       width=80    align=center    name=분기          </C>
                            <C> id=RES_AMT      width=120   align=right     name=충당금         rightmargin=10</C>
                            <C> id=INTEREST     width=120   align=right     name=발생이자           rightmargin=10</C>                            
                            <C> id=PAID_AMT     width=120   align=right     name=중도지급액      rightmargin=10</C>
                            <C> id=BAL_AMT      width=120   align=right     name=차액             rightmargin=10 </C>
						'>
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


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

