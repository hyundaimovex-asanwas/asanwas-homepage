<!--*************************************************************************
* @source      : taxa280.jsp                                                *
* @description : 소득원천세지급현황 PAGE                                    *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2012/01/30            조정호             최초작성                         *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>소득원천세지급현황(taxa280)</title>
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
                    + "T"   //저장(처리)
                    + "T"   //취소
                    + "T"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD";
        var params;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YM    = document.getElementById("txtPIS_YM_SHR");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR").value.split("-");
            var SAL_GBN   = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분

            if(oPIS_YM.value == "") {
                alert("해당년월이 비어있습니다.");
                oPIS_YM.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
            	   + "&SAL_GBN="+SAL_GBN;            

            dsT_AC_ETCPAY.dataid = dataClassName+params;
            dsT_AC_ETCPAY.reset();


            
        }


        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");

            if(oPIS_YM.value == "")
                return;

            var pis_ym      = oPIS_YM.value.split("-");

            params = "&S_MODE=SHR_DPT"
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1];


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


			var PIS_YM_SHR = document.getElementById("txtPIS_YM_SHR").value; // 해당년월
            var SAL_GBN   = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분

			//해당년월이 없으면 조회 못함.
			if(PIS_YM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월을 입력하세요.");
					document.getElementById("txtPIS_YM_SHR").focus();
					return false;
				}
			}

			//해당년월이 잘못되었으면 조회못함.
			if(PIS_YM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YM_SHR").focus();
					return false;
				}
			}

            var pis_ym      = document.getElementById("txtPIS_YM_SHR").value.split("-");

            
            
			//합계
            gcds_report0.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD&S_MODE=SHR_PRINT&PIS_YY="+pis_ym[0]+"&PIS_MM="+pis_ym[1]+"&SAL_GBN="+SAL_GBN;
            gcds_report0.Reset();

			//임원(본사)
            gcds_report1.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD&S_MODE=SHR_PRINT1&PIS_YY="+pis_ym[0]+"&PIS_MM="+pis_ym[1]+"&SAL_GBN="+SAL_GBN;
            gcds_report1.Reset();

			//일반직원들
            gcds_report2.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD&S_MODE=SHR_PRINT2&PIS_YY="+pis_ym[0]+"&PIS_MM="+pis_ym[1]+"&SAL_GBN="+SAL_GBN;
            gcds_report2.Reset();

            
            
			gcrp_print.Preview();

        }


        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_ETCPAY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_ETCPAY.GridToExcel("기타소득/조정납부액관리", '', 225);
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

            dsT_AC_ETCPAY.ClearData();


            //모든 입력창들 초기화
            fnc_ClearInputElement(elementList);
            fnc_DisableElementAll(elementList);

        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_ETCPAY.IsUpdated)  {
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
            cfStyleGrid(form1.grdT_AC_ETCPAY,0,"false","true");      // Grid Style 적용

            //document.getElementById("txtPIS_YM_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            //코드 조회
            fnc_SearchItem();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_ETCPAY)                |
    | 3. 사용되는 Table List(T_AC_ETCPAY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_ETCPAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_RP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>


	<OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

	<OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</OBJECT>

	<OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<param name=SortExpr     value="+TREECD">
	  	<param name=SubsumExpr   value="1:TREECD">
		<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORT조회 DataSet-->
	</OBJECT>
    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet                               |
    +------------------------------------------------------>


    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_ETCPAY)                |
    | 3. 사용되는 Table List(T_AC_ETCPAY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_ETCPAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_ETCPAY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* 작업을 완료 하였습니다!");
        dsT_AC_ETCPAY_SAV.ClearData();
        fnc_DisableElementAll(elementList);

        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
    <script for=grdT_AC_ETCPAY event=OnDblClick(Row,Colid)>

    </script>


    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_AC_ETCPAY_SAV event=CanRowPosChange(row)>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">원천세,법인세/소득원천세지급현황</td>
                    <td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">원천세,법인세/소득원천세지급현황</font></td>
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
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
					<col width="200"></col>
					<col width="80"></col>                    
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">해당년월</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onchange="fnc_SearchItem()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
                    </td>
					<td align="center" class="searchState">구분</td>
					<td>								
						<select id="cmbSAL_GBN_SHR" style="WIDTH:70" onchange="fnc_SearchList()">
							<option value="0" >급  여</option>
                            <option value="2" >소  급</option>
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
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                        <param name="DataID" 			value="dsT_AC_ETCPAY">
                        <param name="Editable" 			value="true">
                        <param name="DragDropEnable" 	value="true">
                        <param name="SortView" 			value="Left">
						<param name="VIEWSUMMARY"		value=1>
                        <param name="Format" 			value='
                            <C> id="{CUROW}"     width=30        align=center   name="NO"      		value={String(Currow)}    SubSumText=""</C>
                            <C> id=DPT_NM        width=80        align=center   name="소속"    		SumBgColor=#C3D0DB</C>
                            <C> id=PIS_YM        width=60        align=center   name="년월"    		SumBgColor=#C3D0DB</C>
                            <C> id=JOB_NM        width=80        align=center   name="직위"    		SumBgColor=#C3D0DB</C>
                            <C> id=REG_NM        width=80        align=center   name="회계소속" 	SumBgColor=#C3D0DB</C>
                            <C> id=ENO_NO        width=60        align=center   name="사번"    		SumBgColor=#C3D0DB</C>
                            <C> id=ENO_NM        width=60        align=center   name="성명"    		SumBgColor=#C3D0DB </C>
                            <C> id=PAY_SUM       width=80        align=right    name="급여"    		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=BP35000       width=80        align=right    name="식대"    		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=BP24000       width=80        align=right    name="차량"    		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=SALT_AMT      width=80        align=right    name="계"      		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=INCM_TAX      width=80        align=right    name="갑근세"  		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=CITI_TAX      width=80        align=right    name="주민세"  		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=DDTT_AMT      width=80        align=right    name="공제합계"    	SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=PAY_AMT       width=80        align=right    name="실지급액"    	SumBgColor=#C3D0DB SumText=@sum	</C>

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


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- 급여지급현황[정기] --
------------------------------------------------------------------------------>
<OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_report0">
	<param name="DetailDataID"				value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="1">
    <PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="120">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='급여지급현황_총인원.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0'
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=458 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=895 ,top=5 ,right=1917 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>

	<L> left=353 ,top=295 ,right=2467 ,bottom=295 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=34 ,top=361 ,right=2780 ,bottom=361 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=227 ,right=2780 ,bottom=227 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=34 ,top=438 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=229 ,right=32 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=229 ,right=258 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=229 ,right=353 ,bottom=438 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1340 ,top=229 ,right=1340 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2475 ,top=229 ,right=2475 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=229 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1606 ,top=295 ,right=1606 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1872 ,top=295 ,right=1872 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=642 ,top=295 ,right=642 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=879 ,top=295 ,right=879 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2162 ,top=295 ,right=2162 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1101 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1340 ,bottom=295 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>

	<C>id='PIS_MM', left=1222, top=13, right=1311, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='COUNTR', left=274, top=372, right=350, bottom=422, align='right'</C>
	<C>id='PIS_YY', left=964, top=13, right=1135, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='PAY_AMT', left=2488, top=372, right=2772, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_YY', left=45, top=372, right=140, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_MM', left=153, top=372, right=203, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TODATEE', left=2580, top=132, right=2783, bottom=179, align='right' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DDTT_AMT', left=2167, top=377, right=2467, bottom=427, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CITI_TAX', left=1611, top=377, right=1867, bottom=427, align='right'</C>
	<C>id='INCM_TAX', left=1348, top=377, right=1601, bottom=427, align='right'</C>
	<C>id='SALT_AMT', left=1106, top=377, right=1327, bottom=427, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP24000', left=887, top=377, right=1093, bottom=427, align='right'</C>
	<C>id='BP35000', left=648, top=377, right=877, bottom=427, align='right'</C>
	<C>id='PAY_SUM', left=361, top=377, right=637, bottom=427, align='right'</C>

	<T>id='계' ,left=2164 ,top=301 ,right=2464 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1875 ,top=301 ,right=2151 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1609 ,top=301 ,right=1864 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1348 ,top=301 ,right=1601 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1103 ,top=301 ,right=1332 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=885 ,top=301 ,right=1090 ,bottom=351 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=645 ,top=301 ,right=874 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여' ,left=358 ,top=301 ,right=635 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=45 ,top=240 ,right=245 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=200 ,top=372 ,right=245 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='.' ,left=137 ,top=372 ,right=163 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Print Date:' ,left=2314 ,top=132 ,right=2578 ,bottom=179 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1   총인원' ,left=32 ,top=179 ,right=242 ,bottom=221 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=361 ,top=240 ,right=1327 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1348 ,top=240 ,right=2467 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='단위 : 원' ,left=2580 ,top=179 ,right=2783 ,bottom=221 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=271 ,top=240 ,right=348 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2488 ,top=240 ,right=2772 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=1311 ,top=13 ,right=1385 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='급여 지급 현황' ,left=1416 ,top=13 ,right=1869 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='년' ,left=1137 ,top=13 ,right=1219 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=133
<R>id='급여지급현황_본사근무자.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_report1'
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=287 ,face='Arial' ,size=10 ,penwidth=1

	<L> left=874 ,top=129 ,right=874 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=637 ,top=129 ,right=637 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1867 ,top=129 ,right=1867 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=129 ,right=1601 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2156 ,top=129 ,right=2156 ,bottom=274 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2775 ,top=63 ,right=2775 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2470 ,top=63 ,right=2470 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1335 ,top=63 ,right=1335 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=348 ,top=63 ,right=348 ,bottom=272 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=253 ,top=63 ,right=253 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=63 ,right=26 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=195 ,right=2775 ,bottom=195 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=61 ,right=2775 ,bottom=61 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=277 ,right=2775 ,bottom=277 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=129 ,right=2470 ,bottom=129 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1087 ,top=129 ,right=1087 ,bottom=274 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1087 ,top=129 ,right=1335 ,bottom=129 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=350 ,top=127 ,right=2464 ,bottom=127 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>

	<C>id='DDTT_AMT', left=2162, top=206, right=2462, bottom=256, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CITI_TAX', left=1606, top=206, right=1861, bottom=256, align='right'</C>
	<C>id='INCM_TAX', left=1343, top=206, right=1595, bottom=256, align='right'</C>
	<C>id='BP24000', left=882, top=206, right=1087, bottom=256, align='right'</C>
	<C>id='BP35000', left=642, top=206, right=871, bottom=256, align='right'</C>
	<C>id='PAY_SUM', left=355, top=206, right=632, bottom=256, align='right'</C>
	<C>id='COUNTR', left=269, top=206, right=345, bottom=256, align='right'</C>
	<C>id='PAY_AMT', left=2483, top=206, right=2767, bottom=256, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_YY', left=39, top=206, right=134, bottom=256, align='right', face='굴림', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_MM', left=147, top=206, right=197, bottom=256, align='right', face='굴림', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SALT_AMT', left=1095, top=206, right=1330, bottom=256, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>

	<T>id='2  임원(본사)' ,left=26 ,top=13 ,right=313 ,bottom=55 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2483 ,top=74 ,right=2767 ,bottom=182 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=266 ,top=74 ,right=342 ,bottom=182 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1343 ,top=74 ,right=2462 ,bottom=124 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=355 ,top=74 ,right=1322 ,bottom=124 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='.' ,left=132 ,top=206 ,right=158 ,bottom=256 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=195 ,top=206 ,right=240 ,bottom=256 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=39 ,top=74 ,right=240 ,bottom=182 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=640 ,top=137 ,right=869 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=879 ,top=137 ,right=1085 ,bottom=187 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여' ,left=353 ,top=137 ,right=629 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1343 ,top=137 ,right=1595 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1606 ,top=137 ,right=1861 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1872 ,top=137 ,right=2148 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2162 ,top=137 ,right=2462 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1095 ,top=137 ,right=1330 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
<R>id='급여지급현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_report2'
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=316 ,face='Arial' ,size=10 ,penwidth=1

	<L> left=32 ,top=95 ,right=2780 ,bottom=95 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=224 ,right=2780 ,bottom=224 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=158 ,right=2472 ,bottom=158 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1090 ,top=158 ,right=1340 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2151 ,top=158 ,right=2472 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=32 ,top=298 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1340 ,top=98 ,right=1340 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=98 ,right=258 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=98 ,right=353 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=635 ,top=156 ,right=635 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1869 ,top=156 ,right=1869 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=156 ,right=1601 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=882 ,top=156 ,right=882 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1093 ,top=156 ,right=1093 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2475 ,top=98 ,right=2475 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=98 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=156 ,right=2154 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=32 ,top=98 ,right=32 ,bottom=295 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>

	<C>id='DPT_NM', left=92, top=40, right=606, bottom=84, align='left', face='굴림', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_MM', left=153, top=237, right=203, bottom=285, align='right', face='굴림', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_YY', left=45, top=237, right=140, bottom=285, align='right', face='굴림', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COUNTR', left=271, top=237, right=348, bottom=285, align='right'</C>
	<C>id='PAY_AMT', left=2488, top=237, right=2772, bottom=285, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{currow+2}', left=32, top=40, right=87, bottom=84, align='left', face='굴림', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_SUM', left=361, top=237, right=629, bottom=285, align='right'</C>
	<C>id='DDTT_AMT', left=2162, top=237, right=2467, bottom=285, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP35000', left=640, top=237, right=877, bottom=285, align='right'</C>
	<C>id='BP24000', left=887, top=237, right=1090, bottom=285, align='right'</C>
	<C>id='SALT_AMT', left=1101, top=237, right=1332, bottom=285, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INCM_TAX', left=1348, top=237, right=1598, bottom=285, align='right'</C>
	<C>id='CITI_TAX', left=1603, top=237, right=1864, bottom=285, align='right'</C>

	<T>id='구  분' ,left=45 ,top=105 ,right=245 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=200 ,top=237 ,right=245 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='.' ,left=137 ,top=237 ,right=163 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=271 ,top=105 ,right=348 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1348 ,top=105 ,right=2467 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2488 ,top=105 ,right=2772 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=361 ,top=105 ,right=1327 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여' ,left=361 ,top=166 ,right=629 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=640 ,top=166 ,right=877 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=887 ,top=166 ,right=1090 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1101 ,top=166 ,right=1332 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1348 ,top=166 ,right=1598 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1603 ,top=166 ,right=1864 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1872 ,top=166 ,right=2148 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2162 ,top=166 ,right=2467 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

</B>
</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../images/common/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT>

</body>
</html>

