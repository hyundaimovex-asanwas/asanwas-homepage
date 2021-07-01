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

            params = "&S_MODE=SHR_14"
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
			if(gusrid != "6060002" && gusrid != "2030007" && gusrid != "2140002" ){
				
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
							        		,"RESULT");

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
								        		,"txtRESULT");

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


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">연말정산결과조회</td>
                    <td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">연말정산결과조회</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
    				</tr>
    			</table>
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
                        <td class="blueBold" align="center" rowspan="16">세액공제</td>
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
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">자녀</td>
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

                <br>

                <!-- 세번째 테이블 -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
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
                        <td class="blueBold" align="center">환급세액</td>
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
                        <td class="padding2423" style="padding-left:10px" >
		                        <comment id="__NSID__"><object id="txtRESULT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
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
       ">
	</object>




</body>
</html>

