<!--*************************************************************************
* @source      : yaca022_person.jsp                                                *
* @description : 개인간 주택임차차입금 원리금 상환액 소득공제 명세서 작성 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2014/01/09           이동훈             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
     String ROLE_CD = box.getString("SESSION_ROLE_CD");
     String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");

     String PIS_YY       = request.getParameter("PIS_YY");     
     String ENO_NO       = request.getParameter("ENO_NO");
     String ENO_NM       = request.getParameter("ENO_NM");
     String DPT_NM       = request.getParameter("DPT_NM");
     String JOB_NM       = request.getParameter("JOB_NM");

     if(ENO_NO == null){
	      ENO_NO       = box.getString("SESSION_ENONO");
	      ENO_NM       = box.getString("SESSION_ENONM");
	      DPT_NM       = box.getString("SESSION_DPTNM");
	      JOB_NM       = box.getString("SESSION_JOBNM");
     }          

     //ROLE_CD가 IT인지 여부
     boolean itMaster = false;

     if(ROLE_CD.equals("1001")) {
     itMaster = true;
     }

%>


<html>
<head>
    <title>개인간 주택임차차입금 원리금 상환액 소득공제 명세서 작성(yaca022_2013년도)</title>
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
		var opener = window.dialogArguments;

        //단축키 순서
        var btnList = "T"   //조회
                    + "T"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "T"   //삭제
                    + "T";  //닫기

        var today = getToday();

        //넘어온 변수값 처리
        var TYPE = "<%=request.getParameter("TYPE") %>";
        var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
        var CET_NO = "<%=request.getParameter("CET_NO") %>";
        var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";        
        
        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
        	
			var PIS_YY   = document.form1.txtPIS_YY_SHR.value;
			var ENO_NO  = document.form1.txtENO_NO_SHR.value;			
			
			dsT_AC_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD&S_MODE=SHR_PER&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO;
			dsT_AC_PERSON.reset();
            
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

            //값 유효성 검증
            //if(!fnc_SaveItemCheck()) return;

			// save
			trT_AC_PERSON.Parameters = "PIS_YY="+PIS_YY+",ENO_NO="+ENO_NO;				
			trT_AC_PERSON.KeyValue = "tr01(I:dsT_AC_PERSON=dsT_AC_PERSON)";
			trT_AC_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD&S_MODE=SAV_PER";
			trT_AC_PERSON.post();            

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

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {

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

			document.form1.txtPIS_YY_SHR.value = '<%=PIS_YY%>';
			document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
            document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
            document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
            document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';        	
        	
			cfStyleGrid(form1.grdT_AC_PERSON, 15, "false","false");      // Grid Style 적용         

            fnc_SearchList();					
            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_AC_PERSON.Countrow < 1) {
            	
            	//dsT_AC_PERSON.setDataHeader("PIS_YY:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, HOST_NM:STRING, CET_NO:STRING, ADDRESS:STRING, AMOUNT:NUMBER, CON_YMD:STRING, DUE_YMD:STRING, HOST_NM2:STRING, CET_NO2:STRING, AMOUNT2:NUMBER,INT_AMT:NUMBER, INT_PER:STRING,CON2_YMD:STRING, DUE2_YMD:STRING");          	
                
            	dsT_AC_PERSON.AddRow();
            	
    			document.form1.medAMOUNT.text = "0";     			
    			document.form1.medAMOUNT2.text = "0";
    			document.form1.medINT_AMT.text = "0";            	
            }					
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {

        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        	
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       			|
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_PERSON)                	|
    | 3. 사용되는 Table List(T_AC_PERSON)                  			|
    +------------------------------------------------------>
    <Object ID="dsT_AC_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>



    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_PERSON)                |
    | 3. 사용되는 Table List(T_AC_PERSON)                      	|
    +------------------------------------------------------>
    <Object ID="trT_AC_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩

        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_PERSON Event="OnLoadError()">
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_PERSON event="OnSuccess()">
        alert("작업을 완료 하였습니다!");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_PERSON event="OnFail()">
        cfErrorMsg(this);
        window.close();
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
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인간 주택임차차입금</td>
                    <td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">개인간 주택임차차입금</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="620px" border="0" cellspacing="0" cellpadding="0">
		<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="40"></col>
							<col width="50"></col>
                            <col width="130"></col>
                            <col width="50"></col>
                            <col width="70"></col>
                            <col width="50"></col>
							<col width=""></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">귀속년도&nbsp;</td>
							<td class="padding2423">
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>
							</td>
                            <td align="right" class="searchState">사번&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8" class="input_ReadOnly" readonly>
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="8" maxlength= "10" class="input_ReadOnly" readonly>
                            </td>
                            <td class="searchState" align="right">소속&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="15" class="input_ReadOnly" readonly>
							</td>
                            <td class="searchState" align="right">직위&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtJOB_NM_SHR name=txtJOB_NM_SHR size="10" class="input_ReadOnly" readonly>
							</td>
						</tr>
					</table>
					</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="620px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="60"></col>                    
                        <col width="100"></col>
                        <col width="200"></col>
                        <col width="100"></col>                                                                 
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold" rowspan="3">임대차<br>계약내용</td>                    
                        <td align="center" class="creamBold">임대인성명</td>
                        <td class="padding2423">
                            <input id="txtNAM_KOR" maxlength="5" style="width:50%">
                        </td>
                        <td align="center" class="creamBold">주민등록번호</td>
                        <td class="padding2423">
                            <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onchange="changeCetTag()">
                        </td>
                      </tr>                    
                    <tr>
                        <td align="center" class="creamBold">계약상주소지</td>
						<td class="padding2423" align="left">
                            <input id="txtADDRESS" style="width:100%"">
						</td>                    
                        <td align="center" class="creamBold">전세보증금</td>
                        <td class="padding2423" >
                            <comment id="__NSID__">
                            <object id="medAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
                                <param name=Alignment               		value=2>
                                <param name=Border                  		value=true>
                                <param name=ClipMode                		value=true>
                                <param name=DisabledBackColor       	value="#EEEEEE">
                                <param name=Enable                  		value=true>
                                <param name=IsComma                 	value=true>
                                <param name=Language                	value=0>
                                <param name=MaxLength               	value=9>
                                <param name=Numeric                 		value=true>
                                <param name=NumericRange            	value=0~+:0>
                                <param name=ShowLiteral             		value=false>
                                <param name=Visible                 		value=true>
                                <param name=SelectAll               		value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                       </tr>
                       
                    <tr>
                        <td align="center" class="creamBold">계약시작일</td>
                        <td class="padding2423" >
                        <input type="text" id="txtCON_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgCON_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCON_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCON_YMD','','100','200');" style="cursor:hand;">
                        </td>
                        <td align="center" class="creamBold">계약종료일</td>
                        <td class="padding2423">
                        <input type="text" id="txtDUE_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgDUE_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDUE_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUE_YMD','','410','200');" style="cursor:hand;">
                        </td>
                    </tr>     
                    
                    
                    <tr>
                        <td align="center" class="creamBold" rowspan="3">금전<br>소비대차<br>계약내용</td>                       
                        <td align="center" class="creamBold">대주성명</td>
                        <td class="padding2423">
                            <input id="txtNAM_KOR2" maxlength="5" style="width:50%">
                        </td>
                        <td align="center" class="creamBold">주민등록번호</td>
                        <td class="padding2423">
                            <input id="txtCET_NO2" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onchange="changeCetTag()">
                        </td>
                      </tr>                    
                    <tr>
                        <td align="center" class="creamBold">원리금상환액</td>
						<td class="padding2423" align="left">
                            <comment id="__NSID__">
                            <object id="medAMOUNT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:40%" enable="false">
                                <param name=Alignment               		value=2>
                                <param name=Border                  		value=true>
                                <param name=ClipMode                		value=true>
                                <param name=DisabledBackColor       	value="#EEEEEE">
                                <param name=Enable                  		value=true>
                                <param name=IsComma                 	value=true>
                                <param name=Language                	value=0>
                                <param name=MaxLength               	value=8>
                                <param name=Numeric                 		value=true>
                                <param name=NumericRange            	value=0~+:0>
                                <param name=ShowLiteral             		value=false>
                                <param name=Visible                 		value=true>
                                <param name=SelectAll               		value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                                   &nbsp;&nbsp;이자
                            <comment id="__NSID__">
                            <object id="medINT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:35%" enable="false">
                                <param name=Alignment               		value=2>
                                <param name=Border                  		value=true>
                                <param name=ClipMode                		value=true>
                                <param name=DisabledBackColor       	value="#EEEEEE">
                                <param name=Enable                  		value=true>
                                <param name=IsComma                 	value=true>
                                <param name=Language                	value=0>
                                <param name=MaxLength               	value=8>
                                <param name=Numeric                 		value=true>
                                <param name=NumericRange            	value=0~+:0>
                                <param name=ShowLiteral             		value=false>
                                <param name=Visible                 		value=true>
                                <param name=SelectAll               		value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>                            
                            
						</td>                    
                        <td align="center" class="creamBold">이자율</td>
                        <td class="padding2423" >
                            <input id="txtINT_PER" maxlength="5" style="width:50%;ime-mode:disabled">%
                        </td>
                       </tr>
                       
                    <tr>
                        <td align="center" class="creamBold">계약시작일</td>
                        <td class="padding2423" >
                        <input type="text" id="txtCON2_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgCON_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCON2_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCON2_YMD','','100','200');" style="cursor:hand;">
                        </td>
                        <td align="center" class="creamBold">계약종료일</td>
                        <td class="padding2423">
                        <input type="text" id="txtDUE2_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgDUE_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDUE2_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUE2_YMD','','410','200');" style="cursor:hand;">
                        </td>
                    </tr>                    
                                      
                </table>
			</td>
		</tr>
	</table>

	<!-- 조건 입력 테이블 끝 -->



    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
					<comment id="__NSID__">
					<object id="grdT_AC_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:620px;height:85px;">
						<param name="DataID" 						value="dsT_AC_PERSON">
						<param name="Editable" 					value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 					value="Left">
						<param name="VIEWSUMMARY"				value=0>						
						<param name="Format" 						value='
							<C> id={currow}					width=20    name="NO"		                		align=center  	</C>
                            <C> id="HOST_NM"				width=70	name="임대인성명"		    		align=center  	</C>
							<C> id="CET_NO"					width=80	name="주민등록번호"		    		align=center 	</C>
                          	<C> id="ADDRESS"				width=200	name="임대차계약서상주소지"	   	align=left	</C>
                            <C> id="AMOUNT"				width=80	name="전세보증금"		    		align=right	  RightMargin="10"  	</C>
							<C> id="CON_YMD"				width=70	name="계약시작일"		    		align=center  </C>
                          	<C> id="DUE_YMD"				width=70	name="계약종료일"	   				align=center </C>						

                            <C> id="HOST_NM2"				width=70	name="대주성명"		    			align=center  	</C>
							<C> id="CET_NO2"				width=80	name="주민등록번호"		    		align=center 	</C>                            
                            <C> id="AMOUNT2"				width=80	name="원리금상환액"		    		align=right	  RightMargin="10"  	</C>
                            <C> id="INT_AMT"				width=70	name="이자"		    				align=right	  RightMargin="10"  	</C>
                            <C> id="INT_PER"					width=70	name="이자율"		    				align=right	  RightMargin="10"  	</C>                                                        
							<C> id="CON2_YMD"				width=70	name="계약시작일"		    		align=center 	</C>
                          	<C> id="DUE2_YMD"				width=70	name="계약종료일"	   				align=center 	</C>
                          	
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_RENT 설정 테이블 -->
	<object id="bndT_AC_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_PERSON">
		<Param Name="BindInfo", Value="
			<C>Col=HOST_NM			Ctrl=txtNAM_KOR			Param=value </C>
            <C>Col=CET_NO				Ctrl=txtCET_NO			Param=value </C>
            <C>Col=ADDRESS				Ctrl=txtADDRESS			Param=value </C>
            <C>Col=AMOUNT				Ctrl=medAMOUNT			Param=text </C>
            <C>Col=CON_YMD			Ctrl=txtCON_YMD			Param=value </C>
            <C>Col=DUE_YMD				Ctrl=txtDUE_YMD			Param=value </C>       

			<C>Col=HOST_NM2			Ctrl=txtNAM_KOR2		Param=value </C>
            <C>Col=CET_NO2				Ctrl=txtCET_NO2			Param=value </C>
            <C>Col=AMOUNT2			Ctrl=medAMOUNT2		Param=text </C>
            <C>Col=INT_AMT				Ctrl=medINT_AMT		Param=text </C>
            <C>Col=INT_PER				Ctrl=txtINT_PER			Param=value </C>
            <C>Col=CON2_YMD			Ctrl=txtCON2_YMD		Param=value </C>
            <C>Col=DUE2_YMD			Ctrl=txtDUE2_YMD		Param=value </C>                 
    
		">
	</object>