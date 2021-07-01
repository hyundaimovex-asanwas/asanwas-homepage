<!--*************************************************************************
* @source      : yaca050_14.jsp                                                *
* @description : 연말정산결과조회 PAGE                                      *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2014/11/6            이동훈             최초작성    
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
    <jsp:include page="/Ehr/common/include/head.jsp"/>     
    
    <title>연말정산결과조회(yaca050_2014년도)</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>	
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

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
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var today = getToday();
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD";
        var params = null;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {

            params = "&S_MODE=SHR_142"
                + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;            

            trT_AC_RETACC.KeyValue = "tr"
                + "(O:dsT_AC_RETACC=dsT_AC_RETACC)";
            
			trT_AC_RETACC.action = dataClassName+params;
			
			trT_AC_RETACC.post();            
            
        }



        /**
         * 사원정보를 조회 한다.
         */
        function fnc_SearchEmp() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetEnoNm('txtENO_NO_SHR');

            if(document.getElementById("txtENO_NO_SHR").value != "") {
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
            }
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
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {

            //귀속년도 초기값 설정
            document.getElementById("txtPIS_YY_SHR").value = '2014';

            document.getElementById("txtENO_NO_SHR").value = gusrid;            
            document.getElementById("txtENO_NM_SHR").value = gusrnm;   
            
    		//관리자가 아닐 경우 타인은 조회가 되지 않게
			if(gusrid != "6060002" && gusrid != "2030007" && gusrid != "2140002"  && gusrid != "6070001" ){
				
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

			}            

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
         * 17. 원천 징수부 출력
         ********************************************/
        function fnc_Print() {
        	
        	//데이터셋 초기화 
        	gcds_print.ClearAll();
        	gcds_print3.ClearAll();
        	gcds_print4.ClearAll();
        	gcds_print4_1.ClearAll();
        	gcds_print4_2.ClearAll();
        	gcds_print4_3.ClearAll();
        	gcds_print4_4.ClearAll();
        	
        	var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;
			
			
        	//1,2pgae
        	gcds_print.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
        	//prompt('gcds_print.dataid',gcds_print.dataid );
        	gcds_print.reset();
        	
        	//3page
        	gcds_print3.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142_3&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
        	gcds_print3.reset();
        	
        	
        	//4page        	
        	gcds_print4.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142_4&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
        	gcds_print4.reset();
        	
        	gcds_print4_1.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142_4_1&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
        	gcds_print4_1.reset();
        	
        	gcds_print4_2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142_4_2&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
        	gcds_print4_2.reset();
        	
        	gcds_print4_3.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142_4_3&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
        	gcds_print4_3.reset();
        	
        	gcds_print4_4.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142_4_4&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
        	gcds_print4_4.reset();
        	
        	
        	gcrp_print.Preview();

        }

        
        



        function gf_setnum2(src){ 
          
          if(src==""){
        		return 0;
        	}

        	//alert("src"+src);

        	var arrParam	= new Array();
        	var buf_all  = "";
        	var buf_comma  = "";
        	var len	= 0;
        	var comma = 0;
        	var buf  = "";
        	var dest = "";

        	buf_all = "" + src + "";
        	arrParam = buf_all.split(".");
          
          buf = arrParam[0];
          
        	if (arrParam.length>1){
        		buf_comma = arrParam[1];
        	}else{
            buf_comma="";
        	}
          
        	
        	buf = "" + buf + "";
        	len = buf.length;
        	
        	for(i = 3; i < len; i+=3) {
        		if((i < len) || (len < (i+4)))	comma++;
        	}
        	
        	for(i = 0; i < len; i++) {
        		if(i == (len - (3 * comma))) {
        			dest += ",";
        			dest += buf.charAt(i);
        			comma--;
        		}
        		else {
        			dest += buf.charAt(i);
        		}
        	}

        	if (dest.substring(0,1)=="-") {
        		if (dest.substring(1,2)==",") {
        			dest = dest.substring(0,1) + dest.substring(2,dest.length);
        		}
        	}

        	if(buf_comma!=""){
            dest=dest+"."+buf_comma;
        	}

        	return dest;
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        /********************************************
         * 기타 함수              *
         ********************************************/
         var oFieldList = new Array("TAX_INCOME"
							        		,"MGR_AMT"
							        		,"MNI_AMT"
							        		,"BADD_AMT"
							        		,"SPSB_AMT"
							        		,"GDED_AMT"
							        		,"GOL_AMT70"
							        		,"TBL_DED"
							        		,"WDD_AMT"
							        		,"OTX_DED"
							        		,"NPEN_DED"
							        		,"ETC_DED"
							        		,"HIN_DED"							        		
							        		,"LOAN_DED"
							        		,"LONG_DED"
							        		,"DON_FWD"
							        		,"VEN_DED"
							        		,"INDED_TOT"
							        		,"PER_DED"
							        		,"SAVE_DED"
							        		,"CARD_DED"
							        		,"SAJU_DED"
							        		,"LSS_DED"
							        		,"INDED_EXC"
							        		,"TTAX_STD"
							        		,"TAX_AMT"
							        		,"HGR_DED"
							        		,"AGE_AMT"
							        		,"AGE_RCH"
							        		,"AGE_INP"							        		
							        		,"ANN_DED"
							        		,"MIN_DED"
							        		,"MMA_DED"
							        		,"EDU_DED"
							        		,"GOV_DED"
							        		,"GOV2_DED"								        		
							        		,"LC1_DED"
							        		,"LC23_DED"								        		
							        		,"CPC_DED"
							        		,"NSE_TOT"
							        		,"STA_TOT"
							        		,"MRENT_DED"
							        		,"TDED_TOT"
							        		,"DGG_TAX"
							        		,"DJM_TAX"
							        		,"DBW_TAX"
							        		,"DGG_SUM"
							        		,"AGG_TAX"
							        		,"AJM_TAX"
							        		,"CONT_TAX"
							        		,"AGG_SUM"
							        		,"DRE_INTX"
							        		,"DRE_CTTX"
							        		,"DRE_DFTX"
							        		,"RESULT"
											,"REA_TAX"
											,"REB_TAX"
											,"REC_TAX"
											,"RED_TAX"
											,"CEA_TAX"
											,"CEB_TAX"
											,"CEC_TAX"
											,"CED_TAX");        
        
		var oElementList = new Array("txtTAX_INCOME"
								        		,"txtMGR_AMT"
								        		,"txtMNI_AMT"
								        		,"txtBADD_AMT"
								        		,"txtSPSB_AMT"
								        		,"txtGDED_AMT"
								        		,"txtGOL_AMT70"
								        		,"txtTBL_DED"
								        		,"txtWDD_AMT"
								        		,"txtOTX_DED"
								        		,"txtNPEN_DED"
								        		,"txtETC_DED"
								        		,"txtHIN_DED"										        		
								        		,"txtLOAN_DED"
								        		,"txtLONG_DED"
								        		,"txtDON_FWD"								        		
								        		,"txtVEN_DED"
								        		,"txtINDED_TOT"
								        		,"txtPER_DED"
								        		,"txtSAVE_DED"
								        		,"txtCARD_DED"
								        		,"txtSAJU_DED"
								        		,"txtLSS_DED"
								        		,"txtINDED_EXC"								        		
								        		,"txtTTAX_STD"
								        		,"txtTAX_AMT"
								        		,"txtHGR_DED"
								        		,"txtAGE_AMT"
								        		,"txtAGE_RCH"
								        		,"txtAGE_INP"								        		
								        		,"txtANN_DED"
								        		,"txtMIN_DED"
								        		,"txtMMA_DED"
								        		,"txtEDU_DED"
								        		,"txtGOV_DED"
								        		,"txtGOV2_DED"								        		
								        		,"txtLC1_DED"
								        		,"txtLC23_DED"								        		
								        		,"txtCPC_DED"
								        		,"txtNSE_TOT"
								        		,"txtSTA_TOT"
								        		,"txtMRENT_DED"
								        		,"txtTDED_TOT"
								        		,"txtDGG_TAX"
								        		,"txtDJM_TAX"
								        		,"txtDBW_TAX"
								        		,"txtDGG_SUM"
								        		,"txtAGG_TAX"
								        		,"txtAJM_TAX"
								        		,"txtCONT_TAX"
								        		,"txtAGG_SUM"
								        		,"txtDRE_INTX"
								        		,"txtDRE_CTTX"
								        		,"txtDRE_DFTX"
								        		,"txtRESULT"
												,"txtREA_TAX"
												,"txtREB_TAX"
												,"txtREC_TAX"
												,"txtRED_TAX"		
												,"txtCEA_TAX"
												,"txtCEB_TAX"
												,"txtCEC_TAX"
												,"txtCED_TAX");
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->
<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)           |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
	<Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>
    
    
    
     <!-----------------------------------------------------+
    | 1. 리포트용 DataSet                                       |
    +------------------------------------------------------>
    <Object ID="gcds_print" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>
    
    <Object ID="gcds_print3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>
    
     <Object ID="gcds_print4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>
    
     <Object ID="gcds_print4_1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>
    
     <Object ID="gcds_print4_2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>
     <Object ID="gcds_print4_3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>
     <Object ID="gcds_print4_4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
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
	//		alert("검색하신 조건의 자료가 없습니다!");
		} else {
			

			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);

            //for(var i =0; i<oFieldList.length; i++) {

            //     document.getElementById(oElementList[i]).value = formatNumber(dsT_AC_RETACC.NameString(1, oFieldList[i]));
    			//alert(oFieldList[i]);
            //}
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
    
    <script language=JavaScript for=gcds_print4 event=OnLoadCompleted(rowcnt)>
    //alert("onLoadCompleted:" + rowcnt );
	</script>
    
    
    <script language=JavaScript for=gcds_print4 event=OnLoadError()>

		alert("onLoadError");
	</script>
	    
    
    <script language=JavaScript for=gcrp_print event=OnError()>
		alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);
	</script>
    


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">연말정산결과조회_2</td>
                    <td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">연말정산결과조회_2</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
            <td height="30" class="paddingTop5" align="right">
               
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif"   name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="200"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <td class="searchState" align="right">귀속년도&nbsp;</td>
                                    <td class="padding2423" align="left">
                                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                        			<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>                                                
                                            </tr>
                                        </table>
                                    </td>

                                    <td align="right" class="searchState">사&nbsp;&nbsp;&nbsp;번&nbsp;</td>
                                    <td class="padding2423">
										<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
										<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();">						
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
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    		<td class="paddingTop8">

    		</td>
    	</tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->


    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="520" valign="top" style="padding-right:5px">

                <!-- 첫번째 테이블 -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="70"></col>
                        <col width="180"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">과세대상급여</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtTAX_INCOME classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtTAX_INCOME" id="txtTAX_INCOME" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly>  -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">근로소득공제</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtMGR_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtMGR_AMT" id="txtMGR_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">과세대상근로소득금액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtMNI_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtMNI_AMT" id="txtMNI_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" rowspan="3">기본공제</td>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">본인</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtBADD_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                         
                            <!-- <input type="text" name="txtBADD_AMT" id="txtBADD_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">배우자</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtSPSB_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                         
                            <!-- <input type="text" name="txtSPSB_AMT" id="txtSPSB_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">부양가족</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtGDED_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                         
                            <!-- <input type="text" name="txtGDED_AMT" id="txtGDED_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" rowspan="4">추가공제</td>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">경로우대(70세)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtGOL_AMT70 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtGOL_AMT70" id="txtGOL_AMT70" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">장애인</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtTBL_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtTBL_DED" id="txtTBL_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">부녀자</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtWDD_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtWDD_AMT" id="txtWDD_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">한부모공제</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtOTX_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtOTX_DED" id="txtOTX_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>  

                    <tr>
                        <td class="blueBold" align="center" rowspan="2">연금보험료</td>                    
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">국민연금보험료</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtNPEN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtNPEN_DED" id="txtNPEN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">기타연금보험료</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtETC_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                
                            <!-- <input type="text" name="txtETC_DED" id="txtETC_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    

                    <tr>
                        <td class="blueBold" align="center" rowspan="5">특별공제</td>
                        <td class="blueBold" align="left" style="padding-left:10px">보험료</td>
                        <td class="blueBold" align="left" style="padding-left:10px">건강,고용보험료등</td>                        
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtHIN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                
                            <!-- <input type="text" name="txtHIN_DED" id="txtHIN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" rowspan="2">주택자금</td>
                        <td class="blueBold" align="left" style="padding-left:10px">주택임차차입금 원리금상환액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtLOAN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtLOAN_DED" id="txtLOAN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px">장기주택저당차입금 이자상환액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtLONG_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtLONG_DED" id="txtLONG_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px">기부금</td>
                        <td class="blueBold" align="left" style="padding-left:10px">이월분</td>                        
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtDON_FWD classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtDON_FWD" id="txtDON_FWD" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px"  colspan="2">합계(특별공제)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtVEN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtVEN_DED" id="txtVEN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" colspan="3">차감소득금액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtINDED_TOT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtINDED_TOT" id="txtINDED_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                      <td class="blueBold" align="center" rowspan="5">그밖의<br>소득공제</td>                    
                        <td class="blueBold" align="center" colspan="2">개인연금저축</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtPER_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                              
                            <!-- <input type="text" name="txtPER_DED" id="txtPER_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="2">주택마련저축</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtSAVE_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                              
                            <!-- <input type="text" name="txtSAVE_DED" id="txtSAVE_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="2">신용카드사용</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCARD_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtCARD_DED" id="txtCARD_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="center" colspan="2">우리사주출연금소득공제</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtSAJU_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtSAJU_DED" id="txtSAJU_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    
                    
                    <tr>
                        <td class="blueBold" align="center" colspan="2">장기집합투자증권저축</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtLSS_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtLSS_DED" id="txtLSS_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" colspan="3">소득공제 종합한도 초과액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtINDED_EXC" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtINDED_EXC" id="txtINDED_EXC" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>  

                </table>
                <!-- 첫번째 테이블 -->

            </td>
            <td valign="top">

                <!-- 두번째 테이블 -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="70"></col>                        
                        <col width="180"></col>
                        <col width="*"></col>
                    </colgroup>

                  
                    
                    <tr>
                        <td class="blueBold" align="center" colspan="3">종합소득과세표준</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtTTAX_STD" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtTTAX_STD" id="txtTTAX_STD" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">산출세액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtTAX_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtTAX_AMT" id="txtTAX_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" rowspan="17">세액공제</td>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">근로소득세액공제</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtHGR_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtHGR_DED" id="txtHGR_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" rowspan="3">자녀</td>                      
                        <td class="blueBold" align="left" style="padding-left:10px">자녀</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtAGE_AMT" id="txtAGE_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>                    
                        <td class="blueBold" align="left" style="padding-left:10px">6세이하</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGE_RCH" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtAGE_AMT" id="txtAGE_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    
                    <tr>                    
                        <td class="blueBold" align="left" style="padding-left:10px">출생ㆍ입양</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGE_INP" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtAGE_AMT" id="txtAGE_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">연금계좌</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtANN_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtANN_DED" id="txtANN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                                        
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" rowspan="10">&nbsp;&nbsp;특별<br>세액공제</td>                    
                        <td class="blueBold" align="left" style="padding-left:10px" >보장성보험료</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtMIN_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                            <!-- <input type="text" name="txtMIN_DED" id="txtMIN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >의료비</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtMMA_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                            <!-- <input type="text" name="txtMMA_DED" id="txtMMA_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >교육비</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtEDU_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                            <!-- <input type="text" name="txtEDU_DED" id="txtEDU_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>  
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >정치자금기부금 (10만 이하)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtGOV_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtGOV_DED" id="txtGOV_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                                      
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >정치자금기부금 (10만 초과)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtGOV2_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtGOV2_DED" id="txtGOV2_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >법정기부금</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtLC1_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtLC1_DED" id="txtLC1_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >지정기부금</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtLC23_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtLC23_DED" id="txtLC23_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>  
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >기부금세액공제계</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCPC_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtCPC_DED" id="txtCPC_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                                      
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >특별세액공제계</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtNSE_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtNSE_TOT" id="txtNSE_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >표준세액공제</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtSTA_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtSTA_TOT" id="txtSTA_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">월세액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtMRENT_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtMRENT_DED" id="txtMRENT_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr> 
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">세액공제계</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtTDED_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtTDED_TOT" id="txtTDED_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                      
                                       
                </table>
                <!-- 두번째 테이블 -->

                

                <!-- 세번째 테이블 -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="100"></col>
                        <col width="100"></col>
                        <col width="100"></col>
                        <col width="100"></col>                                              
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="blueBold" align="center"></td>
                        <td class="blueBold" align="center">소득세</td>
                        <td class="blueBold" align="center">주민세</td>
                        <td class="blueBold" align="center">농특세</td>                        
                        <td class="blueBold" align="center">계</td>
                     
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">결정세액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDGG_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDGG_TAX" id="txtDGG_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDJM_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDJM_TAX" id="txtDJM_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDBW_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDBW_TAX" id="txtDBW_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDGG_SUM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDGG_SUM" id="txtDGG_SUM" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>                        
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">기납부액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGG_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtAGG_TAX" id="txtAGG_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAJM_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtAJM_TAX" id="txtAJM_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCONT_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtCONT_TAX" id="txtCONT_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGG_SUM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtAGG_SUM" id="txtAGG_SUM" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>                        
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">기환급세액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDRE_INTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                         <!--    <input type="text" name="txtDRE_INTX" id="txtDRE_INTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDRE_CTTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_CTTX" id="txtDRE_CTTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDRE_DFTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_DFTX" id="txtDRE_DFTX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly > -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtRESULT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>	
									<param name=ReadOnly  			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                            <!-- <input type="text" name="txtRESULT" id="txtRESULT" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid; color:red; IsComma:true" readonly >  -->
                        </td>                        
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">재정산세액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtREA_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                         <!--    <input type="text" name="txtDRE_INTX" id="txtDRE_INTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtREB_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_CTTX" id="txtDRE_CTTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtREC_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_DFTX" id="txtDRE_DFTX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly > -->
                        </td>
                        <td class="padding2423" style="padding-left:10px" >
		                        <comment id="__NSID__"><object id="txtRED_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>	
									<param name=ReadOnly  			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                            <!-- <input type="text" name="txtRESULT" id="txtRESULT" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid; color:red; IsComma:true" readonly >  -->
                        </td>                                              
                    </tr>   
                    
                    <tr>
                        <td class="blueBold" align="center">차액</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCEA_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                         <!--    <input type="text" name="txtDRE_INTX" id="txtDRE_INTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCEB_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_CTTX" id="txtDRE_CTTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCEC_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_DFTX" id="txtDRE_DFTX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly > -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCED_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>	
									<param name=ReadOnly  			value=true>
									<param name=ReadOnlyBackColor   value="#ccffcc">									
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                            <!-- <input type="text" name="txtRESULT" id="txtRESULT" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid; color:red; IsComma:true" readonly >  -->
                        </td>                        
                    </tr>                                     
                </table>
                <!-- 세번째 테이블 -->

            </td>
        </tr>
    </table>


    </form>
    <!-- form 끝 -->


	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_PENSION 설정 테이블 -->
	<object id="bndT_AC_RETACC" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_RETACC">
		<Param Name="BindInfo", Value="
			<C>Col=TAX_INCOME			Ctrl=txtTAX_INCOME				Param=text </C>
			<C>Col=MGR_AMT				Ctrl=txtMGR_AMT					Param=text </C>
			<C>Col=MNI_AMT					Ctrl=txtMNI_AMT					Param=text </C>
			<C>Col=BADD_AMT				Ctrl=txtBADD_AMT				Param=text  </C>
			<C>Col=SPSB_AMT				Ctrl=txtSPSB_AMT					Param=text  </C>
			<C>Col=GDED_AMT				Ctrl=txtGDED_AMT				Param=text </C>
			<C>Col=GOL_AMT70				Ctrl=txtGOL_AMT70				Param=text </C>
			<C>Col=TBL_DED					Ctrl=txtTBL_DED					Param=text </C>
			<C>Col=WDD_AMT				Ctrl=txtWDD_AMT					Param=text </C>
			<C>Col=OTX_DED					Ctrl=txtOTX_DED					Param=text  </C>
			<C>Col=NPEN_DED				Ctrl=txtNPEN_DED					Param=text  </C>
			<C>Col=ETC_DED					Ctrl=txtETC_DED					Param=text </C>
			<C>Col=HIN_DED					Ctrl=txtHIN_DED					Param=text </C>
			<C>Col=LOAN_DED				Ctrl=txtLOAN_DED				Param=text </C>
			<C>Col=LONG_DED				Ctrl=txtLONG_DED				Param=text </C>
			<C>Col=DON_FWD				Ctrl=txtDON_FWD					Param=text </C>
			<C>Col=VEN_DED					Ctrl=txtVEN_DED					Param=text </C>
			<C>Col=INDED_TOT				Ctrl=txtINDED_TOT				Param=text </C>
			<C>Col=PER_DED					Ctrl=txtPER_DED					Param=text  </C>
			<C>Col=SAVE_DED				Ctrl=txtSAVE_DED					Param=text  </C>
			<C>Col=CARD_DED				Ctrl=txtCARD_DED				Param=text </C>
			<C>Col=SAJU_DED				Ctrl=txtSAJU_DED					Param=text </C>
			<C>Col=LSS_DED					Ctrl=txtLSS_DED					Param=text </C>
			<C>Col=INDED_EXC				Ctrl=txtINDED_EXC				Param=text </C>
			<C>Col=TTAX_STD				Ctrl=txtTTAX_STD				Param=text  </C>
			<C>Col=TAX_AMT					Ctrl=txtTAX_AMT					Param=text  </C>
			<C>Col=HGR_DED					Ctrl=txtHGR_DED					Param=text </C>
			<C>Col=AGE_AMT					Ctrl=txtAGE_AMT					Param=text </C>
			<C>Col=AGE_RCH					Ctrl=txtAGE_RCH					Param=text </C>
			<C>Col=AGE_INP					Ctrl=txtAGE_INP					Param=text </C>						
			<C>Col=ANN_DED					Ctrl=txtANN_DED					Param=text </C>
			<C>Col=MIN_DED					Ctrl=txtMIN_DED					Param=text </C>
			<C>Col=MMA_DED				Ctrl=txtMMA_DED					Param=text </C>
			<C>Col=EDU_DED					Ctrl=txtEDU_DED					Param=text </C>
			<C>Col=GOV_DED					Ctrl=txtGOV_DED					Param=text </C>
			<C>Col=GOV2_DED				Ctrl=txtGOV2_DED				Param=text  </C>
			<C>Col=LC1_DED					Ctrl=txtLC1_DED					Param=text  </C>
			<C>Col=LC23_DED				Ctrl=txtLC23_DED					Param=text </C>
			<C>Col=CPC_DED					Ctrl=txtCPC_DED					Param=text </C>
			<C>Col=NSE_TOT					Ctrl=txtNSE_TOT					Param=text </C>
			<C>Col=STA_TOT					Ctrl=txtSTA_TOT					Param=text </C>
			<C>Col=MRENT_DED				Ctrl=txtMRENT_DED				Param=text  </C>
			<C>Col=TDED_TOT				Ctrl=txtTDED_TOT				Param=text  </C>
			<C>Col=DGG_TAX					Ctrl=txtDGG_TAX					Param=text </C>
			<C>Col=DJM_TAX					Ctrl=txtDJM_TAX					Param=text </C>
			<C>Col=DBW_TAX					Ctrl=txtDBW_TAX					Param=text </C>
			<C>Col=DGG_SUM					Ctrl=txtDGG_SUM					Param=text </C>
			<C>Col=AGG_TAX					Ctrl=txtAGG_TAX					Param=text </C>
			<C>Col=AJM_TAX					Ctrl=txtAJM_TAX					Param=text </C>
			<C>Col=CONT_TAX				Ctrl=txtCONT_TAX				Param=text </C>
			<C>Col=AGG_SUM					Ctrl=txtAGG_SUM					Param=text  </C>
			<C>Col=DRE_INTX				Ctrl=txtDRE_INTX					Param=text  </C>
			<C>Col=DRE_CTTX				Ctrl=txtDRE_CTTX				Param=text </C>
			<C>Col=DRE_DFTX				Ctrl=txtDRE_DFTX				Param=text </C>
			<C>Col=RESULT					Ctrl=txtRESULT					Param=text </C>
			<C>Col=REA_TAX					Ctrl=txtREA_TAX					Param=text  </C>
			<C>Col=REB_TAX					Ctrl=txtREB_TAX					Param=text </C>
			<C>Col=REC_TAX					Ctrl=txtREC_TAX					Param=text </C>
			<C>Col=RED_TAX					Ctrl=txtRED_TAX					Param=text </C>		
			<C>Col=CEA_TAX					Ctrl=txtCEA_TAX					Param=text  </C>
			<C>Col=CEB_TAX					Ctrl=txtCEB_TAX					Param=text </C>
			<C>Col=CEC_TAX					Ctrl=txtCEC_TAX					Param=text </C>
			<C>Col=CED_TAX					Ctrl=txtCED_TAX					Param=text </C>						
       ">
	</object>


    <!-----------------------------------------------------------------------------
			R E P O R T   C O M P O N E N T S   D E F I N I T I O N
------------------------------------------------------------------------------>
<object  ID="gcrp_print" CLASSID="CLSID:CC26E2A9-760B-4EA6-8DDF-DB423FD24089" >  
 
	<PARAM NAME="MasterDataID"		VALUE="gcds_print">  
	<PARAM NAME="DetailDataID"		VALUE="gcds_print">
    <param name="PaperSize"         value="A4">
    <param name="Landscape"         value="false">
    <param name="NullRecordFlag"    value="true">
    <param name="PrintSetupDlgFlag" value="true">
    <param name="PreviewZoom"       value="120">
    <param name="Format"            value=" 
    
    <A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='1.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print' 
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2741 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=101 ,top=185 ,right=482 ,bottom=275 ,border=true</X>
		<L> left=64 ,top=159 ,right=66 ,bottom=2696 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(제1쪽)' ,left=1725 ,top=90 ,right=1881 ,bottom=151 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='[별지 제24호 서식(1)]  ' ,left=64 ,top=90 ,right=1471 ,bottom=151 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=64 ,top=156 ,right=1886 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<X>left=585 ,top=243 ,right=614 ,bottom=278 ,border=true</X>
		<X>left=585 ,top=193 ,right=614 ,bottom=228 ,border=true</X>
		<T>id='관리' ,left=106 ,top=191 ,right=220 ,bottom=230 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=228 ,top=185 ,right=228 ,bottom=275 </L>
		<L> left=64 ,top=672 ,right=1886 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='', left=1016, top=915, right=1114, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=873, top=915, right=971, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1381, top=857, right=1479, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1381, top=915, right=1479, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1521, top=857, right=1619, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1521, top=915, right=1619, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_INCOME,0,,TAX_INCOME)}', left=630, top=976, right=855, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1638, top=857, right=1730, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1773, top=857, right=1863, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1638, top=915, right=1730, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1773, top=915, right=1863, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1130, top=915, right=1222, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1257, top=915, right=1355, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAS_NM3', left=1392, top=741, right=1614, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1320, right=855, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1320, right=1106, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1320, right=1365, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1320, right=1614, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1320, right=1873, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1265, right=855, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1265, right=1106, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1265, right=1365, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1265, right=1614, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1265, right=1873, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1204, right=855, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1204, right=1106, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1204, right=1365, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1204, right=1614, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1204, right=1873, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1148, right=855, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1148, right=1106, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1148, right=1365, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1148, right=1614, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1148, right=1873, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=127 ,top=733 ,right=1886 ,bottom=733 </L>
		<L> left=127 ,top=791 ,right=1886 ,bottom=791 </L>
		<L> left=127 ,top=852 ,right=1886 ,bottom=852 </L>
		<L> left=127 ,top=908 ,right=1886 ,bottom=908 </L>
		<L> left=127 ,top=1371 ,right=1886 ,bottom=1371 </L>
		<L> left=127 ,top=1315 ,right=1886 ,bottom=1315 </L>
		<L> left=127 ,top=1257 ,right=1886 ,bottom=1257 </L>
		<L> left=127 ,top=1201 ,right=1886 ,bottom=1201 </L>
		<L> left=127 ,top=1143 ,right=1886 ,bottom=1143 </L>
		<L> left=127 ,top=1082 ,right=1886 ,bottom=1082 </L>
		<L> left=127 ,top=1027 ,right=1886 ,bottom=1027 </L>
		<L> left=127 ,top=968 ,right=1886 ,bottom=968 </L>
		<L> left=124 ,top=672 ,right=124 ,bottom=2516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='STR', left=624, top=857, right=741, bottom=902, face='Arial Narrow', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAS_NM2', left=1124, top=741, right=1371, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id=' ~' ,left=730 ,top=857 ,right=759 ,bottom=902 ,face='Arial' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='END', left=757, top=857, right=863, bottom=902, face='Arial Narrow', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=64 ,top=1431 ,right=1886 ,bottom=1431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='', left=884, top=1439, right=1106, bottom=1484, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='16)-1납세조합' ,left=1394 ,top=683 ,right=1617 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ⅰ' ,left=71 ,top=868 ,right=124 ,bottom=908 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='근' ,left=71 ,top=915 ,right=124 ,bottom=955 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='무' ,left=71 ,top=960 ,right=124 ,bottom=1000 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='처' ,left=71 ,top=1003 ,right=124 ,bottom=1042 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='별' ,left=71 ,top=1045 ,right=124 ,bottom=1085 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=71 ,top=1087 ,right=124 ,bottom=1124 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=71 ,top=1132 ,right=124 ,bottom=1169 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=71 ,top=1175 ,right=124 ,bottom=1212 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=71 ,top=1220 ,right=124 ,bottom=1257 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='근로소득원천징수영수증' ,left=624 ,top=193 ,right=1244 ,bottom=241 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='근로소득 지급명세서' ,left=624 ,top=243 ,right=1244 ,bottom=288 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=161 ,right=1865 ,bottom=161 </L>
		<T>id='번호' ,left=106 ,top=235 ,right=220 ,bottom=273 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2014 -' ,left=230 ,top=191 ,right=333 ,bottom=270 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='HTITLE', left=683, top=310, right=1101, bottom=352, face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1328 ,top=161 ,right=1328 ,bottom=405 </L>
		<T>id='거주구분' ,left=1331 ,top=164 ,right=1543 ,bottom=198 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=198 ,right=1865 ,bottom=198 </L>
		<T>id='외국인단일세율적용' ,left=1331 ,top=267 ,right=1601 ,bottom=302 ,align='left' ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=233 ,right=1865 ,bottom=233 </L>
		<L> left=1328 ,top=265 ,right=1865 ,bottom=265 </L>
		<T>id='국적' ,left=1331 ,top=302 ,right=1450 ,bottom=336 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=299 ,right=1865 ,bottom=299 </L>
		<L> left=1331 ,top=333 ,right=1868 ,bottom=333 </L>
		<L> left=1331 ,top=370 ,right=1868 ,bottom=370 </L>
		<L> left=1328 ,top=405 ,right=1865 ,bottom=405 </L>
		<L> left=1865 ,top=161 ,right=1865 ,bottom=405 </L>
		<L> left=64 ,top=410 ,right=1886 ,bottom=410 </L>
		<L> left=1545 ,top=161 ,right=1545 ,bottom=267 </L>
		<L> left=1765 ,top=198 ,right=1765 ,bottom=233 </L>
		<L> left=1453 ,top=198 ,right=1453 ,bottom=233 </L>
		<L> left=1453 ,top=302 ,right=1453 ,bottom=336 </L>
		<L> left=1603 ,top=265 ,right=1603 ,bottom=299 </L>
		<L> left=1765 ,top=299 ,right=1765 ,bottom=333 </L>
		<L> left=249 ,top=410 ,right=249 ,bottom=672 </L>
		<L> left=249 ,top=460 ,right=1886 ,bottom=460 </L>
		<T>id='(1)법 인 명 (상 호)' ,left=254 ,top=415 ,right=540 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='현대아산(주)' ,left=627 ,top=415 ,right=918 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(2)대 표 자 (성     명)' ,left=1040 ,top=415 ,right=1384 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='조 건 식' ,left=1410 ,top=415 ,right=1730 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(3)사업자등록번호' ,left=251 ,top=466 ,right=537 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='140111-0011714' ,left=1408 ,top=466 ,right=1728 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(4)주 민 등 록 번 호' ,left=1037 ,top=466 ,right=1381 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='221-81-13834' ,left=627 ,top=466 ,right=918 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=249 ,top=511 ,right=1886 ,bottom=511 </L>
		<T>id='(5)소 재 지 (주소)' ,left=254 ,top=516 ,right=540 ,bottom=561 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=64 ,top=564 ,right=1886 ,bottom=564 </L>
		<T>id='(6)성명' ,left=254 ,top=569 ,right=540 ,bottom=614 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=249 ,top=616 ,right=1886 ,bottom=616 </L>
		<T>id='(8)주소' ,left=254 ,top=622 ,right=540 ,bottom=667 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ENO_NM', left=627, top=569, right=918, bottom=614, align='left', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(7)주 민 등 록  번 호' ,left=1037 ,top=569 ,right=1381 ,bottom=614 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='CET_NO', left=1410, top=569, right=1844, bottom=614, align='left' ,mask='XXXXXX-XXXXXXX', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1029 ,top=410 ,right=1029 ,bottom=511 </L>
		<L> left=1400 ,top=410 ,right=1400 ,bottom=511 </L>
		<C>id='ADDRESS_HOME', left=627, top=622, right=1852, bottom=667, align='left', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1400 ,top=564 ,right=1400 ,bottom=616 </L>
		<T>id='징   수' ,left=71 ,top=450 ,right=243 ,bottom=495 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='의무자' ,left=71 ,top=495 ,right=243 ,bottom=540 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소득자' ,left=71 ,top=574 ,right=243 ,bottom=661 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='구   분' ,left=130 ,top=683 ,right=601 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(10)사업자등록번호' ,left=130 ,top=802 ,right=601 ,bottom=847 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(11)근무기간' ,left=130 ,top=860 ,right=601 ,bottom=905 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(12)감면기간' ,left=130 ,top=918 ,right=601 ,bottom=963 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(13)급               여' ,left=130 ,top=979 ,right=601 ,bottom=1024 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(14)상               여' ,left=130 ,top=1035 ,right=601 ,bottom=1080 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)인   정   상   여' ,left=130 ,top=1093 ,right=601 ,bottom=1135 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)-1주식매수선택권 행사이익' ,left=130 ,top=1151 ,right=601 ,bottom=1193 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)-2우리사주조합인출금' ,left=130 ,top=1209 ,right=601 ,bottom=1251 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)-3임원 퇴직소득금액 한도초과액' ,left=130 ,top=1265 ,right=601 ,bottom=1310 ,align='left' ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='15)-4' ,left=130 ,top=1320 ,right=601 ,bottom=1365 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='16)계' ,left=130 ,top=1378 ,right=601 ,bottom=1423 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='종(전)' ,left=886 ,top=683 ,right=1109 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='종(전)' ,left=1143 ,top=683 ,right=1368 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='합  계' ,left=1635 ,top=683 ,right=1876 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1886 ,top=156 ,right=1886 ,bottom=2693 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=127 ,top=2426 ,right=1886 ,bottom=2426 </L>
		<T>id='(76)주(현)근무지' ,left=230 ,top=2379 ,right=553 ,bottom=2424 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=228 ,top=2373 ,right=1886 ,bottom=2373 </L>
		<L> left=127 ,top=2230 ,right=1886 ,bottom=2230 </L>
		<T>id='기납부' ,left=130 ,top=2289 ,right=222 ,bottom=2320 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세   액' ,left=130 ,top=2320 ,right=220 ,bottom=2352 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(74)결     정     세     액' ,left=127 ,top=2183 ,right=609 ,bottom=2228 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=122 ,top=2178 ,right=1881 ,bottom=2178 </L>
		<L> left=699 ,top=2230 ,right=699 ,bottom=2371 </L>
		<L> left=532 ,top=2233 ,right=532 ,bottom=2373 </L>
		<L> left=64 ,top=2125 ,right=1886 ,bottom=2125 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(75)종(전)근무지' ,left=257 ,top=2249 ,right=511 ,bottom=2283 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(결정세액란의' ,left=257 ,top=2286 ,right=511 ,bottom=2320 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  세액 기재)' ,left=257 ,top=2323 ,right=511 ,bottom=2357 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=2389 ,right=122 ,bottom=2426 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=69 ,top=2334 ,right=122 ,bottom=2371 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=69 ,top=2278 ,right=122 ,bottom=2318 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=2225 ,right=122 ,bottom=2262 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ⅲ' ,left=69 ,top=2172 ,right=122 ,bottom=2212 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(18) 국외근로' ,left=135 ,top=1442 ,right=434 ,bottom=1487 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1495 ,right=1886 ,bottom=1495 </L>
		<T>id='(18)-1 야간근로수당' ,left=135 ,top=1505 ,right=434 ,bottom=1550 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1558 ,right=1886 ,bottom=1558 </L>
		<T>id='(18)-2 출산보육수당' ,left=132 ,top=1572 ,right=431 ,bottom=1617 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1625 ,right=1886 ,bottom=1625 </L>
		<T>id='(18)-4 연구보조비' ,left=135 ,top=1635 ,right=434 ,bottom=1680 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1688 ,right=1886 ,bottom=1688 </L>
		<T>id='(18)-5' ,left=135 ,top=1699 ,right=434 ,bottom=1744 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1752 ,right=1886 ,bottom=1752 </L>
		<T>id='(18)-6' ,left=135 ,top=1762 ,right=434 ,bottom=1804 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=119 ,top=1812 ,right=1879 ,bottom=1812 </L>
		<T>id='~' ,left=135 ,top=1823 ,right=434 ,bottom=1865 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1871 ,right=1886 ,bottom=1871 </L>
		<T>id='(18)-(25)' ,left=135 ,top=1881 ,right=434 ,bottom=1926 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1931 ,right=1886 ,bottom=1931 </L>
		<T>id='(19)수련보조수당' ,left=135 ,top=1942 ,right=434 ,bottom=1987 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1998 ,right=1886 ,bottom=1998 </L>
		<T>id='(20)비과세소득 계' ,left=132 ,top=2008 ,right=603 ,bottom=2053 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=2061 ,right=1886 ,bottom=2061 </L>
		<T>id='(20)-1감면소득 계' ,left=130 ,top=2072 ,right=601 ,bottom=2117 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='M0X' ,left=442 ,top=1442 ,right=611 ,bottom=1487 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='O0X' ,left=442 ,top=1505 ,right=611 ,bottom=1550 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Q0X' ,left=442 ,top=1572 ,right=611 ,bottom=1617 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='H0X' ,left=442 ,top=1635 ,right=611 ,bottom=1680 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='', left=1140, top=1442, right=1365, bottom=1487, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1442, right=1614, bottom=1487, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1505, right=1873, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1505, right=1614, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1505, right=1365, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1505, right=1106, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1505, right=855, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1572, right=855, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1572, right=1106, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1572, right=1365, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1572, right=1614, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1572, right=1873, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1635, right=855, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=878, top=1635, right=1103, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1138, top=1635, right=1363, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1386, top=1635, right=1611, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1630, top=1635, right=1871, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1699, right=855, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1699, right=1106, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1699, right=1365, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1699, right=1614, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1699, right=1873, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1762, right=855, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1762, right=1106, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1762, right=1365, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1762, right=1614, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1762, right=1873, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=865 ,top=672 ,right=865 ,bottom=2125 </L>
		<L> left=1122 ,top=672 ,right=1122 ,bottom=2125 </L>
		<L> left=1373 ,top=672 ,right=1373 ,bottom=2125 </L>
		<L> left=1625 ,top=672 ,right=1625 ,bottom=2125 </L>
		<T>id='강원도 고성군 현내면 화진포서길 10' ,left=627 ,top=516 ,right=1852 ,bottom=561 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=437 ,top=1431 ,right=437 ,bottom=2000 </L>
		<T>id='비' ,left=69 ,top=1550 ,right=122 ,bottom=1590 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='과' ,left=69 ,top=1593 ,right=122 ,bottom=1632 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=1635 ,right=122 ,bottom=1675 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='및' ,left=69 ,top=1696 ,right=122 ,bottom=1736 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='감' ,left=69 ,top=1759 ,right=122 ,bottom=1812 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='면' ,left=69 ,top=1815 ,right=122 ,bottom=1855 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=69 ,top=1857 ,right=122 ,bottom=1897 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=69 ,top=1900 ,right=122 ,bottom=1939 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ⅱ' ,left=69 ,top=1500 ,right=122 ,bottom=1540 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=69 ,top=1961 ,right=122 ,bottom=2000 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=2003 ,right=122 ,bottom=2043 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=942 ,top=2125 ,right=942 ,bottom=2519 </L>
		<T>id='구          분' ,left=130 ,top=2130 ,right=931 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소득세' ,left=947 ,top=2130 ,right=1254 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='지방소득세' ,left=1262 ,top=2130 ,right=1569 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='농어촌특별세' ,left=1577 ,top=2130 ,right=1884 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='{decode(DGG_TAX,0,,DGG_TAX)}', left=947, top=2183, right=1254, bottom=2228, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=699 ,top=2326 ,right=1886 ,bottom=2326 </L>
		<L> left=622 ,top=418 ,right=622 ,bottom=2127 </L>
		<T>id='거주지국코드' ,left=1553 ,top=204 ,right=1759 ,bottom=233 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='거주지국' ,left=1331 ,top=204 ,right=1450 ,bottom=233 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='내·외국인' ,left=1331 ,top=235 ,right=1543 ,bottom=265 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='국적코드' ,left=1553 ,top=304 ,right=1762 ,bottom=333 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1545 ,top=302 ,right=1545 ,bottom=407 </L>
		<T>id='세대주여부' ,left=1331 ,top=339 ,right=1543 ,bottom=368 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연말정산구분' ,left=1331 ,top=373 ,right=1543 ,bottom=402 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1029 ,top=566 ,right=1029 ,bottom=616 </L>
		<L> left=64 ,top=2519 ,right=1886 ,bottom=2519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='위의 원천징수액(근로소득)을 정히 영수(지급)합니다.' ,left=122 ,top=2524 ,right=1707 ,bottom=2564 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(77)납부특례세액' ,left=124 ,top=2429 ,right=606 ,bottom=2474 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(78)차  감  징  수  세  액[(74)-(75)-(76)-(77)]' ,left=127 ,top=2471 ,right=926 ,bottom=2516 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=2469 ,right=1886 ,bottom=2469 </L>
		<L> left=1257 ,top=2125 ,right=1257 ,bottom=2519 </L>
		<L> left=1572 ,top=2125 ,right=1572 ,bottom=2519 </L>
		<L> left=225 ,top=2230 ,right=225 ,bottom=2426 </L>
		<T>id='건강보험:' ,left=98 ,top=296 ,right=254 ,bottom=336 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ENO_NO', left=336, top=191, right=474, bottom=270, face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='거주자①/비거주자2' ,left=1550 ,top=164 ,right=1860 ,bottom=198 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='TYPE', left=1553, top=235, right=1860, bottom=265, align='left', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='여1 / 부②' ,left=1611 ,top=267 ,right=1857 ,bottom=302 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='HOL_YN_1', left=1553, top=339, right=1860, bottom=368, align='left', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='계속근로① , 중도퇴사2' ,left=1553 ,top=370 ,right=1863 ,bottom=405 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='고용보험:' ,left=98 ,top=333 ,right=254 ,bottom=373 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='JAS_NM1', left=870, top=741, right=1119, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(9)근   무   처   명' ,left=130 ,top=741 ,right=601 ,bottom=786 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주(현)' ,left=632 ,top=683 ,right=857 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='COMP_NM', left=632, top=741, right=857, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='TAX_NO', left=632, top=802, right=857, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO1', left=870, top=802, right=1119, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO2', left=1124, top=802, right=1371, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO3', left=1392, top=802, right=1614, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAA_AMT1,0,,JAA_AMT1)}', left=884, top=976, right=1106, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAA_AMT2,0,,JAA_AMT2)}', left=1138, top=976, right=1360, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAA_AMT3,0,,JAA_AMT3)}', left=1392, top=976, right=1614, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAC_AMT1,0,,JAC_AMT1)}', left=884, top=1035, right=1106, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAC_AMT2,0,,JAC_AMT2)}', left=1138, top=1035, right=1360, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAC_AMT3,0,,JAC_AMT3)}', left=1392, top=1035, right=1614, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_INCOME,0,,TAX_INCOME)}', left=630, top=1381, right=855, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAE_AMT1,0,,JAE_AMT1)}', left=881, top=1381, right=1103, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAE_AMT2,0,,JAE_AMT2)}', left=1140, top=1381, right=1363, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAE_AMT3,0,,JAE_AMT3)}', left=1392, top=1381, right=1614, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM,0,,SUM)}', left=1632, top=1381, right=1873, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAI_AMT1,0,,JAI_AMT1)}', left=884, top=1093, right=1106, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAI_AMT2,0,,JAI_AMT2)}', left=1138, top=1093, right=1360, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAI_AMT3,0,,JAI_AMT3)}', left=1392, top=1093, right=1614, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAI_AMT,0,,SUM_JAI_AMT)}', left=1632, top=1093, right=1873, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(FREE_INCOME,0,,FREE_INCOME)}', left=630, top=2008, right=855, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAG_AMT3,0,,JAG_AMT3)}', left=1392, top=2008, right=1614, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAG_AMT2,0,,JAG_AMT2)}', left=1140, top=2008, right=1363, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAG_AMT1,0,,JAG_AMT1)}', left=881, top=2008, right=1103, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO1', left=706, top=2238, right=939, bottom=2278 ,mask='XXX-XX-XXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO2', left=706, top=2283, right=939, bottom=2323 ,mask='XXX-XX-XXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(REA_TAX,0,,REA_TAX)}', left=945, top=2471, right=1251, bottom=2516, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(REB_TAX,0,,REB_TAX)}', left=1259, top=2471, right=1566, bottom=2516, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(REC_TAXX,0,,REC_TAX)}', left=1574, top=2471, right=1881, bottom=2516, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CITI_TAX,0,,CITI_TAX)}', left=1259, top=2379, right=1566, bottom=2424, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(INCM_TAX,0,,INCM_TAX)}', left=945, top=2379, right=1251, bottom=2424, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAL_AMT2,0,,JAL_AMT2)}', left=945, top=2283, right=1251, bottom=2328, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAL_AMT1,0,,JAL_AMT1)}', left=945, top=2233, right=1251, bottom=2278, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAN_AMT1,0,,JAN_AMT1)}', left=1257, top=2233, right=1564, bottom=2278, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAN_AMT2,0,,JAN_AMT2)}', left=1259, top=2283, right=1566, bottom=2328, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAN_AMT2,0,,JAN_AMT2)}', left=1574, top=2283, right=1881, bottom=2328, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAM_AMT1,0,,JAM_AMT1)}', left=1572, top=2233, right=1879, bottom=2278, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DBW_TAX,0,,DBW_TAX)}', left=1574, top=2183, right=1881, bottom=2228, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DJM_TAX,0,,DJM_TAX)}', left=1259, top=2183, right=1566, bottom=2228, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINU,0,,SUM_HINU)}', left=257, top=296, right=482, bottom=336, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINS,0,,SUM_HINS)}', left=257, top=333, right=482, bottom=373, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAA_AMT,0,,SUM_JAA_AMT)}', left=1632, top=976, right=1873, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAC_AMT,0,,SUM_JAC_AMT)}', left=1632, top=1035, right=1873, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAG_AMT,0,,SUM_JAG_AMT)}', left=1632, top=2008, right=1873, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='210㎜x297㎜(일반용지 60g/㎡)' ,left=1241 ,top=2704 ,right=1881 ,bottom=2738 ,align='right' ,face='바탕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=64 ,top=2699 ,right=1886 ,bottom=2699 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(서명 또는 인)' ,left=1519 ,top=2617 ,right=1786 ,bottom=2651 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='현대아산(주)' ,left=1236 ,top=2617 ,right=1466 ,bottom=2651 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='징수(보고)의무자' ,left=796 ,top=2617 ,right=1151 ,bottom=2651 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='TAX_OFFICE', left=413, top=2641, right=487, bottom=2686, align='left', face='바탕', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='세무서장  귀하' ,left=492 ,top=2643 ,right=773 ,bottom=2686 ,align='left' ,face='바탕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='CURDT', left=720, top=2572, right=1130, bottom=2609 ,mask='XXXX년  XX월  XX일', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<I>id='../../images/common/asan_dojang.gif' ,left=1656 ,top=2524 ,right=1831 ,bottom=2699</I>
		<L> left=699 ,top=2278 ,right=1886 ,bottom=2278 </L>
		<T>id='사업자' ,left=566 ,top=2249 ,right=667 ,bottom=2283 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='등록' ,left=566 ,top=2286 ,right=667 ,bottom=2320 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='번호' ,left=566 ,top=2323 ,right=667 ,bottom=2357 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	</B>
	</R>
	</A>
	
	<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='2.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID='gcds_print' 
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
		<L> left=45 ,top=2651 ,right=1868 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=45 ,top=159 ,right=45 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(제2쪽)' ,left=1707 ,top=90 ,right=1863 ,bottom=151 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=45 ,top=156 ,right=1868 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1868 ,top=156 ,right=1868 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=106 ,top=156 ,right=106 ,bottom=2651 </L>
		<T>id='Ⅳ' ,left=56 ,top=1159 ,right=101 ,bottom=1201 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='정' ,left=56 ,top=1275 ,right=101 ,bottom=1312 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='산' ,left=56 ,top=1386 ,right=101 ,bottom=1423 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=56 ,top=1484 ,right=101 ,bottom=1521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=56 ,top=1606 ,right=101 ,bottom=1643 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1656 ,top=159 ,right=1656 ,bottom=2651 </L>
		<L> left=987 ,top=159 ,right=987 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=778 ,top=159 ,right=778 ,bottom=2651 </L>
		<T>id='[(16), 다만 외국인단일세율 적용시에는 ' ,left=291 ,top=161 ,right=743 ,bottom=201 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id=' 연간 근로소득)' ,left=291 ,top=198 ,right=743 ,bottom=238 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=238 ,right=1871 ,bottom=238 </L>
		<T>id='(21)총급여' ,left=114 ,top=180 ,right=275 ,bottom=217 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=1847 ,right=987 ,bottom=1847 </L>
		<T>id='(36)계' ,left=209 ,top=1804 ,right=524 ,bottom=1842 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=1794 ,right=987 ,bottom=1794 </L>
		<T>id='(35)기부금(이월분)' ,left=209 ,top=1749 ,right=524 ,bottom=1786 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=1738 ,right=987 ,bottom=1738 </L>
		<T>id='이자상환액' ,left=318 ,top=1598 ,right=463 ,bottom=1635 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='저당차입금' ,left=318 ,top=1564 ,right=463 ,bottom=1601 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='장기주택' ,left=318 ,top=1529 ,right=463 ,bottom=1566 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)' ,left=318 ,top=1495 ,right=463 ,bottom=1532 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2012년' ,left=482 ,top=1566 ,right=577 ,bottom=1603 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='고정금리/' ,left=614 ,top=1558 ,right=762 ,bottom=1595 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='비거치' ,left=614 ,top=1598 ,right=762 ,bottom=1635 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='상환대출' ,left=614 ,top=1640 ,right=762 ,bottom=1677 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=471 ,top=1548 ,right=987 ,bottom=1548 </L>
		<T>id='그 밖의 대출' ,left=611 ,top=1693 ,right=775 ,bottom=1730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=606 ,top=1683 ,right=987 ,bottom=1683 </L>
		<T>id='이전' ,left=489 ,top=1461 ,right=585 ,bottom=1498 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='30년 이상' ,left=614 ,top=1505 ,right=762 ,bottom=1543 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=606 ,top=1498 ,right=987 ,bottom=1498 </L>
		<L> left=606 ,top=1447 ,right=987 ,bottom=1447 </L>
		<T>id='15년~29년' ,left=614 ,top=1455 ,right=762 ,bottom=1492 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='15년 미만' ,left=614 ,top=1405 ,right=762 ,bottom=1442 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='차입분' ,left=489 ,top=1495 ,right=585 ,bottom=1532 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2011년' ,left=489 ,top=1426 ,right=585 ,bottom=1463 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='이후' ,left=482 ,top=1601 ,right=577 ,bottom=1638 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='차입분' ,left=482 ,top=1635 ,right=577 ,bottom=1672 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15년이상)' ,left=479 ,top=1670 ,right=603 ,bottom=1707 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=310 ,top=1394 ,right=990 ,bottom=1394 </L>
		<L> left=471 ,top=1394 ,right=471 ,bottom=1738 </L>
		<T>id='자금' ,left=209 ,top=1519 ,right=304 ,bottom=1556 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주택' ,left=209 ,top=1484 ,right=304 ,bottom=1521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(34)' ,left=209 ,top=1450 ,right=304 ,bottom=1487 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=1172 ,right=987 ,bottom=1172 </L>
		<T>id='(노인장기요양 보험료포함)' ,left=312 ,top=1124 ,right=736 ,bottom=1162 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)건강보험료' ,left=312 ,top=1093 ,right=736 ,bottom=1130 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1077 ,right=987 ,bottom=1077 </L>
		<T>id='보험료' ,left=209 ,top=1154 ,right=304 ,bottom=1191 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(33)' ,left=209 ,top=1119 ,right=304 ,bottom=1156 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=1508 ,right=201 ,bottom=1537 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=1471 ,right=201 ,bottom=1500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=161 ,top=1434 ,right=201 ,bottom=1463 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=161 ,top=1397 ,right=201 ,bottom=1426 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='별' ,left=161 ,top=1360 ,right=201 ,bottom=1389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='특' ,left=161 ,top=1323 ,right=201 ,bottom=1352 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(라)별정우체국연금' ,left=312 ,top=1032 ,right=640 ,bottom=1069 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=1019 ,right=987 ,bottom=1019 </L>
		<T>id='(다)사립학교교직원연금' ,left=312 ,top=974 ,right=640 ,bottom=1011 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=960 ,right=987 ,bottom=960 </L>
		<T>id='(나)군인연금' ,left=312 ,top=915 ,right=640 ,bottom=953 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=905 ,right=987 ,bottom=905 </L>
		<T>id='(가)공무원연금' ,left=312 ,top=857 ,right=640 ,bottom=894 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공   제' ,left=209 ,top=1013 ,right=304 ,bottom=1050 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보험료' ,left=209 ,top=982 ,right=304 ,bottom=1019 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연   금' ,left=209 ,top=950 ,right=304 ,bottom=987 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공   적' ,left=209 ,top=918 ,right=304 ,bottom=955 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(32)' ,left=209 ,top=884 ,right=304 ,bottom=921 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=844 ,right=987 ,bottom=844 </L>
		<L> left=307 ,top=844 ,right=307 ,bottom=1738 </L>
		<T>id='(31)국민연금보험료공제' ,left=212 ,top=796 ,right=540 ,bottom=833 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=1011 ,right=201 ,bottom=1040 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=982 ,right=201 ,bottom=1011 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='험' ,left=161 ,top=923 ,right=201 ,bottom=953 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='료' ,left=161 ,top=953 ,right=201 ,bottom=982 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보' ,left=161 ,top=894 ,right=201 ,bottom=923 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='금' ,left=161 ,top=865 ,right=201 ,bottom=894 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연' ,left=161 ,top=836 ,right=201 ,bottom=865 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(30)한부모가족' ,left=212 ,top=736 ,right=508 ,bottom=773 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=722 ,right=987 ,bottom=722 </L>
		<T>id='(29)부   녀   자' ,left=212 ,top=675 ,right=508 ,bottom=712 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(28)장 애 인 ' ,left=212 ,top=614 ,right=413 ,bottom=651 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=601 ,right=987 ,bottom=601 </L>
		<T>id='(27)경로우대' ,left=212 ,top=553 ,right=413 ,bottom=590 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=701 ,right=201 ,bottom=728 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=669 ,right=201 ,bottom=699 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='가' ,left=161 ,top=638 ,right=201 ,bottom=667 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='추' ,left=161 ,top=606 ,right=201 ,bottom=635 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=540 ,right=987 ,bottom=540 </L>
		<T>id='(26)부양가족' ,left=212 ,top=492 ,right=413 ,bottom=529 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=476 ,right=987 ,bottom=476 </L>
		<T>id='(25)배   우   자' ,left=212 ,top=429 ,right=497 ,bottom=466 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=482 ,right=201 ,bottom=511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=452 ,right=201 ,bottom=482 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='본' ,left=161 ,top=423 ,right=201 ,bottom=452 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기' ,left=161 ,top=394 ,right=201 ,bottom=423 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=355 ,right=156 ,bottom=1847 </L>
		<L> left=204 ,top=357 ,right=204 ,bottom=1849 </L>
		<T>id='(23)근로소득금액' ,left=114 ,top=310 ,right=680 ,bottom=347 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(22)근로소득공제' ,left=114 ,top=251 ,right=680 ,bottom=288 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=2585 ,right=1868 ,bottom=2585 </L>
		<T>id='그' ,left=114 ,top=2064 ,right=153 ,bottom=2101 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='밖' ,left=114 ,top=2167 ,right=153 ,bottom=2207 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='의' ,left=114 ,top=2223 ,right=153 ,bottom=2260 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=114 ,top=2299 ,right=153 ,bottom=2336 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=114 ,top=2344 ,right=153 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=114 ,top=2392 ,right=153 ,bottom=2432 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=114 ,top=2439 ,right=153 ,bottom=2482 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=1897 ,right=987 ,bottom=1897 </L>
		<T>id='(37)차감소득금액' ,left=119 ,top=1855 ,right=434 ,bottom=1892 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1900 ,right=156 ,bottom=2585 </L>
		<T>id='(38)개인연금저축' ,left=164 ,top=1905 ,right=479 ,bottom=1942 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1998 ,right=987 ,bottom=1998 </L>
		<T>id='(39)소기업 소상공인 공제부금' ,left=164 ,top=1955 ,right=677 ,bottom=1992 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1947 ,right=987 ,bottom=1947 </L>
		<T>id='(40)' ,left=164 ,top=2003 ,right=302 ,bottom=2040 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주택마련' ,left=164 ,top=2037 ,right=302 ,bottom=2074 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='저축소득' ,left=164 ,top=2072 ,right=302 ,bottom=2109 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제' ,left=164 ,top=2106 ,right=302 ,bottom=2143 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)주택청약종합저축' ,left=318 ,top=2056 ,right=635 ,bottom=2093 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)청약저축' ,left=318 ,top=2006 ,right=635 ,bottom=2043 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=1998 ,right=307 ,bottom=2146 </L>
		<L> left=307 ,top=2048 ,right=987 ,bottom=2048 </L>
		<L> left=307 ,top=2098 ,right=987 ,bottom=2098 </L>
		<L> left=159 ,top=2146 ,right=990 ,bottom=2146 </L>
		<T>id='(다)근로자주택마련저축' ,left=318 ,top=2106 ,right=635 ,bottom=2143 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(41)투자조합출자 등' ,left=164 ,top=2156 ,right=677 ,bottom=2193 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=2199 ,right=987 ,bottom=2199 </L>
		<L> left=156 ,top=2252 ,right=987 ,bottom=2252 </L>
		<L> left=159 ,top=2310 ,right=990 ,bottom=2310 </L>
		<L> left=156 ,top=2365 ,right=987 ,bottom=2365 </L>
		<L> left=156 ,top=2421 ,right=987 ,bottom=2421 </L>
		<L> left=156 ,top=2479 ,right=987 ,bottom=2479 </L>
		<L> left=156 ,top=2532 ,right=987 ,bottom=2532 </L>
		<T>id='(49)소득공제 종합한도 초과액' ,left=119 ,top=2601 ,right=632 ,bottom=2638 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(42)신용카드 등 사용액' ,left=164 ,top=2207 ,right=677 ,bottom=2244 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(43)우리사주조합 출연금' ,left=164 ,top=2262 ,right=677 ,bottom=2299 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(45)고용유지 중소기업 근로자' ,left=164 ,top=2376 ,right=677 ,bottom=2413 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(46)목돈 안드는 전세 이자상환액' ,left=164 ,top=2432 ,right=677 ,bottom=2469 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(47)장기집합투자증권저축' ,left=164 ,top=2487 ,right=677 ,bottom=2524 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(48)그 밖의 소득공제 계' ,left=164 ,top=2543 ,right=677 ,bottom=2580 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(50)종합소득 과세표준' ,left=992 ,top=183 ,right=1471 ,bottom=220 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=415 ,right=987 ,bottom=415 </L>
		<L> left=106 ,top=352 ,right=1871 ,bottom=352 </L>
		<T>id='(51)산출세액' ,left=995 ,top=280 ,right=1474 ,bottom=318 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=299 ,right=987 ,bottom=299 </L>
		<L> left=1037 ,top=603 ,right=1865 ,bottom=603 </L>
		<T>id='(56)세액감면계' ,left=1040 ,top=616 ,right=1519 ,bottom=654 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(55)조세조약' ,left=1040 ,top=556 ,right=1519 ,bottom=593 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(53)[조세특례제한법] (54 제외)' ,left=1040 ,top=426 ,right=1519 ,bottom=463 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(52)[소득세법]' ,left=1040 ,top=368 ,right=1519 ,bottom=405 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1037 ,top=415 ,right=1865 ,bottom=415 </L>
		<T>id='(54)[조세특례제한법]  제30조' ,left=1040 ,top=495 ,right=1519 ,bottom=532 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1037 ,top=476 ,right=1865 ,bottom=476 </L>
		<L> left=1037 ,top=542 ,right=1865 ,bottom=542 </L>
		<L> left=204 ,top=661 ,right=1868 ,bottom=661 </L>
		<T>id='면' ,left=992 ,top=550 ,right=1032 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='감' ,left=992 ,top=511 ,right=1032 ,bottom=540 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=990 ,top=471 ,right=1029 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=990 ,top=431 ,right=1029 ,bottom=460 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(57)근로소득' ,left=1040 ,top=675 ,right=1519 ,bottom=712 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1035 ,top=722 ,right=1868 ,bottom=722 </L>
		<L> left=1082 ,top=873 ,right=1082 ,bottom=2289 </L>
		<T>id='(59)과학기술인공제' ,left=1087 ,top=908 ,right=1360 ,bottom=945 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1035 ,top=870 ,right=1868 ,bottom=870 </L>
		<L> left=1386 ,top=923 ,right=1868 ,bottom=923 </L>
		<L> left=1085 ,top=979 ,right=1868 ,bottom=979 </L>
		<L> left=1386 ,top=1037 ,right=1868 ,bottom=1037 </L>
		<L> left=1085 ,top=1093 ,right=1868 ,bottom=1093 </L>
		<T>id='(60)[근로자퇴직급여' ,left=1087 ,top=984 ,right=1360 ,bottom=1021 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보장법]에 따른' ,left=1087 ,top=1019 ,right=1360 ,bottom=1056 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='퇴직연금' ,left=1087 ,top=1050 ,right=1360 ,bottom=1087 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1386 ,top=1146 ,right=1868 ,bottom=1146 </L>
		<T>id='(61)연금저축' ,left=1087 ,top=1130 ,right=1360 ,bottom=1167 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1037 ,top=1196 ,right=1865 ,bottom=1196 </L>
		<L> left=1386 ,top=1246 ,right=1868 ,bottom=1246 </L>
		<L> left=1225 ,top=1296 ,right=1871 ,bottom=1296 </L>
		<T>id='(62)보험료' ,left=1087 ,top=1270 ,right=1217 ,bottom=1307 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1386 ,top=1347 ,right=1868 ,bottom=1347 </L>
		<L> left=1085 ,top=1400 ,right=1868 ,bottom=1400 </L>
		<L> left=1384 ,top=1458 ,right=1865 ,bottom=1458 </L>
		<T>id='(63)의료비' ,left=1087 ,top=1445 ,right=1360 ,bottom=1482 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1082 ,top=1519 ,right=1865 ,bottom=1519 </L>
		<L> left=1386 ,top=1574 ,right=1868 ,bottom=1574 </L>
		<T>id='(64)교육비' ,left=1087 ,top=1553 ,right=1360 ,bottom=1590 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1085 ,top=1630 ,right=1868 ,bottom=1630 </L>
		<L> left=1386 ,top=1685 ,right=1868 ,bottom=1685 </L>
		<L> left=1386 ,top=1794 ,right=1868 ,bottom=1794 </L>
		<L> left=1386 ,top=1908 ,right=1868 ,bottom=1908 </L>
		<L> left=1386 ,top=2021 ,right=1868 ,bottom=2021 </L>
		<L> left=1386 ,top=2127 ,right=1868 ,bottom=2127 </L>
		<T>id='(73)결정세액[(51)-(56)-(72)]' ,left=1003 ,top=2601 ,right=1516 ,bottom=2638 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1032 ,top=352 ,right=1032 ,bottom=2585 </L>
		<T>id='제' ,left=990 ,top=1640 ,right=1029 ,bottom=1683 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=990 ,top=1577 ,right=1029 ,bottom=1617 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=990 ,top=1513 ,right=1029 ,bottom=1550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=990 ,top=1453 ,right=1029 ,bottom=1490 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1085 ,top=2178 ,right=1868 ,bottom=2178 </L>
		<T>id='금' ,left=1087 ,top=1947 ,right=1127 ,bottom=1987 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='부' ,left=1087 ,top=1905 ,right=1127 ,bottom=1942 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기' ,left=1087 ,top=1863 ,right=1127 ,bottom=1900 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(65)' ,left=1087 ,top=1823 ,right=1127 ,bottom=1860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1132 ,top=1630 ,right=1132 ,bottom=2178 </L>
		<L> left=1085 ,top=2233 ,right=1868 ,bottom=2233 </L>
		<T>id='(67) 표준세액공제' ,left=1090 ,top=2244 ,right=1355 ,bottom=2281 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(66) 계' ,left=1090 ,top=2188 ,right=1355 ,bottom=2225 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1132 ,top=1849 ,right=1871 ,bottom=1849 </L>
		<L> left=1132 ,top=1963 ,right=1871 ,bottom=1963 </L>
		<L> left=1132 ,top=2077 ,right=1871 ,bottom=2077 </L>
		<T>id='공제대상금액' ,left=1389 ,top=878 ,right=1569 ,bottom=915 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1230 ,top=722 ,right=1230 ,bottom=870 </L>
		<L> left=1230 ,top=773 ,right=1868 ,bottom=773 </L>
		<L> left=1230 ,top=823 ,right=1868 ,bottom=823 </L>
		<T>id='공제대상자    ' ,left=1238 ,top=730 ,right=1434 ,bottom=767 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='6세 이하        ' ,left=1238 ,top=781 ,right=1434 ,bottom=818 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='출산·입양자   ' ,left=1238 ,top=831 ,right=1434 ,bottom=868 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1154 ,right=1569 ,bottom=1191 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1101 ,right=1569 ,bottom=1138 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1048 ,right=1569 ,bottom=1085 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=990 ,right=1569 ,bottom=1027 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=934 ,right=1569 ,bottom=971 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1204 ,right=1569 ,bottom=1241 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1254 ,right=1569 ,bottom=1291 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1304 ,right=1569 ,bottom=1341 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1355 ,right=1569 ,bottom=1392 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1410 ,right=1569 ,bottom=1447 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1468 ,right=1569 ,bottom=1505 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1527 ,right=1569 ,bottom=1564 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1585 ,right=1569 ,bottom=1622 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1638 ,right=1569 ,bottom=1675 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1696 ,right=1569 ,bottom=1733 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1746 ,right=1569 ,bottom=1783 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1804 ,right=1569 ,bottom=1842 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1860 ,right=1569 ,bottom=1897 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1918 ,right=1569 ,bottom=1955 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1974 ,right=1569 ,bottom=2011 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=2032 ,right=1569 ,bottom=2069 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=2085 ,right=1569 ,bottom=2122 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=2135 ,right=1569 ,bottom=2172 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(58)자녀' ,left=1040 ,top=778 ,right=1167 ,bottom=815 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연' ,left=1040 ,top=968 ,right=1080 ,bottom=997 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='금' ,left=1040 ,top=1008 ,right=1080 ,bottom=1037 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='계' ,left=1040 ,top=1048 ,right=1080 ,bottom=1077 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='좌' ,left=1040 ,top=1087 ,right=1080 ,bottom=1117 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1225 ,top=1196 ,right=1225 ,bottom=1400 </L>
		<T>id='보장성' ,left=1233 ,top=1228 ,right=1341 ,bottom=1265 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='장애인전용' ,left=1233 ,top=1312 ,right=1376 ,bottom=1349 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보장성' ,left=1233 ,top=1349 ,right=1341 ,bottom=1386 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1249 ,top=1630 ,right=1249 ,bottom=1849 </L>
		<L> left=1249 ,top=1738 ,right=1868 ,bottom=1738 </L>
		<T>id='이하' ,left=1259 ,top=1685 ,right=1352 ,bottom=1722 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='10만원' ,left=1259 ,top=1648 ,right=1352 ,bottom=1685 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='초과' ,left=1259 ,top=1794 ,right=1352 ,bottom=1831 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='10만원' ,left=1259 ,top=1757 ,right=1352 ,bottom=1794 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기부금' ,left=1138 ,top=1767 ,right=1241 ,bottom=1804 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='자금' ,left=1138 ,top=1725 ,right=1241 ,bottom=1762 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)정치' ,left=1138 ,top=1683 ,right=1241 ,bottom=1720 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)법정기부금' ,left=1138 ,top=1889 ,right=1363 ,bottom=1926 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(다)우리사주조합' ,left=1138 ,top=1969 ,right=1363 ,bottom=2006 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기부금(2015년' ,left=1138 ,top=2003 ,right=1363 ,bottom=2040 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='이후 기부분)' ,left=1138 ,top=2037 ,right=1363 ,bottom=2074 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)지정기부금' ,left=1138 ,top=2111 ,right=1363 ,bottom=2148 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1384 ,top=873 ,right=1384 ,bottom=2178 </L>
		<L> left=1032 ,top=2289 ,right=1868 ,bottom=2289 </L>
		<T>id='(68)납세조합공제' ,left=1040 ,top=2297 ,right=1561 ,bottom=2334 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1032 ,top=2339 ,right=1868 ,bottom=2339 </L>
		<L> left=1032 ,top=2389 ,right=1868 ,bottom=2389 </L>
		<L> left=1032 ,top=2439 ,right=1868 ,bottom=2439 </L>
		<L> left=1032 ,top=2535 ,right=1868 ,bottom=2535 </L>
		<T>id='공제대상금액' ,left=1389 ,top=2445 ,right=1569 ,bottom=2482 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1386 ,top=2487 ,right=1868 ,bottom=2487 </L>
		<T>id='세액공제액' ,left=1389 ,top=2495 ,right=1569 ,bottom=2532 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(69)주택차입금' ,left=1040 ,top=2347 ,right=1561 ,bottom=2384 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(70)외국납부' ,left=1040 ,top=2397 ,right=1561 ,bottom=2434 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(71)월세액' ,left=1040 ,top=2474 ,right=1378 ,bottom=2511 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(72)세액공제계' ,left=1040 ,top=2543 ,right=1561 ,bottom=2580 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1384 ,top=2439 ,right=1384 ,bottom=2535 </L>
		<L> left=204 ,top=1249 ,right=987 ,bottom=1249 </L>
		<T>id='(나)고용보험료' ,left=312 ,top=1193 ,right=736 ,bottom=1230 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='거주자' ,left=614 ,top=1336 ,right=749 ,bottom=1373 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='대출기관' ,left=614 ,top=1275 ,right=749 ,bottom=1312 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=606 ,top=1251 ,right=606 ,bottom=1741 </L>
		<L> left=603 ,top=1323 ,right=987 ,bottom=1323 </L>
		<T>id='원리금상환액' ,left=312 ,top=1323 ,right=572 ,bottom=1360 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)주택임차차입금' ,left=312 ,top=1289 ,right=572 ,bottom=1326 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=111 ,top=1643 ,right=151 ,bottom=1685 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=111 ,top=1582 ,right=151 ,bottom=1622 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=111 ,top=1521 ,right=151 ,bottom=1558 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=111 ,top=1461 ,right=151 ,bottom=1498 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='합' ,left=111 ,top=1394 ,right=151 ,bottom=1434 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='종' ,left=111 ,top=1331 ,right=151 ,bottom=1371 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='특' ,left=1040 ,top=1519 ,right=1080 ,bottom=1558 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='별' ,left=1040 ,top=1582 ,right=1080 ,bottom=1622 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=1040 ,top=1648 ,right=1080 ,bottom=1685 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=1040 ,top=1709 ,right=1080 ,bottom=1746 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=1040 ,top=1770 ,right=1080 ,bottom=1810 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=1040 ,top=1831 ,right=1080 ,bottom=1873 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=783 ,right=987 ,bottom=783 </L>
		<C>id='{decode(SUM,0,,SUM)}', left=783, top=177, right=984, bottom=222, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LOAN_DED,0,,LOAN_DED)}', left=783, top=1267, right=984, bottom=1312, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TTAX_STD,0,,TTAX_STD)}', left=1664, top=172, right=1865, bottom=217, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_AMT,0,,TAX_AMT)}', left=1664, top=270, right=1865, bottom=315, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(HGR_DED,0,,HGR_DED)}', left=1664, top=672, right=1865, bottom=717, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AGE_AMT,0,,AGE_AMT)}', left=1664, top=728, right=1865, bottom=773, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AGE_INP,0,,AGE_INP)}', left=1664, top=828, right=1865, bottom=873, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(ANN_DED,0,,ANN_DED)}', left=1664, top=1151, right=1865, bottom=1196, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MMA_DED,0,,MMA_DED)}', left=1664, top=1468, right=1865, bottom=1513, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOV_DED,0,,GOV_DED)}', left=1664, top=1691, right=1865, bottom=1736, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LC23_DED,0,,LC23_DED)}', left=1664, top=2130, right=1865, bottom=2175, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MRENT_AMT,0,,MRENT_AMT)}', left=1664, top=2490, right=1865, bottom=2535, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINS,0,,SUM_HINS)}', left=783, top=1193, right=984, bottom=1238, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINU,0,,SUM_HINU)}', left=783, top=1106, right=984, bottom=1151, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(NPEN_DED,0,,NPEN_DED)}', left=783, top=791, right=984, bottom=836, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(OTX_DED,0,,OTX_DED)}', left=783, top=730, right=984, bottom=775, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(WDD_AMT,0,,WDD_AMT)}', left=783, top=672, right=984, bottom=717, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TBL_DED,0,,TBL_DED)}', left=783, top=611, right=984, bottom=656, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOL_AMT,0,,GOL_AMT)}', left=783, top=550, right=984, bottom=595, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GDED_AMT,0,,GDED_AMT)}', left=783, top=487, right=984, bottom=532, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SPSB_AMT,0,,SPSB_AMT)}', left=783, top=426, right=984, bottom=471, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MNI_AMT,0,,MNI_AMT)}', left=783, top=307, right=984, bottom=352, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MGR_AMT,0,,MGR_AMT)}', left=783, top=249, right=984, bottom=294, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(PLOAN_DED,0,,PLOAN_DED)}', left=783, top=1339, right=984, bottom=1384, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH4_AMT,0,,LONG_DED)}', left=783, top=1402, right=984, bottom=1447, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH6_AMT,0,,LONG_DED)}', left=783, top=1503, right=984, bottom=1548, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH7_AMT,0,,LONG_DED)}', left=783, top=1595, right=984, bottom=1640, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH8_AMT,0,,LONG_DED)}', left=783, top=1691, right=984, bottom=1736, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DON_FWD,0,,DON_FWD)}', left=783, top=1744, right=984, bottom=1789, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(VEN_DED,0,,VEN_DED)}', left=783, top=1797, right=984, bottom=1842, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(INDED_TOT,0,,INDED_TOT)}', left=783, top=1852, right=984, bottom=1897, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(PER_DED,0,,PER_DED)}', left=783, top=1900, right=984, bottom=1945, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SSO_DED,0,,SSO_DED)}', left=783, top=1953, right=984, bottom=1998, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAVE2_DED,0,,SAVE2_DED)}', left=783, top=2053, right=984, bottom=2098, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAVE3_DED,0,,SAVE3_DED)}', left=783, top=2101, right=984, bottom=2146, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CARD_DED,0,,CARD_DED)}', left=783, top=2207, right=984, bottom=2252, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAJU_DED,0,,SAJU_DED)}', left=783, top=2260, right=984, bottom=2305, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LSS_DED,0,,LSS_DED)}', left=783, top=2484, right=984, bottom=2529, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(INDED_EXC,0,,INDED_EXC)}', left=783, top=2601, right=984, bottom=2646, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(24)본         인' ,left=212 ,top=368 ,right=497 ,bottom=405 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='{decode(BADD_AMT,0,,BADD_AMT)}', left=783, top=362, right=984, bottom=407, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH5_AMT,0,,LONG_DED)}', left=783, top=1453, right=984, bottom=1498, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAVE1_DED,0,,SAVE1_DED)}', left=783, top=2003, right=984, bottom=2048, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DGG_TAX,0,,DGG_TAX)}', left=1664, top=2596, right=1865, bottom=2641, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TDED_TOT,0,,TDED_TOT)}', left=1664, top=2540, right=1865, bottom=2585, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(STA_TOT,0,,STA_TOT)}', left=1664, top=2238, right=1865, bottom=2283, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(NSE_TOT,0,,NSE_TOT)}', left=1664, top=2183, right=1865, bottom=2228, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LC1_DED,0,,LC1_DED)}', left=1664, top=1916, right=1865, bottom=1961, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOV2_DED,0,,GOV2_DED)}', left=1664, top=1802, right=1865, bottom=1847, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(EDU_DED,0,,EDU_DED)}', left=1664, top=1582, right=1865, bottom=1627, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LIH_DED,0,,LIH_DED)}', left=1664, top=1352, right=1865, bottom=1397, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MIN_DED,0,,MIN_DED)}', left=1664, top=1249, right=1865, bottom=1294, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AGE_RCH,0,,AGE_RCH)}', left=1664, top=778, right=1865, bottom=823, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_DED,0,,TAX_DED)}', left=1664, top=614, right=1865, bottom=659, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(VEN2_DED,0,,VEN2_DED)}', left=783, top=2154, right=984, bottom=2199, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(44)우리사주조합 기부금(2014년 이전 기부분)' ,left=164 ,top=2320 ,right=770 ,bottom=2357 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='{decode(DFM_CNT,0,,DFM_CNT)}', left=415, top=492, right=545, bottom=529 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOL_CNT,0,,GOL_CNT)}', left=415, top=553, right=545, bottom=590 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TRB_CNT,0,,TRB_CNT)}', left=415, top=614, right=545, bottom=651 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CHI_INP,0,,CHI_INP)}', left=1439, top=831, right=1569, bottom=868 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CHI_RCH,0,,CHI_RCH)}', left=1439, top=781, right=1569, bottom=818 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CHI_CNT,0,,CHI_CNT)}', left=1439, top=730, right=1569, bottom=767 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	</B>
	</R>
	</A>
		
	<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='3.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 DetailDataID='gcds_print3',
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=614 ,face='Arial' ,size=10 ,penwidth=1
		<T>id='각종 소득공제 ·세액공제 항목' ,left=611 ,top=167 ,right=1897 ,bottom=254 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=58 ,top=69 ,right=1900 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=119 ,top=161 ,right=119 ,bottom=487 </L>
		<L> left=1791 ,top=257 ,right=1791 ,bottom=609 </L>
		<L> left=61 ,top=161 ,right=1900 ,bottom=161 </L>
		<L> left=61 ,top=484 ,right=1900 ,bottom=484 </L>
		<L> left=61 ,top=487 ,right=1900 ,bottom=487 </L>
		<L> left=61 ,top=603 ,right=1900 ,bottom=603 </L>
		<L> left=58 ,top=69 ,right=58 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=288 ,top=548 ,right=1897 ,bottom=548 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=61 ,top=609 ,right=1900 ,bottom=609 </L>
		<T>id='(제3쪽)' ,left=1622 ,top=8 ,right=1876 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(79)소득 세액공제 명세 [인적공제항목은 해당란에 \'O\'표시(장애인 해당 시 해당코드 기재)를 하며, 각종 소득공제·세액공제 항목은 ' ,left=71 ,top=79 ,right=1889 ,bottom=114 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id=' 공제를 위하여 실제 지출한 금액을 적습니다.]' ,left=71 ,top=116 ,right=1889 ,bottom=151 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='관계' ,left=64 ,top=167 ,right=119 ,bottom=209 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='코드' ,left=64 ,top=206 ,right=119 ,bottom=251 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='신용카드등 사용액공제' ,left=1331 ,top=288 ,right=1730 ,bottom=333 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='성 명' ,left=124 ,top=167 ,right=280 ,bottom=254 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='인적공제 항목에 해당' ,left=61 ,top=487 ,right=288 ,bottom=532 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='하는 인원수를 적습니다.' ,left=61 ,top=527 ,right=288 ,bottom=564 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(자녀' ,left=64 ,top=564 ,right=159 ,bottom=598 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='CHI_CNT', left=161, top=564, right=241, bottom=598, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='명)' ,left=249 ,top=564 ,right=288 ,bottom=598 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=286 ,top=164 ,right=286 ,bottom=611 </L>
		<T>id='모' ,left=376 ,top=437 ,right=407 ,bottom=471 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='부' ,left=376 ,top=400 ,right=407 ,bottom=434 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='한' ,left=376 ,top=362 ,right=407 ,bottom=397 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='인' ,left=450 ,top=439 ,right=482 ,bottom=474 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='애' ,left=450 ,top=402 ,right=482 ,bottom=437 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='장' ,left=450 ,top=365 ,right=482 ,bottom=400 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=503 ,top=259 ,right=503 ,bottom=611 </L>
		<T>id='인적공제 항목' ,left=307 ,top=167 ,right=553 ,bottom=254 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=286 ,top=352 ,right=585 ,bottom=352 </L>
		<L> left=355 ,top=352 ,right=355 ,bottom=487 </L>
		<T>id='자' ,left=307 ,top=437 ,right=339 ,bottom=471 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='녀' ,left=307 ,top=400 ,right=339 ,bottom=434 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='부' ,left=307 ,top=362 ,right=339 ,bottom=397 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=426 ,top=259 ,right=426 ,bottom=611 </L>
		<L> left=582 ,top=164 ,right=582 ,bottom=611 </L>
		<T>id='출산' ,left=513 ,top=270 ,right=577 ,bottom=304 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='입양' ,left=513 ,top=304 ,right=577 ,bottom=339 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='경로' ,left=434 ,top=270 ,right=497 ,bottom=304 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='우대' ,left=434 ,top=304 ,right=497 ,bottom=339 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기본' ,left=320 ,top=270 ,right=384 ,bottom=304 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제' ,left=320 ,top=304 ,right=384 ,bottom=339 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='이하' ,left=513 ,top=415 ,right=577 ,bottom=450 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='6세' ,left=513 ,top=381 ,right=577 ,bottom=415 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='구분' ,left=598 ,top=373 ,right=672 ,bottom=407 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='자료' ,left=598 ,top=339 ,right=672 ,bottom=373 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=61 ,top=257 ,right=1900 ,bottom=257 </L>
		<T>id='기부금' ,left=1799 ,top=360 ,right=1894 ,bottom=405 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보험료' ,left=706 ,top=291 ,right=1000 ,bottom=336 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1016 ,top=257 ,right=1016 ,bottom=609 </L>
		<T>id='교육비' ,left=1143 ,top=360 ,right=1238 ,bottom=405 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='의료비' ,left=1027 ,top=360 ,right=1122 ,bottom=405 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=691 ,top=352 ,right=1016 ,bottom=352 </L>
		<L> left=1246 ,top=352 ,right=1791 ,bottom=352 </L>
		<T>id='보장성' ,left=915 ,top=437 ,right=1011 ,bottom=466 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='전용' ,left=915 ,top=405 ,right=1011 ,bottom=434 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='장애인' ,left=915 ,top=373 ,right=1011 ,bottom=402 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보장성' ,left=807 ,top=405 ,right=902 ,bottom=434 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='고용 등' ,left=699 ,top=418 ,right=794 ,bottom=447 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='건강 ·' ,left=699 ,top=389 ,right=794 ,bottom=418 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='이용액' ,left=1693 ,top=418 ,right=1789 ,bottom=447 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='대중교통' ,left=1693 ,top=389 ,right=1789 ,bottom=418 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='사용액' ,left=1585 ,top=418 ,right=1680 ,bottom=447 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='전통시장' ,left=1585 ,top=389 ,right=1680 ,bottom=418 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='영수증' ,left=1474 ,top=418 ,right=1569 ,bottom=447 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='현금' ,left=1474 ,top=389 ,right=1569 ,bottom=418 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='카드 등' ,left=1365 ,top=421 ,right=1461 ,bottom=450 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='직불' ,left=1365 ,top=392 ,right=1461 ,bottom=421 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='카드 등' ,left=1257 ,top=421 ,right=1352 ,bottom=450 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='신용' ,left=1257 ,top=392 ,right=1352 ,bottom=421 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=799 ,top=352 ,right=799 ,bottom=609 </L>
		<L> left=908 ,top=352 ,right=908 ,bottom=609 </L>
		<L> left=1357 ,top=355 ,right=1357 ,bottom=611 </L>
		<L> left=1466 ,top=352 ,right=1466 ,bottom=609 </L>
		<L> left=1246 ,top=257 ,right=1246 ,bottom=609 </L>
		<L> left=1685 ,top=355 ,right=1685 ,bottom=611 </L>
		<L> left=1577 ,top=352 ,right=1577 ,bottom=609 </L>
		<T>id='기타' ,left=587 ,top=556 ,right=688 ,bottom=601 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='국세청' ,left=587 ,top=497 ,right=688 ,bottom=542 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=355 ,top=550 ,right=355 ,bottom=609 </L>
		<L> left=1132 ,top=257 ,right=1132 ,bottom=609 </L>
		<L> left=1902 ,top=69 ,right=1902 ,bottom=611 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='내·외' ,left=64 ,top=328 ,right=119 ,bottom=373 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='국인' ,left=64 ,top=365 ,right=119 ,bottom=407 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='번         호' ,left=124 ,top=365 ,right=280 ,bottom=407 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주 민 등 록' ,left=124 ,top=328 ,right=280 ,bottom=373 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<S>id='{Sum(HIN_SUM)}' ,left=696 ,top=497 ,right=796 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(LIN_AMT)}' ,left=804 ,top=556 ,right=905 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(LIN_AMT_NTS)}' ,left=804 ,top=497 ,right=905 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<L> left=691 ,top=257 ,right=691 ,bottom=609 </L>
		<S>id='{Sum(LIH_AMT)}' ,left=913 ,top=556 ,right=1013 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(LIH_AMT_NTS)}' ,left=913 ,top=497 ,right=1013 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(MED_AMT)}' ,left=1021 ,top=556 ,right=1130 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(MED_AMT_NTS)}' ,left=1021 ,top=497 ,right=1130 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(EDU_AMT)}' ,left=1138 ,top=556 ,right=1244 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(EDU_AMT_NTS)}' ,left=1138 ,top=497 ,right=1244 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(CARD_AMT)}' ,left=1249 ,top=556 ,right=1355 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(CARD_AMT_NTS)}' ,left=1249 ,top=497 ,right=1355 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(DIR_CARD_AMT)}' ,left=1363 ,top=556 ,right=1463 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(DIR_CARD_AMT_NTS)}' ,left=1363 ,top=497 ,right=1463 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(CASH_AMT_NTS)}' ,left=1474 ,top=497 ,right=1574 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(MARKET_AMT)}' ,left=1582 ,top=556 ,right=1683 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(MARKET_AMT_NTS)}' ,left=1582 ,top=497 ,right=1683 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(PUBLIC_AMT)}' ,left=1688 ,top=556 ,right=1789 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(PUBLIC_AMT_NTS)}' ,left=1688 ,top=497 ,right=1789 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(GIBU_AMT)}' ,left=1797 ,top=556 ,right=1897 ,bottom=601 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<S>id='{Sum(GIBU_AMT_NTS)}' ,left=1797 ,top=497 ,right=1897 ,bottom=542 ,align='right' ,face='Arial Narrow' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
		<X>left=1468 ,top=548 ,right=1577 ,bottom=603 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	</B>
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=106 ,face='Arial' ,size=10 ,penwidth=1
		<L> left=58 ,top=106 ,right=1900 ,bottom=106 </L>
		<L> left=58 ,top=0 ,right=58 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=58 ,top=53 ,right=1902 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<C>id='TYPE', left=64, top=58, right=119, bottom=103, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REL_CD', left=64, top=5, right=119, bottom=50, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=119 ,top=3 ,right=119 ,bottom=106 </L>
		<C>id='CET_NO', left=124, top=58, right=283, bottom=103 ,mask='XXXXXX-XXXXXXX', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='FAM_NM', left=124, top=5, right=283, bottom=50, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=286 ,top=3 ,right=286 ,bottom=106 </L>
		<L> left=355 ,top=53 ,right=355 ,bottom=106 </L>
		<C>id='WCT_MAN', left=291, top=58, right=355, bottom=103, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ONE_MAN', left=360, top=58, right=423, bottom=103, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='BAS_MAN', left=296, top=5, right=418, bottom=50, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=426 ,top=3 ,right=426 ,bottom=106 </L>
		<L> left=503 ,top=0 ,right=503 ,bottom=103 </L>
		<L> left=582 ,top=0 ,right=582 ,bottom=103 </L>
		<T>id='기타' ,left=587 ,top=58 ,right=688 ,bottom=103 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='국세청' ,left=587 ,top=5 ,right=688 ,bottom=50 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=691 ,top=0 ,right=691 ,bottom=103 </L>
		<L> left=799 ,top=3 ,right=799 ,bottom=106 </L>
		<L> left=908 ,top=3 ,right=908 ,bottom=106 </L>
		<L> left=1016 ,top=0 ,right=1016 ,bottom=103 </L>
		<L> left=1132 ,top=0 ,right=1132 ,bottom=103 </L>
		<L> left=1357 ,top=0 ,right=1357 ,bottom=103 </L>
		<L> left=1246 ,top=0 ,right=1246 ,bottom=103 </L>
		<L> left=1466 ,top=0 ,right=1466 ,bottom=103 </L>
		<L> left=1685 ,top=0 ,right=1685 ,bottom=103 </L>
		<C>id='GOL_70', left=434, top=5, right=497, bottom=50, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='INP_MAN', left=511, top=5, right=574, bottom=50, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RCH_MAN', left=511, top=58, right=574, bottom=103, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='TRB_MAN', left=434, top=58, right=497, bottom=103, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1791 ,top=0 ,right=1791 ,bottom=103 </L>
		<C>id='{decode(GIBU_AMT_NTS,0,,GIBU_AMT_NTS)}', left=1797, top=5, right=1897, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GIBU_AMT,0,,GIBU_AMT)}', left=1797, top=58, right=1897, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1577 ,top=0 ,right=1577 ,bottom=103 </L>
		<C>id='{decode(HIN_SUM,0,,HIN_SUM)}', left=696, top=5, right=796, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LIN_AMT_NTS,0,,LIN_AMT_NTS)}', left=804, top=5, right=905, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LIN_AMT,0,,LIN_AMT)}', left=804, top=58, right=905, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LIH_AMT,0,,LIH_AMT)}', left=913, top=58, right=1013, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MED_AMT_NTS,0,,MED_AMT_NTS)}', left=1021, top=5, right=1130, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MED_AMT,0,,MED_AMT)}', left=1021, top=58, right=1130, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(EDU_AMT_NTS,0,,EDU_AMT_NTS)}', left=1138, top=5, right=1244, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(EDU_AMT,0,,EDU_AMT)}', left=1138, top=58, right=1244, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CARD_AMT_NTS,0,,CARD_AMT_NTS)}', left=1249, top=5, right=1355, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CARD_AMT,0,,CARD_AMT)}', left=1249, top=58, right=1355, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DIR_CARD_AMT_NTS,0,,DIR_CARD_AMT_NTS)}', left=1363, top=5, right=1463, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DIR_CARD_AMT,0,,DIR_CARD_AMT)}', left=1363, top=58, right=1463, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MARKET_AMT_NTS,0,,MARKET_AMT_NTS)}', left=1582, top=5, right=1683, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MARKET_AMT,0,,MARKET_AMT)}', left=1582, top=58, right=1683, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CASH_AMT_NTS,0,,CASH_AMT_NTS)}', left=1474, top=5, right=1574, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(PUBLIC_AMT_NTS,0,,PUBLIC_AMT_NTS)}', left=1688, top=5, right=1789, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(PUBLIC_AMT,0,,PUBLIC_AMT)}', left=1688, top=58, right=1789, bottom=103, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LIH_AMT_NTS,0,,LIH_AMT_NTS)}', left=913, top=5, right=1013, bottom=50, align='right', face='Arial Narrow', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<X>left=1468 ,top=53 ,right=1577 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
		<L> left=1902 ,top=0 ,right=1902 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	</B>
	<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=1151 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=124 ,top=111 ,right=1812 ,bottom=217 ,border=true</X>
		<L> left=58 ,top=1087 ,right=1902 ,bottom=1087 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='   (소득공제는 서식에서 정하는 바에 따라 순서대로 소득공제를 적용하여 종합소득과세표준과 세액을 계산합니다. )' ,left=71 ,top=937 ,right=1889 ,bottom=976 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  7. 종합소득 특별소득공제 [(33~(35)]란과  그 밖의 소득공제[(38)~(47)]란은 근로소득자 소득 ·세액 공제신고서(별지 제 37호서식)의 공제액을 적습니다.' ,left=71 ,top=900 ,right=1889 ,bottom=939 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='   비과세  소득금액을 더한 금액을 적습니다. 이 경우 소득세와 관련한 비과세·공제·감면 및 세액공제에 관한 규정은 적용하지 않습니다.' ,left=71 ,top=863 ,right=1889 ,bottom=902 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  6. (21)총급여란에는 (16)계란의 금액을 적되, 외국인근로자가 [조세특례제한법] 제18조의2제2항에 따라 단일세율을 적용하는 경우에는 (16)계의 금액과' ,left=71 ,top=826 ,right=1889 ,bottom=865 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='   또한, 동일회사 내에서 사업자등록번호가 다른 곳에서 전입 등을 한 경우 해당 법인이 연말정산을 하는 경우에 전입하기 전 지점 등에서 발생한 소득은 근무처별' ,left=71 ,top=746 ,right=1889 ,bottom=788 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='    기업형태변경 등으로 해당 법인이 연말정산을 하는 경우에 피합병법인과 기업형태변경 전의 소득은 근무처별 소득명세 종(전)란에 별도로 적습니다.' ,left=71 ,top=704 ,right=1889 ,bottom=749 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='      [소득세법] 제127조제1항제4호 각 목에 해당하는 근로소득을 적고, [소득세법] 제150조에 따른 납세조합공제금액을 (68)납세조합공제란에 적습니다. 합병, ' ,left=71 ,top=661 ,right=1889 ,bottom=706 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  5. [소득세법] 제127조제1항제4호의 각 목에 해당하는 근로소득과 그 외 근로소득을 더하여 연말정산하는 때에는 (16)-1납세조합란에 각각 근로소득납세조합과 ' ,left=71 ,top=622 ,right=1889 ,bottom=664 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='     총액만 적고, Ⅱ.비과세 소득란을 별지로 작성할 수 있습니다.)' ,left=71 ,top=587 ,right=1889 ,bottom=624 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  8. 연금계좌[(59)~(61)]란과 특별세액공제 [(62)~(65)]란은 근로소득자 소득·세액 공제신고서(별지 제37호서식)의 공제대상금액 및 세액공제액을 적습니다.' ,left=71 ,top=974 ,right=1889 ,bottom=1013 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='   소득명세 종(전)란에 별도로 적습니다.' ,left=71 ,top=786 ,right=1889 ,bottom=828 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='     감면대상을 해당 코드별로 구분하여 적습니다. (적을 항목이 많은 경우 Ⅱ.비과세 및 감면소득 명세서란의 (20)비과세소득 계란 및 (20)-1 감면세액 계에 ' ,left=71 ,top=553 ,right=1889 ,bottom=590 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  4. Ⅰ근무처별 소득명세란은 비과세소득을 제외한 금액을 해당 항목별로 적고, Ⅱ.비과세 및 감면소득 명세서란에는 지급명세서 작성대상 비과세소득 및' ,left=71 ,top=516 ,right=1889 ,bottom=556 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='    까지 지급명세서를 제출해야 합니다.' ,left=71 ,top=479 ,right=1889 ,bottom=519 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  3. 원천징수의무자는 지급일이 속하는 연도의 다음 연도 3월 10일(휴업 또는 폐업한 경우에는 휴업일 또는 폐업일이 속하는 달의 다음 다음 달 말일을 말합니다)' ,left=71 ,top=442 ,right=1889 ,bottom=482 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='     국가코드를 적습니다. 해당 근로소득자가 외국인근로자 단일세율적용신청서를 제출한 경우 \'외국인단일세율 적용\'란에 여1를 선택합니다.' ,left=71 ,top=405 ,right=1889 ,bottom=445 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  2. 근로소득자가 외국인에 해당하는 경우에는 내·외국인란에 외국인 9를 선택하고 국적 및 국적코드란에 국제표준화기구(ISO)가 정한 ISO코드 중 국명 약어 및' ,left=71 ,top=368 ,right=1889 ,bottom=407 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  예) 대한민국: KR, 미국 : US' ,left=71 ,top=331 ,right=1889 ,bottom=370 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  1. 거주지국과 거주지국코드는 근로소득자가 비거주자에 해당하는 경우에만 적으며, 국제표준화기구(ISO)가 정한 ISO코드 중 국명약어 및 국가코드를 적습니다.' ,left=71 ,top=257 ,right=1889 ,bottom=296 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='     (* ISO국가코드 : 국세청홈페이지->국세정보->국세조세정보->국세조세자료실에서 조회할 수 있습니다. )' ,left=71 ,top=294 ,right=1889 ,bottom=333 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='※ 작성방법' ,left=74 ,top=48 ,right=278 ,bottom=93 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='의 사업자등록번호를 적습니다.' ,left=159 ,top=177 ,right=1783 ,bottom=209 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='이 경우 (9) 근무처명 및 (10)사업자등록번호에는 실제 근무처의 상호 및 사업자번호를 적습니다. 다만, 근무처의 사업자등록이 없는 경우 납세조합' ,left=159 ,top=148 ,right=1783 ,bottom=180 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='[소득세법] 제149조제1호에 해당하는 납세조합이 [소득세법] 제127조제1항제4호 각 목에 해당하는 근로소득을 연말정산하는 경우에도 사용하며,' ,left=159 ,top=119 ,right=1783 ,bottom=151 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=58 ,top=0 ,right=58 ,bottom=1087 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1902 ,top=0 ,right=1902 ,bottom=1087 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	</B>
	</R>
	</A>
	
	
	<A>id=Area4 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='4.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID='gcds_print4', DetailDataID='gcds_print4_1'
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=986 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=42 ,top=283 ,right=1913 ,bottom=283 </L>
		<L> left=40 ,top=146 ,right=1910 ,bottom=146 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=40 ,top=386 ,right=1910 ,bottom=386 </L>
		<L> left=40 ,top=468 ,right=1910 ,bottom=468 </L>
		<L> left=40 ,top=548 ,right=1910 ,bottom=548 </L>
		<L> left=40 ,top=648 ,right=1910 ,bottom=648 </L>
		<L> left=759 ,top=386 ,right=759 ,bottom=548 </L>
		<L> left=1238 ,top=386 ,right=1238 ,bottom=548 </L>
		<L> left=310 ,top=386 ,right=310 ,bottom=746 </L>
		<T>id='연금 · 저축 등 소득 · 세액공제 명세서' ,left=45 ,top=151 ,right=1910 ,bottom=275 ,face='맑은 고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='1. 인적사항' ,left=50 ,top=291 ,right=299 ,bottom=384 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='221-81-13834' ,left=1244 ,top=394 ,right=1722 ,bottom=466 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='①상            호' ,left=45 ,top=394 ,right=307 ,bottom=466 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='③성            명' ,left=45 ,top=474 ,right=307 ,bottom=545 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='⑤주            소' ,left=45 ,top=558 ,right=307 ,bottom=648 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='( 전화번호:' ,left=1410 ,top=556 ,right=1580 ,bottom=646 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='PHN_NO', left=1585, top=556, right=1873, bottom=646, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id=')' ,left=1849 ,top=556 ,right=1881 ,bottom=646 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='⑥사업장소재지' ,left=45 ,top=656 ,right=307 ,bottom=746 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='( 전화번호: 02-3669-3915 )' ,left=1410 ,top=656 ,right=1892 ,bottom=746 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ADDRESS_HOME', left=315, top=556, right=1394, bottom=646, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='현대아산(주)' ,left=315 ,top=394 ,right=749 ,bottom=466 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ENO_NM', left=315, top=474, right=749, bottom=545, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='②사  업  자  등  록  번  호' ,left=765 ,top=394 ,right=1228 ,bottom=466 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='④주   민   등   록   번   호' ,left=765 ,top=474 ,right=1228 ,bottom=545 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='강원도 고성군 현내면 화진포서길 10' ,left=315 ,top=656 ,right=1394 ,bottom=746 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(6쪽)' ,left=1752 ,top=71 ,right=1905 ,bottom=132 ,align='right'</T>
		<L> left=42 ,top=749 ,right=1913 ,bottom=749 </L>
		<T>id='    1)  퇴직연금계좌  ' ,left=48 ,top=833 ,right=1886 ,bottom=870 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='      * 퇴직연금 공제에 대한 명세를 작성합니다.' ,left=48 ,top=873 ,right=1886 ,bottom=910 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제금액' ,left=1625 ,top=926 ,right=1913 ,bottom=987 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='납입금액' ,left=1334 ,top=926 ,right=1622 ,bottom=987 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='계좌번호(또는 증권번호)' ,left=870 ,top=926 ,right=1320 ,bottom=987 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=42 ,top=921 ,right=1913 ,bottom=921 </L>
		<T>id='퇴직연금 구분' ,left=48 ,top=926 ,right=318 ,bottom=987 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=42 ,top=987 ,right=1913 ,bottom=987 </L>
		<T>id='금융회사 등 ' ,left=323 ,top=926 ,right=857 ,bottom=987 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=320 ,top=921 ,right=320 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1326 ,top=921 ,right=1326 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='2. 연금계좌 세액공제' ,left=48 ,top=781 ,right=505 ,bottom=831 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=42 ,top=146 ,right=42 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1910 ,top=146 ,right=1910 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=865 ,top=921 ,right=865 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1622 ,top=921 ,right=1622 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='CET_NO', left=1246, top=474, right=1680, bottom=545, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	</B>
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=95 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=42 ,top=0 ,right=42 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=61 ,right=1913 ,bottom=61 </L>
		<C>id='{decode(DED_AMT,0,,DED_AMT)}', left=1627, top=3, right=1908, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=865 ,top=0 ,right=865 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1326 ,top=0 ,right=1326 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='{decode(AMOUNT,0,,AMOUNT)}', left=1331, top=3, right=1619, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ACC_NO', left=870, top=3, right=1320, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ABA_NM', left=325, top=3, right=855, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1622 ,top=0 ,right=1622 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='PEN_GUBUN_NM', left=48, top=3, right=312, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=42 ,top=64 ,right=1910 ,bottom=64 </L>
		<L> left=1913 ,top=0 ,right=1913 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=320 ,top=0 ,right=320 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	</B>
	</R>
	</A>
	

	<A>id=Area4_2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='4_2.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 DetailDataID='gcds_print4_2' 
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=265 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=42 ,top=265 ,right=1913 ,bottom=265 </L>
		<L> left=42 ,top=196 ,right=1913 ,bottom=196 </L>
		<L> left=42 ,top=95 ,right=1913 ,bottom=95 </L>
		<T>id='      * 연금저축계좌에 대한 명세를 작성합니다.' ,left=45 ,top=151 ,right=1884 ,bottom=188 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연금저축 구분' ,left=45 ,top=201 ,right=315 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='금융회사 등 ' ,left=320 ,top=201 ,right=855 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='계좌번호(또는 증권번호)' ,left=870 ,top=201 ,right=1320 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='납입금액' ,left=1331 ,top=201 ,right=1619 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소득/세액 공제금액' ,left=1627 ,top=201 ,right=1908 ,bottom=262 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=318 ,top=196 ,right=318 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=865 ,top=198 ,right=865 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1326 ,top=198 ,right=1326 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1622 ,top=198 ,right=1622 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=3 ,right=42 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='    2)  연금저축계좌' ,left=45 ,top=111 ,right=1884 ,bottom=148 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1910 ,top=3 ,right=1910 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	</B>
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=63 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=1910 ,top=0 ,right=1910 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='PEN_GUBUN_NM', left=48, top=3, right=312, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1622 ,top=0 ,right=1622 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='ABA_NM', left=325, top=3, right=855, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ACC_NO', left=870, top=3, right=1320, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AMOUNT,0,,AMOUNT)}', left=1331, top=3, right=1619, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1326 ,top=0 ,right=1326 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=865 ,top=0 ,right=865 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=318 ,top=0 ,right=318 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='{decode(DED_AMT,0,,DED_AMT)}', left=1627, top=3, right=1908, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=42 ,top=0 ,right=42 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=64 ,right=1913 ,bottom=64 </L>
	</B>
	</R>
	</A>
	
	
	<A>id=Area4_3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='4_3.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 DetailDataID='gcds_print4_3' 
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=265 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=42 ,top=265 ,right=1913 ,bottom=265 </L>
		<L> left=42 ,top=196 ,right=1913 ,bottom=196 </L>
		<L> left=42 ,top=95 ,right=1913 ,bottom=95 </L>
		<T>id='      * 주택마련저축 소득공제에 대한 명세를 작성합니다.' ,left=45 ,top=151 ,right=1884 ,bottom=188 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='저축 구분' ,left=45 ,top=201 ,right=315 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='금융회사 등 ' ,left=320 ,top=201 ,right=855 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='계좌번호(또는 증권번호)' ,left=870 ,top=201 ,right=1320 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='납입금액' ,left=1331 ,top=201 ,right=1619 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소득공제금액' ,left=1627 ,top=201 ,right=1908 ,bottom=262 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=318 ,top=196 ,right=318 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=865 ,top=198 ,right=865 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1326 ,top=198 ,right=1326 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1622 ,top=198 ,right=1622 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=3 ,right=42 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='    3)  주택마련저축 소득공제' ,left=45 ,top=111 ,right=1884 ,bottom=148 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1910 ,top=3 ,right=1910 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	</B>
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=63 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=1910 ,top=0 ,right=1910 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='PEN_GUBUN_NM', left=48, top=3, right=312, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1622 ,top=0 ,right=1622 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='ABA_NM', left=325, top=3, right=855, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ACC_NO', left=870, top=3, right=1320, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AMOUNT,0,,AMOUNT)}', left=1331, top=3, right=1619, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1326 ,top=0 ,right=1326 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=865 ,top=0 ,right=865 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=318 ,top=0 ,right=318 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='{decode(DED_AMT,0,,DED_AMT)}', left=1627, top=3, right=1908, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=42 ,top=0 ,right=42 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=64 ,right=1913 ,bottom=64 </L>
	</B>
	</R>
	</A>
	
	<A>id=Area4_4 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='4_4.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 DetailDataID='gcds_print4_4' 
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=264 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=42 ,top=265 ,right=1913 ,bottom=265 </L>
		<L> left=42 ,top=196 ,right=1913 ,bottom=196 </L>
		<L> left=42 ,top=95 ,right=1913 ,bottom=95 </L>
		<T>id='      * 장기집합투자증권저축 소득공제에 대한 명세를 작성합니다.' ,left=45 ,top=151 ,right=1884 ,bottom=188 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='계좌번호(또는 증권번호)' ,left=870 ,top=201 ,right=1320 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='납입금액' ,left=1331 ,top=201 ,right=1619 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소득공제금액' ,left=1627 ,top=201 ,right=1908 ,bottom=262 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=865 ,top=198 ,right=865 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1326 ,top=198 ,right=1326 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1622 ,top=198 ,right=1622 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='    4)  장기집합투자증권저축 소득공제' ,left=45 ,top=111 ,right=1884 ,bottom=148 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1910 ,top=3 ,right=1910 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='금융회사 등 ' ,left=48 ,top=201 ,right=855 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=42 ,top=3 ,right=42 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	</B>
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=63 ,face='Tahoma' ,size=10 ,penwidth=1
		<L> left=1910 ,top=0 ,right=1910 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1622 ,top=0 ,right=1622 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='ACC_NO', left=870, top=3, right=1320, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AMOUNT,0,,AMOUNT)}', left=1331, top=3, right=1619, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1326 ,top=0 ,right=1326 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=865 ,top=0 ,right=865 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='{decode(DED_AMT,0,,DED_AMT)}', left=1627, top=3, right=1908, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=42 ,top=0 ,right=42 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=64 ,right=1913 ,bottom=64 </L>
		<C>id='ABA_NM', left=48, top=3, right=855, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	</B>
	<B>id=Tail ,left=0,top=0 ,right=2000 ,bottom=495 ,face='Tahoma' ,size=10 ,penwidth=1
		<T>id='※ 작성방법' ,left=48 ,top=116 ,right=1908 ,bottom=164 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='1. 연금계좌 세액공제, 주택마련저축·장기집합투자증권저축 소득공제를 받는 소득자에 대해서는 해당 소득·세액 공제에 대한 명세를' ,left=48 ,top=164 ,right=1908 ,bottom=214 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id=' 작성해야 합니다. 해당 계좌별로 납입금액과 소득·세액 공제금액을 적고, 공제금액이 0인 경우에는 적지 않습니다.' ,left=48 ,top=214 ,right=1908 ,bottom=265 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2. 퇴직연금계좌에서 퇴직연금구분란은 퇴직연금(DC,IRP)·과학기술인공제회로 구분하여 적습니다.' ,left=48 ,top=265 ,right=1908 ,bottom=315 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='3. 연금저축계좌에서 연금저축구분란은 개인연금저축과 연금저축으로 구분하여 적습니다.' ,left=48 ,top=315 ,right=1908 ,bottom=365 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='4. 주택마련저축 공제의 저축구분란은 청약저축, 주택청약종합저축 및 근로자주택마련저축으로 구분하여 적습니다.' ,left=48 ,top=365 ,right=1908 ,bottom=415 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='5. 공제금액란은 근로소득자가 적지 않을 수 있습니다.' ,left=48 ,top=415 ,right=1908 ,bottom=466 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=42 ,top=3 ,right=42 ,bottom=476 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1910 ,top=3 ,right=1910 ,bottom=476 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=476 ,right=1908 ,bottom=476 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	</B>
	</R>
	</A>
    ">
</object>
    
</body>
</html>

