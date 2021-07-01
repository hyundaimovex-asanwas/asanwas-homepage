<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ 시스템명 : 식대관리 - 식대계산
+ 기능정의 : 식대 계산 조회한다.
+ 프로그램ID : sage020.jsp
+ 기능정의 :
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2016.03.14
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.DateUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>식대 계산</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = gcurdate.substring(0,4);

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			//정보 조회

			dsT_SA_PAYMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage020.cmd.SAGE020CMD&S_MODE=SHR"
																				+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
																				+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value
																				+ "&ENO_NO=" + document.getElementById("txtENO_NO_SHR").value;

			dsT_SA_PAYMASTER.reset();




        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {

			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_SA_PAYMASTER.KeyValue = "tr01(I:dsT_SA_PAYMASTER=dsT_SA_PAYMASTER)";
			trT_SA_PAYMASTER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage020.cmd.SAGE020CMD&S_MODE=SAV";
			trT_SA_PAYMASTER.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {


    		if (dsT_SA_PAYMASTER.countrow<1) {
    			alert("출력하실 정보가 없습니다");
    		} else {

    			dsT_RP_REPORT.clearall();

    		var ls_temp = "";



            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_RP_REPORT.CountColumn == 0) {
            	dsT_RP_REPORT.setDataHeader("WRK_YM:STRING, ");

            	//dsT_RP_REPORT.setDataHeader("WRK_YM:STRING, SITE_CD:STRING, SITE_NM:STRING, ENO_NM:STRING, CET_NO:STRING, INT_AGE:DECIMAL, WRK_AMT:DECIMAL, WRK_DAY:DECIMAL, WRK_PAY:DECIMAL, INCM_TAX:DECIMAL, CITI_TAX:DECIMAL, NPEN_AMT:DECIMAL, HINU_AMT:DECIMAL, HINS_AMT:DECIMAL, SUB_SUM:DECIMAL, ACT_AMT:DECIMAL, NPEN_CAMT:DECIMAL, HINU_CAMT:DECIMAL, HINS_CAMT:DECIMAL, SAN_CAMT:DECIMAL,SUB_CSUM:DECIMAL, FINAL_AMT:DECIMAL");
            	dsT_RP_REPORT.setDataHeader("WRK_YM:STRING,SITE_CD:STRING,SITE_NM:STRING,ENO_NM:STRING,REMARK:STRING,CET_NO:STRING,BNK_NM:STRING,ACC_NO:STRING,INT_AGE:DECIMAL,PH_NO:STRING,ADDRESS:STRING,WRK_AMT:DECIMAL,WRK_DAY:STRING,CNT:STRING,WRK_PAY:DECIMAL,INCM_TAX:DECIMAL,CITI_TAX:DECIMAL,NPEN_AMT:DECIMAL,HINU_AMT:DECIMAL,HINS_AMT:DECIMAL,SUB_SUM:DECIMAL,ACT_AMT:DECIMAL,NPEN_CAM:DECIMALT,HINU_CAMT:DECIMAL,HINS_CAMT:DECIMAL,SAN_CAMT:DECIMAL,SUB_CSUM:DECIMAL,FINAL_AMT:DECIMAL,APP_YN:STRING");
            }

    		dsT_RP_REPORT.ImportData(dsT_SA_PAYMASTER.ExportData(1,dsT_SA_PAYMASTER.countrow,false));

			var yyyy = document.getElementById("txtPIS_YYMM_SHR").value.substring(0,4);
			var mm = document.getElementById("txtPIS_YYMM_SHR").value.substring(5,7);

			for(i=1;i<=dsT_RP_REPORT.countrow;i++){

				if(dsT_RP_REPORT.namevalue(i,"WRK_DAY") == '0'){

					dsT_RP_REPORT.namevalue(i,"ENO_NM")="";

					dsT_RP_REPORT.namevalue(i,"SITE_NM")="                               소 계";
					dsT_RP_REPORT.namevalue(i,"WRK_DAY")='';
					dsT_RP_REPORT.namevalue(i,"CNT")='';
					dsT_RP_REPORT.namevalue(i,"WRK_AMT")='';


				}

			}

    		fnc_RptFormat(yyyy,mm);

    		ReportID.SuppressColumns ="1:SITE_NM";

    		ReportID.Preview();

    		}


        }


        /******************************************************************************
				Description :  출력물 포멧 작성
		******************************************************************************/
		function fnc_RptFormat(yyyy,mm){

			var ls_for = "";

			ls_for += "<B>id=Header ,left=0,top=0 ,right=2900 ,bottom=120 ,face='Tahoma' ,size=10 ,penwidth=1";

			ls_for += "<T>id=''"+yyyy+"'년 '"+mm+"'월 일용노무비 내역서' ,left=800 ,top=0 ,right=2400 ,bottom=90 ,face='Tahoma' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

			ls_for += "<L> left=1180 ,top=100 ,right=2000 ,bottom=100 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>";

			//ls_for += "<I>id='"+rDOMAIN+"/common/img/icon.jpg' ,left=2550 ,top=1880 ,right=2800 ,bottom=1970</I>";

			ls_for += "<T>id='Page : #p of #t' ,left=950 ,top=1900 ,right=2000 ,bottom=2000 ,align='center' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

			ls_for += "</B>";




			ReportID.format = ls_for + ReportID.format ;

			//prompt(this, ReportID.format);


		}


		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_SA_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SA_PAYMASTER.GridToExcel("노무비현황", '', 225);


        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

		}

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {

        }



		/********************************************
         * 09. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {


		}

		/********************************************
         * 10. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_SA_PAYMASTER.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			
        	window.close();

        }

		/********************************************
         * 11. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 12. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( !dsT_SA_PAYMASTER.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            //날짜값들 바인딩
            var svc_ymd     = gcurdate;

            svc_ymd     = addDate("M", gcurdate, 0);
            
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // 해당년월 To


			//값이 없어서 하이픈만 나오는거 방지
			var YYMM = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");

			if(YYMM.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}

            cfStyleGrid_New(form1.grdT_SA_PAYMASTER,0,"false","true");      // Grid Style 적용



        }

		/********************************************
         * 14. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


		/******************************************************************************
		* 15.  식대 계산
		******************************************************************************/
	  	function fnc_Creat(){

				var yy = document.getElementById("txtPIS_YYMM_SHR").value.substring(0,4);
				var mm = document.getElementById("txtPIS_YYMM_SHR").value.substring(5,7);

		  		if(confirm( yy+"년 "+mm+"월 식대를 계산하시겠습니까?")){

		            // 해당 Dataset의 Header가 없으면 Header 선언
		            if (dsT_SA_PAYMASTER01.CountColumn == 0) {
		            	dsT_SA_PAYMASTER01.setDataHeader("WRK_YM:STRING");
			            dsT_SA_PAYMASTER01.addrow();
		            }else{

		            	dsT_SA_PAYMASTER01.addrow();
			        }



		            dsT_SA_PAYMASTER01.namevalue(dsT_SA_PAYMASTER01.rowposition,"WRK_YM") = document.getElementById("txtPIS_YYMM_SHR").value;

					trT_SA_PAYMASTER.KeyValue = "tr01(I:dsT_SA_PAYMASTER01=dsT_SA_PAYMASTER01)";

					trT_SA_PAYMASTER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage020.cmd.SAGE020CMD&S_MODE=SAV";

		            trT_SA_PAYMASTER.post();

				}

		}


		/********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {

            if (obj.value == '') return;

            if(!cfDateExpr(obj.value)) {
            	
                alert('유효한 날짜가 아닙니다.');
                
                obj.focus();
                
            }
            
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
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDAPP)			 	   |
    | 3. 사용되는 Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SA_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
		<param name="SubsumExpr"		value="1:SITE_NM">
	</Object>

	<Object ID="dsT_SA_PAYMASTER01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDAPP)			       |
    | 3. 사용되는 Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_SA_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SA_PAYMASTER=dsT_SA_PAYMASTER,I:dsT_SA_PAYMASTER=dsT_SA_PAYMASTER)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_SA_PAYMASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SA_PAYMASTER.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_SA_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_SA_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_SA_PAYMASTER event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_SA_PAYMASTER event="OnFail()">
        alert(trT_SA_PAYMASTER.ErrorMsg);
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

	<!-- form 시작 -->
	<form name="form1" id="form1">


	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','../../images/button/btn_CreateOver.gif',1)"><img src="../../images/button/btn_CreateOn.gif" name="imgCreate" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Creat()"></a>
	            &nbsp;&nbsp;
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"><img src="../../images/button/btn_ExcelOn.gif" name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0" id="searchTable">
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
                            <col width=""></col>
                        </colgroup>
                        <tr>

							<td align="center" class="searchState">기준월</td>
                            <td class="padding2423">
								<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
							</td>

                            <td class="searchState" align="right">소 속 &nbsp;</td>
	                        <td class="padding2423">
		                        <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:20%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')">
								<input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','소속','AY');fnc_SearchList();"></a>
	                        </td>

							<td align="center" class="searchState">성명</td>
							<td >
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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_SA_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" 					value="dsT_SA_PAYMASTER">
						<PARAM NAME="TITLEHEIGHT"		VALUE=40>
						<PARAM NAME="SORTVIEW"    		VALUE=LEFT>
						<PARAM NAME="BORDERSTYLE" 		VALUE="0">
						<PARAM NAME="INDWIDTH"			VALUE="0">
						<PARAM NAME="FILLAREA"				VALUE="true">
						<PARAM NAME="EDITABLE"				VALUE="true">
						<PARAM NAME="Colsizing"				VALUE="true">
                        <param name="SuppressOption"    	value="1">
						<param name="ViewSummary"  		value="1">
						<param name="Format" 					value="
               				<FC>Name=NO			ID={CurRow} 		Width=50,  	align=center, 	sort = false 				SumBgColor=#C3D0DB	editable=false</FC>
							<FC>Name=소속,   		ID=SITE_NM,  		width=380, 	align=left, 		edit=none sort = true SumBgColor=#C3D0DB suppress=1 SubSumText='소 계' </FC>
							<FC>Name=직위,   		ID=JOB_NM,  		width=100, 	align=center, 	edit=none sort = true SumBgColor=#C3D0DB</FC>
							<FC>Name=사번,   		ID=ENO_NO,  		width=100, 	align=center, 	edit=none sort = true SumBgColor=#C3D0DB</FC>
							<FC>Name=성명,   		ID=ENO_NM,  		width=100, 	align=center, 	edit=none sort = true SumBgColor=#C3D0DB</FC>
							<FC>Name=일수,  		ID=WRK_DAY,  	width=70, 	align=center, 	edit=none sort = true  SumBgColor=#C3D0DB</FC>
							<FC>Name=지급액,  		ID=WRK_PAY,  		width=170, 	align=right, 	edit=none sort = true  SumBgColor=#C3D0DB 	SumText=@sum</FC>

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





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 일용직 급 여 ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    			value="dsT_RP_REPORT">
	<PARAM NAME="PaperSize"						VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="120">
	<PARAM NAME="Format" 						VALUE="

<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=90 ,face='굴림체' ,size=9 ,penwidth=1
	<T>id='No' ,left=0 ,top=0 ,right=45 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='현 장' ,left=45 ,top=0 ,right=460 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='성 명' ,left=460 ,top=0 ,right=560 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='일수' ,left=560 ,top=0 ,right=640 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='실제' ,left=640 ,top=0 ,right=720 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='일당' ,left=720 ,top=0 ,right=850 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='노무비' ,left=850 ,top=0 ,right=1000 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='근로자' ,left=1000 ,top=0 ,right=1900 ,bottom=42 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='소득세' ,left=1000 ,top=42 ,right=1140 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='주민세' ,left=1140 ,top=42 ,right=1280 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='국민연금' ,left=1280 ,top=42 ,right=1420 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='건강보험' ,left=1420 ,top=42 ,right=1560 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='고용보험' ,left=1560 ,top=42 ,right=1700 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='계' ,left=1700 ,top=42 ,right=1840 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='실수령액' ,left=1840 ,top=0 ,right=1990 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='회사부담분' ,left=1990 ,top=0 ,right=2690 ,bottom=42 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='국민연금' ,left=1990 ,top=42 ,right=2125 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='건강보험' ,left=2125 ,top=42 ,right=2260 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='산재보험' ,left=2260 ,top=42 ,right=2400 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='고용보험' ,left=2400 ,top=42 ,right=2540 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='계' ,left=2540 ,top=42 ,right=2680 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='합계' ,left=2680 ,top=0 ,right=2830 ,bottom=90 ,face='굴림체' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=61 ,face='굴림체' ,size=8 ,penwidth=1
	<C>id='{CURROW}', left=0, top=0, right=45, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SITE_NM', left=45, top=0, right=460, bottom=61, align='left', border=true, penstyle=solid, penwidth=1, pencolor=#000000, supplevel=1,BgColor=#C0C0C0</C>


	<C>id='{decode(ENO_NM,'',\'소 계\',ENO_NM)}', left=460, top=0, right=560, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='WRK_DAY', left=560, top=0, right=640, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{decode(ENO_NM,'','',CNT)}', left=640, top=0, right=720, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{decode(ENO_NM,'','',WRK_AMT)}', left=720, top=0, right=850, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='WRK_PAY', left=850, top=0, right=1000, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='INCM_TAX', left=1000, top=0, right=1140, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='CITI_TAX', left=1140, top=0, right=1280, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='NPEN_AMT', left=1280, top=0, right=1420, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINU_AMT', left=1420, top=0, right=1560, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINS_AMT', left=1560, top=0, right=1700, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SUB_SUM', left=1700, top=0, right=1840, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='ACT_AMT', left=1840, top=0, right=1990, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='NPEN_CAMT', left=1990, top=0, right=2125, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINU_CAMT', left=2125, top=0, right=2260, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SAN_CAMT', left=2260, top=0, right=2400, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINS_CAMT', left=2400, top=0, right=2540, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SUB_CSUM', left=2540, top=0, right=2680, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='FINAL_AMT', left=2680, top=0, right=2830, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=64 ,face='Arial' ,size=8 ,penwidth=1
	<X>left=0 ,top=0 ,right=850 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=850 ,top=0 ,right=1000 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1000 ,top=0 ,right=1140 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1140 ,top=0 ,right=1280 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1280 ,top=0 ,right=1420 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1420 ,top=0 ,right=1560 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1560 ,top=0 ,right=1700 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1700 ,top=0 ,right=1840 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1840 ,top=0 ,right=1990 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1990 ,top=0 ,right=2125 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2125 ,top=0 ,right=2260 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2260 ,top=0 ,right=2400 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2400 ,top=0 ,right=2540 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2540 ,top=0 ,right=2680 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2680 ,top=0 ,right=2830 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>


	<T>id='총계' ,left=0 ,top=0 ,right=850 ,bottom=64 ,face='굴림체' ,size=9 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>

	<C>id='{Sum(WRK_PAY)/2} ', left=850, top=1, right=1000, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(INCM_TAX)/2} ', left=1000, top=1, right=1140, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(CITI_TAX)/2} ', left=1140, top=1, right=1280, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(NPEN_AMT)/2} ', left=1280, top=1, right=1420, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINU_AMT)/2} ', left=1420, top=1, right=1560, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINS_AMT)/2} ', left=1560, top=1, right=1700, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(SUB_SUM)/2} ', left=1700, top=1, right=1840, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(ACT_AMT)/2} ', left=1840, top=1, right=1990, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>

	<C>id='{Sum(NPEN_CAMT)/2} ', left=1990, top=1, right=2125, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINU_CAMT)/2} ', left=2125, top=1, right=2260, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(SAN_CAMT)/2} ', left=2260, top=1, right=2400, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINS_CAMT)/2} ', left=2400, top=1, right=2540, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(SUB_CSUM)/2} ', left=2540, top=1, right=2680, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(FINAL_AMT)/2} ', left=2680, top=1, right=2830, bottom=62, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>


</B>

">
</OBJECT>





</body>
</html>


