<!--*************************************************************************
* @source      : reta071.jsp                                                *
* @description : 분기별이자발생내역등록 PAGE                                    *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/09            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>중간정산집행현황등록(retc041)</title>
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
        //넘겨온 파마리터값들 정의
        var vPIS_YY = '<%=request.getParameter("PIS_YY") %>';
        var vBNK_CD = '<%=request.getParameter("BNK_CD") %>';
        var vBNK_NM = '<%=request.getParameter("BNK_NM") %>';
        var vROW    = '<%=request.getParameter("ROW") %>';
    
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
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.c.retc041.cmd.RETC041CMD";
        var params = null;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            params = "&S_MODE=SHR"
                   + "&PIS_YY="+vPIS_YY
                   + "&BNK_CD="+vBNK_CD;     
                   
            dsT_AC_RETINTEREST.ClearData();            
            
            dsT_AC_RETINTEREST.dataid = dataClassName+params;
            dsT_AC_RETINTEREST.reset();                         
        } 

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {
       
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            if(!fnc_SaveItemCheck()) return;
        
            params = "&S_MODE=SAV";               
        
            //ds를 저장
            trT_AC_RETINTEREST.KeyValue = "TR(I:dsT_AC_RETINTEREST=dsT_AC_RETINTEREST)";                           
            trT_AC_RETINTEREST.action = dataClassName+params;
            trT_AC_RETINTEREST.post();   
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {
            if(!confirm(
                    "보험사명:"
                    +dsT_AC_RETINTEREST.NameString(dsT_AC_RETINTEREST.RowPosition, "BNK_NM")
                    +"정산일자:"
                    +dsT_AC_RETINTEREST.NameString(dsT_AC_RETINTEREST.RowPosition, "BASIC_YMD")
                    +" 의 자료를 삭제하시겠습니까?")) {
                return;                
            }
        
            params = "&S_MODE=DEL";    
            
            dsT_AC_RETINTEREST.DeleteRow(dsT_AC_RETINTEREST.RowPosition);           
        
            //ds를 저장
            trT_AC_RETINTEREST.KeyValue = "TR(I:dsT_AC_RETINTEREST=dsT_AC_RETINTEREST)";                           
            trT_AC_RETINTEREST.action = dataClassName+params;
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
            form1.grdT_AC_RETINTEREST.GridToExcel("중간정산집행현황등록", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {
            dsT_AC_RETINTEREST.AddRow();
            
            dsT_AC_RETINTEREST.NameValue(dsT_AC_RETINTEREST.RowPosition, "PIS_YY") = vPIS_YY;
            dsT_AC_RETINTEREST.NameValue(dsT_AC_RETINTEREST.RowPosition, "BNK_CD") = vBNK_CD;
            dsT_AC_RETINTEREST.NameValue(dsT_AC_RETINTEREST.RowPosition, "BNK_NM") = vBNK_NM;
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
            
            fnc_ClearInputElement(oElementList);  
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();          
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //첫번째 인수 : 그리드명                                        
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)                
            cfStyleGrid(form1.grdT_AC_RETINTEREST,0,"false","false");      // Grid Style 적용
            
            document.getElementById("txtBNK_NM").value = vBNK_NM;
            
            //처음 로드할때 리스트 가져오기
            fnc_SearchList();
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
        var elementList = new Array ( "txtINTEREST"
                                    , "txtBASIC_YMD"
                                    , "imgAPY_YMD_SHR"
                                     );
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
    
    <Object ID="dsBNK_INFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      

    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->  

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINTEREST Event="OnLoadCompleted(iCount)">
        if (dsT_AC_RETINTEREST.CountRow == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETINTEREST.CountRow);
        }  
    </Script>
    
    <Script For=dsBNK_INFO Event="OnLoadCompleted(iCount)">
        if (dsBNK_INFO.CountRow > 0)    {
            fnc_BindingCommonCode(dsBNK_INFO, "cmbBNK_CD");
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

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_AC_RETINTEREST Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[보험사/정산일자] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            
        }
        else {
            cfErrorMsg(this);
        }

    </Script>
    

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETINTEREST event="OnSuccess()">      
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINTEREST event="OnFail()">
        alert("같은 보험사에 같은 정산일자를 등록하실 수 없습니다.");
    </script>
    
    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |
    +--------------------------->
    <script for=dsT_AC_RETINTEREST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(row > 0) {
            fnc_EnableElementAll(elementList);
        
            if(dsT_AC_RETINTEREST.RowStatus(row) != "1") {
                fnc_ChangeStateElement(false, "txtBASIC_YMD");
                fnc_ChangeStateElement(false, "imgAPY_YMD_SHR");
            }
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
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">분기별 이자발생내역</td>
                    <td align="right" class="navigator">HOME/정산세무/퇴직보험관리/<font color="#000000">분기별 이자발생내역</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>                
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->
    
    <!-- 조건 입력 테이블 시작 -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="50"></col>
                        <col width="100"></col>
                        <col width="60"></col>
                        <col width="100"></col>                                            
                        <col width="60"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center">보험사</td>
                        <td class="padding2423">
                            <input id="txtBNK_NM" name="txtBNK_NM" size="14" class="input_ReadOnly" readonly>
                        </td>
                        <td class="creamBold" align="center">발생이자</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtINTEREST" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                        </td>                                            
                        <td class="creamBold" align="center">정산일자</td>
                        <td class="padding2423">
                            <input type="text" id="txtBASIC_YMD" name="txtFROM_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtBASIC_YMD','','100','108');"></a>                        
                        </td>                                            
                    </tr>                                                                            
                </table>                             
                    
            </td>
        </tr>
    </table>
    <!-- 조건 입력 테이블 끝 -->    

    <!-- 조회 상태 테이블 시작 -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
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
	<table width="500" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_RETINTEREST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:260px;">
						<param name="DataID" value="dsT_AC_RETINTEREST">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value="
                            <C> id='{currow}'       width=50    name='NO'           align=center       SubBgColor='#99FFCC'</C>
                            <C> id=BNK_NM       width=150       align=center        name=보험사명       Suppress='2'</C>
                            <C> id=INTEREST     width=140       align=right         name=발생이자       rightmargin='10'</C>
                            <C> id=BASIC_YMD    width=140       align=center        name=정산일자       </C>
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


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

<object id="bndT_AC_RETINTEREST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETINTEREST">
    <Param Name="BindInfo", Value='
        <C>Col=BNK_CD               Ctrl=cmbBNK_CD              Param=value     </C>
        <C>Col=INTEREST             Ctrl=txtINTEREST            Param=text      </C>
        <C>Col=BASIC_YMD            Ctrl=txtBASIC_YMD           Param=value     </C>
    '>
</object>
