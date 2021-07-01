<!--*************************************************************************
* @source      : taxa050.jsp                                                *
* @description : 소득공제항목별현황 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            조정호             최초작성    
* 2007/04/28            김학수             최초작성   
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>소득공제항목별현황(taxa050)</title>
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
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
                    
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa050.cmd.TAXA050CMD";
        var params = null;
    

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;
        
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");   
            var oDED_CD     = document.getElementById("cmbDED_CD");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");
            var oORDER_TYPE = document.getElementById("cmbORDER_TYPE");
            
            
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&DED_CD="+oDED_CD.value
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&OCC_CD="+oOCC_CD.value
                   + "&DTP_CD="+oDTP_CD.value
                   + "&ORDER_TYPE="+oORDER_TYPE.value;     
            
            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();
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
      
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {
            //검색유효성 검사                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;
        
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");   
            var oDED_CD     = document.getElementById("cmbDED_CD");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");
            var oDPT_NM     = document.getElementById("txtDPT_NM_SHR");
            var oORDER_TYPE = document.getElementById("cmbORDER_TYPE");
            
            var oDED_NM     = document.form1.cmbDED_CD.options[document.form1.cmbDED_CD.selectedIndex].text;
            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&DED_CD="+oDED_CD.value
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&OCC_CD="+oOCC_CD.value
                   + "&DTP_CD="+oDTP_CD.value
                   + "&ORDER_TYPE="+oORDER_TYPE.value   
                   + "&DED_NM="+oDED_NM
                   + "&DPT_NM="+oDPT_NM.value;    

			var url = "taxa050_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("소득공제항목별현황", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

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
            
            dsT_AC_RETACC.ClearData();
            
            fnc_ClearInputFieldAll(new Array("cmbORDER_TYPE"));
            
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;      
            document.getElementById("cmbDED_CD").selectedIndex = 1; 
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated)  {
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
            
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {   
            //첫번째 인수 : 그리드명                                        
            //두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    
            //네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)                
            cfStyleGrid(form1.grdT_AC_RETACC,0,"false","false");      // Grid Style 적용
            fnc_BindingCommonCode(dsT_CM_COMMON_U5, "cmbDED_CD");
            
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;      
            document.getElementById("cmbDED_CD").selectedIndex = 1;      
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
         
        //지금 정의되어 있는 항목들
        var oElementList = new Array(    "txtPIS_YM_SHR"
                                        ,"cmbSAL_GBN_SHR"
                                        ,"cmbDED_CD"
                                        ,"cmbOCC_CD_SHR"
                                        ,"txtDPT_CD_SHR"
                                        ,"cmbORDER_TYPE");                                               

        //항목들의 메세지                                        
        var oElementMsgList = new Array( "정산년월"
                                        ,"정산구분"
                                        ,"공제항목"
                                        ,"근로구분"
                                        ,"소속"
                                        ,"출력구분");     
                                        
        //예외 항목들
        var oExceptionList = new Array(  "cmbOCC_CD_SHR"
                                        ,"txtDPT_CD_SHR");    
    
        function fnc_DEDchange(ded_nm) {
   //         alert(document.form1.cmbDED_CD.options[document.form1.cmbDED_CD.selectedIndex].text);

            
        }

                    
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>     
     
    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet                               |
    +------------------------------------------------------>    
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U5"/>
       <jsp:param name="CODE_GUBUN"    value="U5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>     
    
    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
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
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>  

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script> 

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">소득공제항목별현황</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">소득공제항목별현황</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                    <col width="90"></col>
                    <col width="150"></col>
                    <col width="60"></col>
                    <col width="180"></col>                                            
                    <col width="90"></col>
                    <col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">정산년월</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>                        
					</td>      

                    <td class="searchState" align="right">정산구분</td>
                    <td class="padding2423" align="left">
                        <select name="cmbSAL_GBN_SHR" id="cmbSAL_GBN_SHR">
                            <option value=""></option>
                            <option value="8">연말정산</option>
                            <option value="9">퇴직자정산</option>
                        </select>
                    </td>                
                    <td align="right" class="searchState">공제항목</td>
                    <td class="padding2423">
                        <select name="cmbDED_CD" id="cmbDED_CD" onChange="fnc_DEDchange(this.text)">
                            <option value=""></option>
                        </select>
                    </td>                                                          
				</tr>
                <tr>
                    <td class="searchState" align="right">직&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD_SHR" id="cmbOCC_CD_SHR">
                            <option value=""></option>
                            <option value="A">사무직</option>
                            <option value="M">택배직</option>
                        </select>
                    </td>                 
                    <td class="searchState" align="right">소&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
                        </a>
                    </td>                
                    <td align="right" class="searchState">출력구분</td>
                    <td class="padding2423">
                        <select name="cmbORDER_TYPE">
                            <option value="DPT">부서별</option>
                            <option value="ENO">사번별</option>
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
                    <object id="grdT_AC_RETACC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_AC_RETACC">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"        width=60    align=center    name="NO"         value={String(Currow)}    SubSumText=""</C>
                            <C> id=DPT_NM       width=100       align=center        name="소  속"         </C>
                            <C> id=ENO_NO       width=100       align=center        name="사  번"         </C>
                            <C> id=ENO_NM       width=100       align=center        name="성  명"         </C>
                            <C> id=JOB_NM       width=100       align=center        name="직  위"         SubSumText="합  계"</C>
                            <C> id=TDED_AMT     width=100       align=right     rightmargin=10        name="공제대상금액"   </C>
                            <C> id=DED_AMT      width=100       align=right     rightmargin=10        name="공제금액"       </C>
                            <C> id=REMARK       width=120       align=center        name="비  고"           </C>
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
