<!--
***********************************************************************
* @source      : guna100.jsp
* @description : 개인별근태집계현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>개인별근태</title>
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
            var eno_nm = document.getElementById('txtENO_NM_SHR').value;
            var pis_yy = document.getElementById('txtPIS_YY_SHR').value;
            var pis_mm_str = document.getElementById('cmbPIS_MM_STR').value;
            var pis_mm_end = document.getElementById('cmbPIS_MM_END').value;

            if(!fnc_SearchItemCheck()) return;  //조회 유효성 검사

			dsT_DI_DILIGENCE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna100.cmd.GUNA100CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PIS_YY="+pis_yy+"&PIS_MM_STR="+pis_mm_str+"&PIS_MM_END="+pis_mm_end;
    		dsT_DI_DILIGENCE.reset();


			trT_DI_DILIGENCE.KeyValue = "tr01(O:dsT_DI_YEARLY=dsT_DI_YEARLY)";
			trT_DI_DILIGENCE.action ="../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna100.cmd.GUNA100CMD&S_MODE=SHR_02&ENO_NO="+eno_no+"&PIS_YY="+pis_yy+"&PIS_MM_STR="+pis_mm_str+"&PIS_MM_END="+pis_mm_end;
			trT_DI_DILIGENCE.post();

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

			trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
			trT_DI_DILIGENCE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna100.cmd.GUNA100CMD&S_MODE=SAV";
			trT_DI_DILIGENCE.post();

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

			if (dsT_DI_DILIGENCE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_DILIGENCE.GridToExcel("개인별근태집계현황", '', 225);

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

            document.getElementById('txtENO_NO_SHR').value = '';
            document.getElementById('txtENO_NM_SHR').value = '';
            document.getElementById("txtOCC_NM").value = '';
            document.getElementById("txtDPT_NM").value = '';
            document.getElementById("txtJOB_NM").value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_DILIGENCE.ClearData();

            document.getElementById('txtENO_NO_SHR').focus();

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

            var pis_yy = document.getElementById("txtPIS_YY_SHR");
            var pis_mm_str = document.getElementById("cmbPIS_MM_STR");
            var pis_mm_end = document.getElementById("cmbPIS_MM_END");
            var eno_no = document.getElementById("txtENO_NO_SHR");

            if(eno_no.value == ""){
                alert("사번을 입력하세요!");
                eno_no.focus();
                return false;
            }

            if(pis_yy.value == "" || pis_yy.value.length < 4){
                alert("4자리수의 년도를 입력하세요!");
                pis_yy.focus();
                return false;
            }

            if(pis_mm_str.value > pis_mm_end.value){
                alert("종료월은 시작월보다 반드시 커야합니다!");
                pis_mm_end.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_DI_DILIGENCE.IsUpdated ) {
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

	            document.getElementById('txtPIS_YY_SHR').value = gcurdate.substring(0,4);
	            document.getElementById('cmbPIS_MM_STR').value = "01";
	            document.getElementById('cmbPIS_MM_END').value = "12";//getToday().substring(5,7);

	            
	            cfStyleGrid_New(form1.grdT_DI_DILIGENCE,15,"true","false");      // Grid Style 적용
	            
	            form1.grdT_DI_DILIGENCE.Editable = true;      // Read Only & Row Selection Mode

	            document.getElementById('txtENO_NO_SHR').focus();

	        }




		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


       function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
                //fnc_SearchList();
        }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
                //fnc_SearchList();
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_DILIGENCE)|
    | 3. 사용되는 Table List(T_DI_DILIGENCE)		 |
    +------------------------------------------------>
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_YEARLY=dsT_DI_YEARLY)">
	</Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_DILIGENCE)|
    | 3. 사용되는 Table List(T_DI_DILIGENCE)		 |
    +------------------------------------------------>
    <Object ID="dsT_DI_GROUPWARE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_GROUPWARE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_DILIGENCE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------------------------------------------------------------------------------------+
    | Grid상에서 Editable상태에서 하나의 Cell에 입력을 완료한 후, 다음 Cell로 포커스를 옮길 때 발생하는 EVENT |
    +--------------------------------------------------------------------------------------------------------->
     <script language=JavaScript for=grdT_DI_DILIGENCE event=OnExit(row,colid,olddata)>

        var nowDate = Number(getToday().replace("-","").replace("-",""));
        var selDate = Number(dsT_DI_DILIGENCE.NameValue(row,"PIS_YYMM").replace("-","")+lpad(colid.substring(2,4).replace("_",""),2,'0'));
        var ret_ymd = Number(dsT_DI_DILIGENCE.NameValue(1,"RET_YMD").replace("-","").replace("-",""));
        var holDate = dsT_DI_DILIGENCE.NameValue(row,"HOL_YN"+(colid.substring(2,4).replace("_","").trim()));//휴일유무

        if(holDate == "X"){
        	
            alert("유효한 일자가 아니라 수정이 불가능합니다.");
            
            dsT_DI_DILIGENCE.NameValue(row,colid) = olddata;
            
            return false;
            
        }

        var newdata = dsT_DI_DILIGENCE.NameValue(row,colid);

		//alert(newdata);
        //나머지 예외처리 추가 자리

        if(newdata == "M"){
        	
            alert("월차는 수정할 수 없습니다.\n\n관리자에게 문의하세요.");
            
            dsT_DI_DILIGENCE.NameValue(row,colid) = olddata;
            
            return false;
            
        }
        
        
        
        if(newdata != olddata){
        	
	        if((newdata == null || newdata.trim() == "") && dsT_DI_DILIGENCE.OrgNameValue(row,colid).trim() != ""){

	            //퇴사자는 퇴사일자이후에 빈값 가능
	            
	            if(ret_ymd == null || ret_ymd == 0 || ret_ymd >= selDate){
	            	
		            alert("빈값을 넣을 수 없습니다.");
		            
		            dsT_DI_DILIGENCE.NameValue(row,colid) = olddata;
		            
		            return false;
		            
	            }

	        }else{
	        	
	            //바뀐데이터의 합계 적용
	            for(var i=1; i<=dsT_DI_DILIGENCE.countrow; i++){
	            	
		            dsT_DI_DILIGENCE.NameValue(i,'ATT_'+olddata) = dsT_DI_DILIGENCE.NameValue(i,'ATT_'+olddata) - 1;
		            
		            dsT_DI_DILIGENCE.NameValue(i,'ATT_'+newdata) = dsT_DI_DILIGENCE.NameValue(i,'ATT_'+newdata) + 1;
		            
	            }
	            
	            return true;
	            
	        }
	        
        }

       </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
                                <td align="right" class="searchState">기 간&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YY_SHR" size="4" maxlength="4" onkeypress="cfNumberCheck();" style="ime-mode:disabled">년&nbsp;

                                    <select id="cmbPIS_MM_STR">
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>월 ~

                                    <select id="cmbPIS_MM_END">
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>월

                                </td>
                                <td align="right" class="searchState">사 번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="if(event.keyCode==13){fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9" onkeypress="if(event.keyCode==13){fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_STR').value), (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_END').value) );"></a>
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>개인정보</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">직&nbsp;&nbsp;종</td>
                    <td class="padding2423">
                        <input id=txtOCC_NM name=txtOCC_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">소&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input id=txtDPT_NM name=txtDPT_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">직&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id=txtJOB_NM name=txtJOB_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">입사일자</td>
                    <td class="padding2423">
                        <input id=txtHIR_YMD name=txtHIR_YMD size="16" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>



<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>연차</strong>
        </td>   
    </tr>
    <tr>
		<td class="paddingTop3">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>                    
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">연차발생일수</td>
                    <td class="padding2423">
                        <input id="txtYRP_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="blueBold">연차사용일수</td>
                    <td class="padding2423">
                        <input id="txtYRP_ATT_H" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="blueBold">미사용연차</td>
                    <td class="padding2423">
                        <input id="txtREM_YRP" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>
                 </tr>
            </table>
        </td>
    </tr>
</table>

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>월차</strong>
            
            (본 화면에서 표시되는 월차 데이터는 전체 생성/사용/잔여 월차가 표시됩니다) 
        </td>
   
    </tr>
    <tr>
		<td class="paddingTop3">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="100"></col>
                    <col width="60"></col>
                    <col width="100"></col>                    
                    <col width="60"></col>                    
                    <col width=""></col>
                </colgroup>
                 <tr>
                    <td align="center" class="blueBold">총 월차발생</td>
                    <td class="padding2423">
                        <input id="txtMPH_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="blueBold">총 월차사용</td>
                    <td class="padding2423">
                        <input id="txtUMPH_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>
                    <td align="center" class="blueBold">미사용월차</td>
                    <td class="padding2423">
                        <input id="txtLMPH_CNT" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
                    </td>                    
                </tr>
            </table>
        </td>
    </tr>
</table>

<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>근태현황</strong>
        </td>
    </tr>
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:330px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE">
                            <param name="ColSelect"  				value="true">
                            <param name="Format"					value="
                                <C> id='PIS_YYMM'	width=50	name='년/월'	align=center </C>
								<C> id='YRP_CNT2'	width=35	name='년차'	    align=center </C>
								<C> id='MPH_CNT2'	width=35	name='월차'	    align=center </C>	
                                <C> id='AT1_CD'		width=27	name='1'		align=center    Edit=Upper BgColor={Decode(HOL_YN1,'Y','#FEB293')} </C>
                                <C> id='AT2_CD'	    width=27	name='2'		align=center    Edit=Upper BgColor={Decode(HOL_YN2,'Y','#FEB293')} </C>
                                <C> id='AT3_CD'	    width=27	name='3'	    align=center    Edit=Upper BgColor={Decode(HOL_YN3,'Y','#FEB293')} </C>
                                <C> id='AT4_CD'	    width=27	name='4'		align=center    Edit=Upper BgColor={Decode(HOL_YN4,'Y','#FEB293')} </C>
                                <C> id='AT5_CD'	    width=27	name='5'	    align=center    Edit=Upper BgColor={Decode(HOL_YN5,'Y','#FEB293')} </C>
                                <C> id='AT6_CD'     width=27	name='6'		align=center    Edit=Upper BgColor={Decode(HOL_YN6,'Y','#FEB293')} </C>
                                <C> id='AT7_CD'     width=27	name='7'		align=center    Edit=Upper BgColor={Decode(HOL_YN7,'Y','#FEB293')} </C>
                                <C> id='AT8_CD'     width=27	name='8'		align=center    Edit=Upper BgColor={Decode(HOL_YN8,'Y','#FEB293')} </C>
                                <C> id='AT9_CD'     width=27	name='9'		align=center    Edit=Upper BgColor={Decode(HOL_YN9,'Y','#FEB293')} </C>
                                <C> id='AT10_CD'    width=27	name='10'		align=center    Edit=Upper BgColor={Decode(HOL_YN10,'Y','#FEB293')} </C>
                                <C> id='AT11_CD'    width=27	name='11'		align=center    Edit=Upper BgColor={Decode(HOL_YN11,'Y','#FEB293')} </C>
                                <C> id='AT12_CD'    width=27	name='12'		align=center    Edit=Upper BgColor={Decode(HOL_YN12,'Y','#FEB293')} </C>
                                <C> id='AT13_CD'    width=27	name='13'		align=center    Edit=Upper BgColor={Decode(HOL_YN13,'Y','#FEB293')} </C>
                                <C> id='AT14_CD'    width=27	name='14'		align=center    Edit=Upper BgColor={Decode(HOL_YN14,'Y','#FEB293')} </C>
                                <C> id='AT15_CD'    width=27	name='15'		align=center    Edit=Upper BgColor={Decode(HOL_YN15,'Y','#FEB293')} </C>
                                <C> id='AT16_CD'    width=27	name='16'		align=center    Edit=Upper BgColor={Decode(HOL_YN16,'Y','#FEB293')} </C>
                                <C> id='AT17_CD'    width=27	name='17'		align=center    Edit=Upper BgColor={Decode(HOL_YN17,'Y','#FEB293')} </C>
                                <C> id='AT18_CD'    width=27	name='18'		align=center    Edit=Upper BgColor={Decode(HOL_YN18,'Y','#FEB293')} </C>
                                <C> id='AT19_CD'    width=27	name='19'		align=center    Edit=Upper BgColor={Decode(HOL_YN19,'Y','#FEB293')} </C>
                                <C> id='AT20_CD'    width=27	name='20'		align=center    Edit=Upper BgColor={Decode(HOL_YN20,'Y','#FEB293')} </C>
                                <C> id='AT21_CD'    width=27	name='21'		align=center    Edit=Upper BgColor={Decode(HOL_YN21,'Y','#FEB293')} </C>
                                <C> id='AT22_CD'    width=27	name='22'		align=center    Edit=Upper BgColor={Decode(HOL_YN22,'Y','#FEB293')} </C>
                                <C> id='AT23_CD'    width=27	name='23'		align=center    Edit=Upper BgColor={Decode(HOL_YN23,'Y','#FEB293')} </C>
                                <C> id='AT24_CD'    width=27	name='24'		align=center    Edit=Upper BgColor={Decode(HOL_YN24,'Y','#FEB293')} </C>
                                <C> id='AT25_CD'    width=27	name='25'		align=center    Edit=Upper BgColor={Decode(HOL_YN25,'Y','#FEB293')} </C>
                                <C> id='AT26_CD'    width=27	name='26'		align=center    Edit=Upper BgColor={Decode(HOL_YN26,'Y','#FEB293')} </C>
                                <C> id='AT27_CD'    width=27	name='27'		align=center    Edit=Upper BgColor={Decode(HOL_YN27,'Y','#FEB293')} </C>
                                <C> id='AT28_CD'    width=27	name='28'		align=center    Edit=Upper BgColor={Decode(HOL_YN28,'Y','#FEB293','X','#EEEEEE')} </C>
                                <C> id='AT29_CD'    width=27	name='29'		align=center    Edit=Upper BgColor={Decode(HOL_YN29,'Y','#FEB293','X','#EEEEEE')} </C>
                                <C> id='AT30_CD'    width=27	name='30'		align=center    Edit=Upper BgColor={Decode(HOL_YN30,'Y','#FEB293','X','#EEEEEE')} </C>
                                <C> id='AT31_CD'    width=27	name='31'		align=center    Edit=Upper BgColor={Decode(HOL_YN31,'Y','#FEB293','X','#EEEEEE')} </C>
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


<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td class="paddingTop3">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>                    
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">정상근무:W</td>
                    <td class="padding2423">
                        <input id="txtATT_W" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">출 장:E</td>
                    <td class="padding2423">
                        <input id="txtATT_E" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">교 육:F</td>
                    <td class="padding2423">
                        <input id="txtATT_F" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">훈 련:G</td>
                    <td class="padding2423">
                        <input id="txtATT_G" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>                     
                    <td align="center" class="blueBold">휴 일:Y</td>
                    <td class="padding2423">
                        <input id="txtATT_Y" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">년 차:H</td>
                    <td class="padding2423">
                        <input id="txtATT_H" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">오전반차:P</td>
                    <td class="padding2423">
                        <input id="txtATT_P" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">오후반차:R</td>
                    <td class="padding2423">
                        <input id="txtATT_R" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>                  
                    <td align="center" class="blueBold">경조휴가:I</td>
                    <td class="padding2423">
                        <input id="txtATT_I" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">대체휴가:T</td>
                    <td class="padding2423">
                        <input id="txtATT_T" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>     
                </tr>
                
                <tr>
                    <td align="center" class="blueBold">난임치료휴가:A</td>
                    <td class="padding2423">
                        <input id="txtATT_A" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">가족돌봄휴가:B</td>
                    <td class="padding2423">
                        <input id="txtATT_B" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">보건휴가:C</td>
                    <td class="padding2423">
                        <input id="txtATT_C" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>                  
                    <td align="center" class="blueBold">산전후휴가:X</td>
                    <td class="padding2423">
                        <input id="txtATT_X" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">배우자 출산휴가:V</td>
                    <td class="padding2423">
                        <input id="txtATT_V" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>     
                </tr>                  
                
                
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->



</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!-- 급/상여 MASTER 테이블 -->
<object id="bndT_DI_DILIGENCE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_DI_DILIGENCE">
    <Param Name="BindInfo", Value='
        <C> Col=OCC_NM       Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=DPT_NM       Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=HIR_YMD      Ctrl=txtHIR_YMD      Param=value </C>
        <C> Col=YRP_CNT2     Ctrl=txtYRP_CNT2     Param=value </C>
        <C> Col=MPH_CNT2     Ctrl=txtMPH_CNT2     Param=value </C>
        <C> Col=ATT_A        Ctrl=txtATT_A        Param=value </C>
        <C> Col=ATT_B        Ctrl=txtATT_B        Param=value </C>
        <C> Col=ATT_C        Ctrl=txtATT_C        Param=value </C>           
        <C> Col=ATT_E        Ctrl=txtATT_E        Param=value </C>
        <C> Col=ATT_F        Ctrl=txtATT_F        Param=value </C>
        <C> Col=ATT_G        Ctrl=txtATT_G        Param=value </C>
        <C> Col=ATT_H        Ctrl=txtATT_H        Param=value </C>        
        <C> Col=ATT_I        Ctrl=txtATT_I        Param=value </C>
        <C> Col=ATT_K        Ctrl=txtATT_K        Param=value </C>
        <C> Col=ATT_M        Ctrl=txtATT_M        Param=value </C>
        <C> Col=ATT_P        Ctrl=txtATT_P        Param=value </C>
        <C> Col=ATT_R        Ctrl=txtATT_R        Param=value </C>
        <C> Col=ATT_T        Ctrl=txtATT_T        Param=value </C>           
        <C> Col=ATT_V        Ctrl=txtATT_V        Param=value </C>        
        <C> Col=ATT_W        Ctrl=txtATT_W        Param=value </C>
        <C> Col=ATT_X        Ctrl=txtATT_X        Param=value </C> 
        <C> Col=ATT_Y        Ctrl=txtATT_Y        Param=value </C>
    '>
</object>

<object id="bndT_DI_YEARLY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_DI_YEARLY">
    <Param Name="BindInfo", Value='
		<C> Col=HIR_YMD      Ctrl=txtHIR_YMD      Param=value </C>
        <C> Col=YRP_CNT      Ctrl=txtYRP_CNT      Param=value </C>
        <C> Col=YRP_ATT_H    Ctrl=txtYRP_ATT_H    Param=value </C>
        <C> Col=REM_YRP      Ctrl=txtREM_YRP      Param=value </C>
        <C> Col=MPH_CNT      Ctrl=txtMPH_CNT      Param=value </C>
        <C> Col=UMPH_CNT     Ctrl=txtUMPH_CNT     Param=value </C>
        <C> Col=LMPH_CNT     Ctrl=txtLMPH_CNT     Param=value </C>
    '>
</object>

