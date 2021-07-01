<!--
***********************************************************************
* @source      : scha090.jsp
* @description : 학자금 신청기간 설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/07/22            이동훈            	ERP이사						
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>학자금 신청기간 설정</title>
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


        var today = gcurdate;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var pis_yy = document.getElementById('txtPIS_YY_SHR').value;

            if(!fnc_SearchItemCheck()) return;  //조회 유효성 검사

			dsT_SC_RQSTYMD.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha090.cmd.SCHA090CMD&S_MODE=SHR&PIS_YY="+pis_yy;
    		dsT_SC_RQSTYMD.reset();

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

            trT_SC_RQSTYMD.KeyValue = "tr01(I:dsT_SC_RQSTYMD=dsT_SC_RQSTYMD)";
			trT_SC_RQSTYMD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha090.cmd.SCHA090CMD&S_MODE=SAV";
			trT_SC_RQSTYMD.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_SC_RQSTYMD.CountRow < 1) {
				
				alert("삭제할 자료가 없습니다.");
				
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				
				return;
			}

			if(confirm("[년도:"+dsT_SC_RQSTYMD.NameValue(dsT_SC_RQSTYMD.RowPosition,'PIS_YY')+"/분기:"+dsT_SC_RQSTYMD.NameValue(dsT_SC_RQSTYMD.RowPosition,'PIS_QQ')+"]의 정보를 삭제하시겠습니까?")){
				
				dsT_SC_RQSTYMD.DeleteRow(dsT_SC_RQSTYMD.RowPosition);
				
				trT_SC_RQSTYMD.KeyValue = "tr01(I:dsT_SC_RQSTYMD=dsT_SC_RQSTYMD)";
				
				trT_SC_RQSTYMD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha090.cmd.SCHA090CMD&S_MODE=DEL";
				trT_SC_RQSTYMD.post();
				
			}

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

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_SC_RQSTYMD.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_SC_RQSTYMD.setDataHeader("PIS_YY:STRING:KEYVALUE, PIS_QQ:STRING, STR_YMD:STRING, END_YMD:STRING, PAY_YM:STRING, PAY_YMD:STRING");
			}

            dsT_SC_RQSTYMD.AddRow();
            
            dsT_SC_RQSTYMD.NameValue(dsT_SC_RQSTYMD.RowPosition, "PIS_YY")  = document.getElementById('txtPIS_YY_SHR').value;

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

            if (dsT_SC_RQSTYMD.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            var pis_yy = document.getElementById('txtPIS_YY_SHR');

            if(pis_yy.value == "" || pis_yy.value.length < 4){
                alert("4자리수 년도를 입력하세요!");
                pis_yy.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_SC_RQSTYMD.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}


            //신청일, 종료일이 같은지 여부 검증
            var str_ymd;
            var end_ymd;
            var str_ymd2;
            var end_ymd2;
            var pay_ym;
            var pay_ym2;
            for(var i=1; i<=dsT_SC_RQSTYMD.CountRow; i++) {
                str_ymd = parseInt(dsT_SC_RQSTYMD.NameString(i, "STR_YMD").replace(/-/g, ""));
                end_ymd = parseInt(dsT_SC_RQSTYMD.NameString(i, "END_YMD").replace(/-/g, ""));
                pay_ym  = parseInt(dsT_SC_RQSTYMD.NameString(i, "PAY_YM").replace(/-/g, ""));

                for(var j=1; j<=dsT_SC_RQSTYMD.CountRow; j++) {
                    if(i == j) continue;

                    str_ymd2 = parseInt(dsT_SC_RQSTYMD.NameString(j, "STR_YMD").replace(/-/g, ""));
                    end_ymd2 = parseInt(dsT_SC_RQSTYMD.NameString(j, "END_YMD").replace(/-/g, ""));
                    pay_ym2  = parseInt(dsT_SC_RQSTYMD.NameString(j, "PAY_YM").replace(/-/g, ""));


                    if((str_ymd  <= str_ymd2 && str_ymd2 <= end_ymd)
                            || (str_ymd  <= end_ymd2 && end_ymd2 <= end_ymd)
                            || (str_ymd2 <= str_ymd  && str_ymd  <= end_ymd2)
                            || (str_ymd2 <= end_ymd  && end_ymd  <= end_ymd2)) {
                        alert(i+"번째 줄과 "+j+"번째 줄의 기간값이 중복됩니다.\n 신청시작일와, 신청종료일을 확인해 주세요.");
                        return false;
                    }
                }
            }

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YY_SHR').value = today.substring(0,4);

			cfStyleGrid_New(form1.grdT_SC_RQSTYMD,15,"false","false");      // Grid Style 적용

            document.getElementById('txtPIS_YY_SHR').focus();

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		var elementList = new Array( "txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"txtPAY_YM"
                                    ,"txtPAY_YMD"
                                    ,"imgSTR_YMD"
                                    ,"imgEND_YMD"
                                    ,"imgPAY_YM"
                                    ,"imgPAY_YMD" );

		var keyList = new Array(     "txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"txtPAY_YM"
                                    ,"txtPAY_YMD" );


        /**
         * 신청 시작일자를 넣을때 신청 년도를 자동으로 바인딩
         */
        function bindPIS_YY() {
        	
            //alert("뭐냐");
        	
            var str_ymd = document.getElementById("txtSTR_YMD").value;
            
            var pis_yy = "";

            if(str_ymd.length > 3) {
            	
                pis_yy = str_ymd.substr(0,4);
            }
            

            
            dsT_SC_RQSTYMD.NameString(dsT_SC_RQSTYMD.RowPosition, "PIS_YY") = pis_yy;
            
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_SC_RQSTYMD)   |
    | 3. 사용되는 Table List(T_SC_RQSTYMD)		     |
    +------------------------------------------------>
    <Object ID="dsT_SC_RQSTYMD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_SC_RQSTYMD)	    |
    | 3. 사용되는 Table List(T_SC_RQSTYMD)	            |
    +--------------------------------------------------->
    <Object ID ="trT_SC_RQSTYMD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_SC_RQSTYMD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_SC_RQSTYMD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_SC_RQSTYMD Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_SC_RQSTYMD event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_SC_RQSTYMD event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_SC_RQSTYMD event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            fnc_EnableElementAll(elementList);
        }
    </script>


    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_SC_RQSTYMD event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_SC_RQSTYMD.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_SC_RQSTYMD.GetHdrDispName('-3', colName) + " ]은(는) 필수 입력사항입니다");
                    document.getElementById(keyName).focus();
                    return false;
                }
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
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
									<col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">년 도&nbsp;</td>
								<td class="padding2423">
                                     <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
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

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">신청시작일</td>
					<td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this); bindPIS_YY();" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imdSTR_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imdSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','60','180');"></a>
                    </td>
                    <td align="center" class="blueBold">신청종료일</td>
					<td class="padding2423">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','300','180');"></a>
                    </td>
                    <td align="center" class="blueBold">지급년월</td>
					<td class="padding2423">
                        <input id="txtPAY_YM" size="7" maxlength="7" onkeypress="cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YM','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" name="imgPAY_YM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPAY_YM','','540','180');"></a>
                    </td>
                    <td align="center" class="blueBold">지급일자</td>
					<td class="padding2423">
                        <input id="txtPAY_YMD" size="10" maxlength="10" onkeypress="cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; this.focus();}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" name="imgPAY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAY_YMD','','540','180');"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
						<object	id="grdT_SC_RQSTYMD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_SC_RQSTYMD">
                            <param name="Format"					value="
								<C> id={currow}			width=65    	name='NO'		    		align=center </C>
								<C> id='PIS_YY'	    	width=140	name='년도'	        		align=center </C>
                                <C> id='STR_YMD' 		width=200	name='신청시작일'	   		align=center </C>
								<C> id='END_YMD'		width=200	name='신청종료일'	    	align=center </C>
								<C> id='PAY_YM'	    	width=160	name='지급년월'	  		align=center </C>
								<C> id='PAY_YMD'		width=160	name='지급일자'	 		align=center </C>
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

<!-- 학자금 신청기간 테이블 -->
<object id="bndT_SC_RQSTYMD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_SC_RQSTYMD">
    <Param Name="BindInfo", Value='
        <C> Col=PIS_YY       	Ctrl=txtPIS_YY       		Param=value</C>
        <C> Col=PIS_QQ       	Ctrl=cmbPIS_QQ       	Param=value</C>
        <C> Col=STR_YMD      	Ctrl=txtSTR_YMD      	Param=value</C>
        <C> Col=END_YMD      Ctrl=txtEND_YMD      	Param=value</C>
        <C> Col=PAY_YM       	Ctrl=txtPAY_YM      	 	Param=value</C>
        <C> Col=PAY_YMD      	Ctrl=txtPAY_YMD      	Param=value</C>
    '>
</object>


