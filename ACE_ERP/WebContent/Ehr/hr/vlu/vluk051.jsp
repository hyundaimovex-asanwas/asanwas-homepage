<!--
*****************************************************
* @source       : vluk051.jsp
* @description  : 고과점수 입력 팝업 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/05/07      이동훈        최초작성.
* 2016/10/10     이동훈        ERP 이사
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>
<head>
<title>고과점수 입력</title>
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

        var GUBUN   = "";

		var strParam = new Array();

		strParam=window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건 2가지
            var REG_YM_SHR = strParam[0];        //해당년도
			var ENO_NO = strParam[1];			 //
			var ENO_NM = strParam[2];
			var ENOH_NO = strParam[3];
			var ENOH_NM = strParam[4];
			var HEAD_CD = strParam[5];
			var JOB_CD = strParam[6];
	  		var GUBUN =  strParam[7];
	  		var EVASEQ =  strParam[8];


			dsT_EV_RQSCORE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
												     + "&S_MODE=SHR_ITEM"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO
												     + "&ENOH_NO="+ENOH_NO
												     + "&HEAD_CD="+HEAD_CD
												     + "&JOB_CD="+JOB_CD
												     + "&EVASEQ="+EVASEQ;
		    dsT_EV_RQSCORE.reset();
			    
		    dsT_EV_COMMENT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
												     + "&S_MODE=SHR_CMT"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO
												     + "&ENOH_NO="+ENOH_NO;
			dsT_EV_COMMENT.reset();		
			    
			    
			if(dsT_EV_COMMENT.countrow<1){
				
				dsT_EV_COMMENT.setDataHeader("EVAYM:STRING, EMPNOH:STRING, EMPNO:STRING, CMMENT:STRING");
				dsT_EV_COMMENT.AddRow();
			}

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요
        	return false;
        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

           var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//해당년도
  		   var GUBUN =  strParam[7];
  		   var GSTR_EVASEQ =  strParam[8];
		   var ENOH_NO = strParam[3];
  		   var GSTR_EMPNO =  document.form1.txtENO_NO_SHR.value;
  		   var TOTAL_SCR = 0;
  		   //var CMMENT = document.form1.txtComment.value;
  		   
  		   var CMMENT = dsT_EV_COMMENT.namevalue(1,"CMMENT");
  		   //System.out.println(p_box);
  		   //alert(CMMENT);
            if (dsT_EV_RQSCORE.IsUpdated || dsT_EV_COMMENT.IsUpdated)  {

		  			if (dsT_EV_RQSCORE.countrow<1){
		  				alert ("저장할 정보가 없습니다.");
		  			}else {
		
		  				if(fnc_Chk()){
		
		  					if (confirm("저장하시겠습니까?")) {
		
		  							for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){
		
		  								if ((dsT_EV_RQSCORE.SysStatus(i)==2)||(dsT_EV_RQSCORE.SysStatus(i)==3)){
			  									dsT_EV_RQSCORE.namevalue(i,"EMPNOH")=	document.form1.txtENOH_NO_SHR.value;
			  									dsT_EV_RQSCORE.namevalue(i,"EMPNO")	=	document.form1.txtENO_NO_SHR.value;
			  									dsT_EV_RQSCORE.namevalue(i,"EVASEQ")=	GSTR_EVASEQ;
		  										}
		
		  								TOTAL_SCR = TOTAL_SCR + dsT_EV_RQSCORE.namevalue(i,"SCR");
		  							}
		

		  							trT_EV_RQSCORE.KeyValue = "tr01(I:dsT_EV_RQSCORE=dsT_EV_RQSCORE)";
		  							trT_EV_RQSCORE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
										  	  							+ "&S_MODE=SAV"
										  	  							+ "&REG_YM_SHR="+REG_YM_SHR
										  	  							+ "&ENOH_NO="+ENOH_NO
										  	  							+ "&EMPNO="+GSTR_EMPNO
										  	  							+ "&GUBUN="+GUBUN
										  	  							+ "&TOTAL_SCR="+TOTAL_SCR
										  	  							+ "&EVASEQ="+GSTR_EVASEQ
			  															+ "&CMMENT="+CMMENT;  							
		  							trT_EV_RQSCORE.post();
		  							
		  							trT_EV_COMMENT.KeyValue = "tr01(I:dsT_EV_COMMENT=dsT_EV_COMMENT)";
		  							trT_EV_COMMENT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
										  	  							+ "&S_MODE=SAV_CMT"
										  	  							+ "&REG_YM_SHR="+REG_YM_SHR
										  	  							+ "&ENOH_NO="+ENOH_NO
										  	  							+ "&EMPNO="+GSTR_EMPNO
			  															+ "&CMMENT="+CMMENT;  							
									//prompt(this,trT_EV_COMMENT.action);
		  							trT_EV_COMMENT.post();		  							

		  							fnc_SearchList();
		
		  					}
		  				}
		  			}
  			
  			
            }else{
            	
            	alert ("변경된 정보가 없습니다.");
            	
            }  		

        }

		/******************************************************************************
		Description : Check
		******************************************************************************/
	    function fnc_Chk() {

	    	for (i=1;i<=dsT_EV_RQSCORE.countrow;i++){

				if(dsT_EV_RQSCORE.namevalue(i,"GB_DTL") != "공통" &&
					dsT_EV_RQSCORE.namevalue(i,"GB_DTL") != "리더십" &&
					dsT_EV_RQSCORE.namevalue(i,"GB_DTL") != "직무"){

					if (dsT_EV_RQSCORE.namevalue(i,"CHK01") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK02") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK03") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK04") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK05") == "F"){

								alert("모든 평가요소를 체크하십시요");

								dsT_EV_RQSCORE.rowposition = i;

					  			return false;

								break;

						}

				}

			}
	    	
	    	if (document.form1.txtComment.value == "" || document.form1.txtComment.value == null){
	    		
				alert("평가의견을 입력하십시요");

	  			return false;	    		
	    		
	    	}

			return true;

	    }


		/******************************************************************************
		Description : Check
		******************************************************************************/
	    function fnc_Chk2(row) {

				if(dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "공통" ||
					dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "리더십" ||
					dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "직무"){
					
							dsT_EV_RQSCORE.namevalue(row,"CHK01") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK02") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK03") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK04") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK05") = "F";

					  		return false;


				}

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {


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

			for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){

				dsT_EV_RQSCORE.namevalue(i,"CHK01") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK02") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK03") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK04") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK05") = "F";

			}

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_RQSCORE.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

             window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {



        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

		document.getElementById("txtREG_YM_SHR").value = strParam[0];
		document.getElementById("txtENO_NO_SHR").value = strParam[1];
		document.getElementById("txtENO_NM_SHR").value = strParam[2];

		document.getElementById("txtENOH_NO_SHR").value = strParam[3];
		document.getElementById("txtENOH_NM_SHR").value = strParam[4];

		fnc_SearchList();

		cfStyleGrid_New2(form1.grdT_EV_RQSCORE);


		
        //cfStyleGrid(form1.grdT_EV_RQSCORE,15,"false","false");      // Grid Style 적용

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


    </script>

    </head>


    <Script For=grdT_EV_RQSCORE Event="OnClick(row,col)">

    if (dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "공통"){
    	fnc_Chk2(row);
		//alert("공통항목에 대한 설명으로 체크하실 필요없습니다.");
    }else if(dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "리더십"){
    	fnc_Chk2(row);
		//alert("리더십항목에 대한 설명으로 체크하실 필요없습니다.");
    }else if(dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "직무"){
    	fnc_Chk2(row);
		//alert("직무항목에 대한 설명으로 체크하실 필요없습니다.");
    }else{

		if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {

			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "F";

			if ("CHK01" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "1";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"ESCR");

			}else if ("CHK02" == col) {
				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "2";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"GSCR");

			}else if ("CHK03" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "3";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"MSCR");

			}else if ("CHK04" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "4";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"LSCR");

			}else if ("CHK05" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "5";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"PSCR");

			}
		}

    }

    </Script>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_RQSCORE)                       |
    | 3. 사용되는 Table List(T_EV_RQSCORE)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_RQSCORE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_COMMENT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_RQSCORE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_EV_COMMENT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_RQSCORE Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_RQSCORE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_RQSCORE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_RQSCORE event="OnFail()">
        if (trT_EV_RQSCORE.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1100" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_CancelOver.gif',1)"><img src="../../images/button/btn_CancelOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1100" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="200"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" class="input_ReadOnly"  readOnly>
                               </td>
                                <td align="right" class="searchState">피고과자</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                </td>
                                <td align="right" class="searchState">고과자</td>
                                <td class="padding2423">
                                    <input id=txtENOH_NO_SHR name=txtENOH_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtENOH_NM_SHR name=txtENOH_NM_SHR size="12" class="input_ReadOnly"  readOnly>
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
<table width="1100" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" width="600" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->


<!-- 내용 조회 그리드 테이블 시작-->
<table width="1100" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_RQSCORE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1100px;height:600px;">
                                <param name="DataID"                 	value="dsT_EV_RQSCORE">
                                <param name="EdiTABLE"               	value="false">
                                <param name="DragDropEnable"         	value="true">
                                <param name="VIEWSUMMARY"          		value=1>
    							<Param Name="SummaryHeight"  			value="40">
                                <param name="AutoReSizing"           	value="true">
                                <param name=ColSizing  				 	value="true">
                                <param name="RowHeight"   				value='20'>
								<param name=TitleHeight 				value="20">
                                <param name="Format"                 	value="
                                    <C> id='GB_MST'     		width=100   name='구분'    		align=center  	sumbgcolor=#dae0ee  edit=none  suppress=1  BgColor=#E4F7BA value={IF(GB_MST='01','공통',IF(GB_MST='02','리더십','직무'))} BodyFontStyle=bold</C>
                                    <C> id='GB_DTL'    			width=150  	name='항목'   		align=left      sumbgcolor=#dae0ee	edit=none BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))}</C>
                                    <C> id='ACT_ITEM'    		width=520  	name='행동지표'   	align=left      SumText='합 계' 		sumbgcolor=#dae0ee	edit=none  Multiline=true BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))}</C>
                                    <C> id='T_SCR'   			width=40  	name='배점'  		align=center  	sumbgcolor=#dae0ee  edit=none value={IF(T_SCR='0','',T_SCR)} BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))} </C>
								<G> Name='점수입력' HeadAlign=Center HeadBgColor=#dae0ee
	                                    <C>id='CHK01'    		width=40  	name='탁월'     		align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', '')))} BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK02'   		width=40  	name='우수'      	align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', '')))} BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK03'   		width=40  	name='보통'   		align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', '')))} BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK04'    		width=40   	name='부족'      	align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', '')))} BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK05'    		width=40   	name='문제'      	align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', '')))} BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))}</C>
                                </G>
                                    <C> id='SCR'       			width=40   	name='결과' 		align=center    SumText={Round(sum(SCR),2)} sumbgcolor=#89add6 edit=none value={IF(SCR='0','',SCR)} dec=2 BgColor={IF(GB_DTL='공통','#FFCC66',IF (GB_DTL='리더십','#FFCC66' , IF (GB_DTL='직무','#FFCC66', 'FFFFFF')))} BgColor=#E3E3FF BodyFontStyle=bold SumFontStyle=bold</C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                  
                </table>
            </td>
        </tr>
</table>


<table width="1100" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60">
                            <colgroup>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right" >평가의견&nbsp;</td>
                                <td class="padding2423" align="left" id="txtComment"  style="display:">
									<textarea id="txtComment"  cols=160  rows=3></textarea>
                               </td>
                            </tr>
                        </table>
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
<!-- -->
<object id="bndT_EV_COMMENT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_COMMENT">
	<Param Name="BindInfo", Value='
        <C>Col=CMMENT     		Ctrl=txtComment     		Param=value 	</C>
    '>
</object>