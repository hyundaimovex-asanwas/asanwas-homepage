<!--
***********************************************************************
* @source      : sage010.jsp
* @description : 식대 계산용 근태정보 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/03/14      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>근태정보</title>
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



        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var eno_no = document.getElementById('txtENO_NO_SHR').value;
            //var eno_nm = document.getElementById('txtENO_NM_SHR').value;
            var pis_ym = document.getElementById('txtPIS_YYMM_SHR').value;
			var site_cd = document.getElementById("txtSITE_CD_SHR").value;		// 소속

			dsT_SI_DILIGENCE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage010.cmd.SAGE010CMD&S_MODE=SHR&&PIS_YM="+pis_ym+"&SITE_CD="+site_cd+"&ENO_NO="+eno_no;
    		dsT_SI_DILIGENCE.reset();


			//trT_SI_DILIGENCE.KeyValue = "tr01(O:dsT_DI_YEARLY=dsT_DI_YEARLY)";
			//trT_SI_DILIGENCE.action ="../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage010.cmd.SAGE010CMD&S_MODE=SHR_02&PIS_YM="+pis_ym+"&SITE_CD="+site_cd+"&ENO_NO="+eno_no;
			//trT_SI_DILIGENCE.post();

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

			trT_SI_DILIGENCE.KeyValue = "tr01(I:dsT_SI_DILIGENCE=dsT_SI_DILIGENCE)";
			trT_SI_DILIGENCE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage010.cmd.SAGE010CMD&S_MODE=SAV";
			trT_SI_DILIGENCE.post();

			fnc_SearchList();

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


        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			if (dsT_SI_DILIGENCE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SI_DILIGENCE.GridToExcel("식대계산용근태집계현황", '', 225);

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
        function fnc_SearchItemCheck() {


        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_SI_DILIGENCE.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //날짜값들 바인딩
            var svc_ymd     = gcurdate;

            svc_ymd     = addDate("M", gcurdate, 0);
            
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // 해당년월 To

			//값이 없어서 하이픈만 나오는거 방지
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");

			if(PIS_YYMM_SHR.trim() == ""){
				
				document.getElementById("txtPIS_YYMM_SHR").value = "";
				
			}


	        document.getElementById('txtENO_NO_SHR').focus();

            //Grid Style 적용
			cfStyleGrid_New(form1.grdT_SI_DILIGENCE,0,"true","false");


			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001" ){ 

				var eno_no = gusrid;	//사번;
	            //데이터셋 전송
	            dsT_SI_BELONG.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage010.cmd.SAGE010CMD&S_MODE=SHR_01&eno_no="+eno_no;
	            dsT_SI_BELONG.Reset();
	
	            document.getElementById("txtSITE_CD_SHR").value = dsT_SI_BELONG.namevalue(1,"SITE_CD"); 		//
	            document.getElementById("txtSITE_NM_SHR").value = dsT_SI_BELONG.namevalue(1,"SITE_NM");		//

			}


			fnc_SearchList();


	    }




		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


       function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

        }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_SI_DILIGENCE)|
    | 3. 사용되는 Table List(T_SI_DILIGENCE)		 |
    +------------------------------------------------>
    <Object ID="dsT_SI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_SI_BELONG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_SI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_SI_DILIGENCE)			   |
    +------------------------------------------------------>
	<Object ID="trT_SI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_YEARLY=dsT_DI_YEARLY)">
	</Object>





    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_SI_DILIGENCE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_SI_DILIGENCE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_SI_DILIGENCE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_SI_DILIGENCE event="OnFail()">
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="70"></col>
									<col width="190"></col>
                                    <col width="70"></col>
									<col width=""></col>
								</colgroup>
                            <tr>
								<td align="center" class="searchState">기준월</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								 </td>
		                         <td class="searchState" align="right">소 속 &nbsp;</td>
		                         <td class="padding2423">
		                        <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')">
								<input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','소속','AY');fnc_SearchList();"></a>
		                        </td>
                                <td align="right" class="searchState">사 번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9" onkeypress="if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>

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

<!-- 내용 조회 그리드 데이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_SI_DILIGENCE">
                            <param name="ColSelect"  				value="true">
							<PARAM NAME="BorderStyle"				VALUE="0">
							<PARAM NAME="Indwidth"					VALUE="0">
							<PARAM NAME="Fillarea"					VALUE="true">
							<PARAM NAME="Editable"					VALUE="true">
							<PARAM NAME="Colsizing"					VALUE="true">
							<PARAM NAME="TitleHeight"				VALUE=20>
							<param name="sortview"					value=left>
                            <param name="Format"					value="
								<FC>ID={CurRow}		Name='NO'	Width=30   		align=center  	sort=false  editable=false </FC>
								<FC> ID='SITE_NM'	width=100	Name='소속'		align=left		edit=none  sort=true</FC>
								<FC> ID='ENO_NO'		width=60	Name='사번'		align=center	edit=none  sort=true</FC>
								<FC> ID='ENO_NM'		width=60	Name='성명'		align=center	edit=none  sort=true</FC>
                                <FC> id='WRK_DAY'	width=60	name='일수'		align=center    edit=none  sort=true</FC>
                                <FC> id='WRK_PAY'	width=80	name='금액'		align=center    edit=none  sort=true</FC>

                                <C> id='AT1_CD'		width=50	name='1'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN1,'Y','#FEB293',Decode(AT1_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT2_CD'	    width=50	name='2'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN2,'Y','#FEB293',Decode(AT2_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT3_CD'	    width=50	name='3'	    align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN3,'Y','#FEB293',Decode(AT3_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT4_CD'	    width=50	name='4'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN4,'Y','#FEB293',Decode(AT4_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT5_CD'	    width=50	name='5'	    align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN5,'Y','#FEB293',Decode(AT5_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT6_CD'     width=50	name='6'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN6,'Y','#FEB293',Decode(AT6_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT7_CD'     width=50	name='7'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN7,'Y','#FEB293',Decode(AT7_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT8_CD'     width=50	name='8'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN8,'Y','#FEB293',Decode(AT8_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT9_CD'     width=50	name='9'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN9,'Y','#FEB293',Decode(AT9_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT10_CD'    width=50	name='10'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN10,'Y','#FEB293',Decode(AT10_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT11_CD'    width=50	name='11'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN11,'Y','#FEB293',Decode(AT11_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT12_CD'    width=50	name='12'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN12,'Y','#FEB293',Decode(AT12_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT13_CD'    width=50	name='13'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN13,'Y','#FEB293',Decode(AT13_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT14_CD'    width=50	name='14'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN14,'Y','#FEB293',Decode(AT14_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT15_CD'    width=50	name='15'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN15,'Y','#FEB293',Decode(AT15_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT16_CD'    width=50	name='16'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN16,'Y','#FEB293',Decode(AT16_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT17_CD'    width=50	name='17'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN17,'Y','#FEB293',Decode(AT17_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT18_CD'    width=50	name='18'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN18,'Y','#FEB293',Decode(AT18_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT19_CD'    width=50	name='19'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN19,'Y','#FEB293',Decode(AT19_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT20_CD'    width=50	name='20'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN20,'Y','#FEB293',Decode(AT20_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT21_CD'    width=50	name='21'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN21,'Y','#FEB293',Decode(AT21_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT22_CD'    width=50	name='22'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN22,'Y','#FEB293',Decode(AT22_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT23_CD'    width=50	name='23'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN23,'Y','#FEB293',Decode(AT23_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT24_CD'    width=50	name='24'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN24,'Y','#FEB293',Decode(AT24_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT25_CD'    width=50	name='25'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN25,'Y','#FEB293',Decode(AT25_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT26_CD'    width=50	name='26'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN26,'Y','#FEB293',Decode(AT26_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT27_CD'    width=50	name='27'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN27,'Y','#FEB293',Decode(AT27_CD,'X','#F2AC47','#FFFFFF'))} </C>
                                <C> id='AT28_CD'    width=50	name='28'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN28,'Y','#FEB293','X','#EEEEEE')} </C>
                                <C> id='AT29_CD'    width=50	name='29'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN29,'Y','#FEB293','X','#EEEEEE')} </C>
                                <C> id='AT30_CD'    width=50	name='30'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN30,'Y','#FEB293','X','#EEEEEE')} </C>
                                <C> id='AT31_CD'    width=50	name='31'		align=center    EditStyle=Combo, Data='X:X,O:O' BgColor={Decode(HOL_YN31,'Y','#FEB293','X','#EEEEEE')} </C>
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


<!-- 급/상여 MASTER 테이블 -->
<object id="bndT_SI_DILIGENCE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_SI_DILIGENCE">
    <Param Name="BindInfo", Value='
        <C> Col=OCC_NM       Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=DPT_NM       Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=HIR_YMD     Ctrl=txtHIR_YMD     Param=value </C>


    '>
</object>

<object id="bndT_DI_YEARLY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_DI_YEARLY">
    <Param Name="BindInfo", Value='
		<C> Col=HIR_YMD      Ctrl=txtHIR_YMD      Param=value </C>
        <C> Col=YRP_CNT      Ctrl=txtYRP_CNT      Param=value </C>
        <C> Col=YRP_ATT_H    Ctrl=txtYRP_ATT_H    Param=value </C>
        <C> Col=REM_YRP      Ctrl=txtREM_YRP      Param=value </C>
    '>
</object>

