<!--
***********************************************************************
* @source      : etcb071.jsp
* @description : 근태현황 결재처리 - 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/10/20      권혁수        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //품의자사번
%>
<html>
<head>
	<title>근태현황 결재처리 - 결재세부사항(etcb071)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFFFFT';

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			//alert(dsTemp.NameValue(1,"REQ_NO"));
            //결재세부사항 조회(변경신청)
            if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SHR_01&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
                dsT_DI_CHANGE.reset();
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="C"){//일일근태
                dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SHR_02&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO");
                dsT_DI_CHANGE.reset();
            }

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {


            if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "일일근태";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"REQ_YMD");
                document.getElementById("txtGUN_GBN").value = "변경신청";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="R"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "대체근무";
            }
            if(dsTemp.NameValue(1,"APP_TIME")!=""){
                document.getElementById("txtUPT_YMD").value = dsTemp.NameValue(1,"APP_TIME");
            }else{
                document.getElementById("append_btn").style.display = "";
            }
			// 결재자만 버튼이 활성화
            if(dsTemp.NameValue(1,"ENO_NO")!= "<%=eno_no%>"){
                document.getElementById("append_btn").style.display = "none";
            }else{
                document.getElementById("append_btn").style.display = "";
            }

            var nowDate = getToday().replace("-","").replace("-","");
            //var gunDate = (document.getElementById("txtGUN_YMD").value).replace("-","").replace("-","");
/*
			//일일근태는 당일 9시 이전에만 결재가능(임시 주석, 김우태 대리, 20070905)
            if(dsTemp.NameValue(1,"GUN_GBN")=="C" && (new Date().getHours() >= "9" || nowDate != gunDate) ){
			   document.getElementById("append_btn").style.display = "none";

			//근태변경는 30일 이전에만 결재가능(임시 주석, 김우태 대리, 20070905)
			}else if(dsTemp.NameValue(1,"GUN_GBN")=="U" && parseInt(cfDateDiff(gunDate, nowDate)) >30){
				document.getElementById("append_btn").style.display = "none";
			}
*/
            fnc_ChangeGrid();//그리드 변경 처리

			cfStyleGrid(form1.grdT_DI_CHANGE,0,"false","false");      // Grid Style 적용

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid() {

			if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=100	name="소속"		align=center	</C> '
                							+ '<C> id="JOB_NM"	width=70	name="직위"		align=center    </C> '
                							+ '<C> id="ENO_NO"	width=70	name="사번"		align=center	</C> '
                							+ '<C> id="ENO_NM"	width=100	name="성명"		align=center	</C> '
                							+ '<C> id="GUN_CD"	width=100	name="근태"	    align=center	VALUE={DECODE(GUN_CD,"()","",GUN_CD)}</C>   '
                							+ '<C> id="PIS_YYMMDD"	width=100	name="근태일자"	align=center	Mask="XXXX-XX-XX"	</C> '
                							+ '<C> id="REMARK"	width=140	name="사유"	    align=left	    </C>';
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=80	name="소속"		align=center	</C>  '
                                            + '<C> id="JOB_NM"	width=70	name="직위"		align=center    </C>  '
                                            + '<C> id="ENO_NO"	width=50	name="사번"		align=center	</C>  '
                                            + '<C> id="ENO_NM"	width=60	name="성명"		align=center	</C>  '
                                            + '<G> name="변경전근태"  HeadBgColor="#F7DCBB"                       '
											+ '    <C> id="REQ_YMD"	    width=80	name="근태일"	align=center Mask="XXXX-XX-XX"  </C> '
                                            + '    <C> id="BF_GUN_CD"	width=80	name="근태"	align=center  VALUE={DECODE(BF_GUN_CD,"()","",BF_GUN_CD)}  </C> '
                                            + '    <C> id="BF_REMARK"	width=100	name="사유"	align=left	    </C> '
                                            + '</G>'
                                            + '<G> name="변경후근태"  HeadBgColor="#F7DCBB"                       '
                                            + '<C> id="GUN_CD"		width=80	name="근태"	align=center  VALUE={DECODE(GUN_CD,"()","",GUN_CD)} 	</C>  '
											+ '<C> id="CHN_YMD"	    width=80	name="근태일"	align=center  Mask="XXXX-XX-XX" </C> '
                                            + '<C> id="REASON"		width=100	name="사유"	align=left	    </C>  '
                                            + '</G>';
            }

		}

        /********************************************
         * 17. 승인, 기각 버튼 처리					*
         ********************************************/
		function fnc_Append(yn_var) {

            var msg = "";
			
            if(yn_var == "Y"){
                msg = "결재처리를";
            }else{
				if(document.getElementById("txtREMARK").value == ""){
					alert("부결사유를 입력하세요");
					document.getElementById("txtREMARK").focus();
					return false;
				}
                msg = "부결처리를";
            }

            if (confirm(msg+" 하시겠습니까?")) {

				dsT_DI_CHANGE.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_CHANGE=dsT_DI_CHANGE)";
				//trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_YMD="+document.getElementById("txtGUN_YMD").value+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+document.getElementById("txtREMARK").value;
				trT_DI_APPROVAL.post();

            }

            window.close();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_CHANGE)		   |
    | 3. 사용되는 Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_APPROVAL)	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
        document.getElementById("append_btn").style.display = "none";
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--**************************************************************************************
*                                       												 *
*	BODY START																			 *
*                                       												 *
***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태현황 결재처리 - 결재세부사항</td>
					<td align="right" class="navigator">HOME/기초정보/통합결재/<font color="#000000">근태현황 결재처리 - 결재세부사항</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="left">
				※일일근태 9시 이전에, 근태변경은 30일 이전에만 결재가 가능합니다.
			</td>
			<td height="35" class="paddingTop5" align="right">
                <span id="append_btn" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)">  <img src="/images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)">  <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');"></a>
                </span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- 조건 입력 테이블 시작 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="110"></col>
                    <col width="140"></col>
					<col width="110"></col>
                    <col width="140"></col>
					<col width="110"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">근태구분</td>
					<td class="padding2423">
                        <input id="txtGUN_GBN" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">결재일시</td>
					<td class="padding2423">
                        <input id="txtUPT_YMD" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">결재사유</td>
					<td class="padding2423">
                        <input id="txtREMARK" style="width:100%;text-align:left;">
                    </td>
				</tr>
            </table>
            </td>
	</table>
	<!-- 조건 입력 테이블 끝 -->
</tr>
</table>

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- 조회 상태 테이블 시작 -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조회 상태 테이블 끝 -->
			</td>
		</tr>
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_DI_CHANGE">
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