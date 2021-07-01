	<!--*************************************************************************
	* @source      : sava010.jsp												*
	* @description : 개인별저축금관리 PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/19            채갑병          	        최초작성									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>개인별저축금(sava010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TTTTFFTT';
        var vENO_NO = "";
        var vBNK_CD = "";
        var vACC_NO = "";

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			// 개인별 저축금 현황 조회
			var ENO_NO_SHR  = document.getElementById("txtENO_NO_SHR").value;
			var CAN_TAG_SHR = document.getElementById("cmbCAN_TAG_SHR").value;
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
            
            if(STR_YMD_SHR > END_YMD_SHR) {
                alert("시작일자는 종료일자보다 작아야 합니다.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }
            if(STR_YMD_SHR == "" && END_YMD_SHR != "") {
                alert("시작일자를 입력해 주세요");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }
            if(STR_YMD_SHR != "" && END_YMD_SHR == "") {
                alert("종료일자를 입력해 주세요");
                document.getElementById("txtEND_YMD_SHR").focus();
                return;
            }

			dsT_SV_SAVELIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.sav.a.sava010.cmd.SAVA010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&CAN_TAG_SHR="+CAN_TAG_SHR+"&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR;
			dsT_SV_SAVELIST.reset();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
        	//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
            
            //신규로 입력한 데이터 초기화
            for(var i=1; i<=dsT_SV_SAVELIST.CountRow; i++) {
                //입력건이 2개 이상이면 맨 마지막에 입력한 녀석이 저장됨
                if(dsT_SV_SAVELIST.RowStatus(i) == 1) {
                    vENO_NO = dsT_SV_SAVELIST.NameString(i, "ENO_NO");
                    vBNK_CD = dsT_SV_SAVELIST.NameString(i, "BNK_CD");
                    vACC_NO = dsT_SV_SAVELIST.NameString(i, "ACC_NO");            
                }
            }

			// save
			trT_SV_SAVELIST.KeyValue = "tr01(I:dsT_SV_SAVELIST=dsT_SV_SAVELIST)";
			trT_SV_SAVELIST.action = "/servlet/GauceChannelSVL?cmd=hr.sav.a.sava010.cmd.SAVA010CMD&S_MODE=SAV";
			trT_SV_SAVELIST.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_SV_SAVELIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SV_SAVELIST.GridToExcel("개인별저축금", '', 225);
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_SV_SAVELIST.CountColumn == 0) {
				dsT_SV_SAVELIST.setDataHeader("ENO_NO:STRING, BNK_CD:STRING, ACC_NO:STRING, OCC_CD:STRING, SAV_CD:STRING, CON_YMD:STRING, DUE_YMD:STRING, CON_CNT:INT, CON_AMT:INT, CONM_AMT:INT, DSC_PCT:DECIMAL(3.1), DSC_AMT:INT, SUM_SAV:INT, SUMP_CNT:INT, FAPP_YMD:STRING, PIN_MTH:STRING, PIN_YN:STRING, CAN_TAG:STRING, CAN_YMD:STRING, TJC_AMT:INT, WOL_AMT:INT, OTHP_AMT:INT, OTH_AMT:INT");
			}

			// 조회 후 신규 등록시 필드 활성화 처리를 위해 연속 호출
            fnc_DisableElementAll(elementList);
			fnc_EnableElementAll(elementList, exceptionList1);

			dsT_SV_SAVELIST.AddRow();

			document.form1.cmbSAV_CD.selectedIndex      = 0;
			document.form1.cmbBNK_CD.selectedIndex      = 0;
			document.form1.cmbPIN_YN.selectedIndex      = 0;
			document.form1.cmbPIN_MTH.selectedIndex     = 0;
			document.form1.cmbCAN_TAG.selectedIndex     = 0;
			document.form1.cmbCAN_TAG_SHR.selectedIndex = 0;
		}

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_SV_SAVELIST.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "사원명     = "+dsT_SV_SAVELIST.nameValue(dsT_SV_SAVELIST.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "금융기관  = "+dsT_TACCCOD_BK.NameString(dsT_TACCCOD_BK.NameValueRow("CODE", dsT_SV_SAVELIST.nameValue(dsT_SV_SAVELIST.RowPosition, "BNK_CD")), "CODE_NAME")+"\n";
            	tmpMSG += "계좌번호  = "+dsT_SV_SAVELIST.nameValue(dsT_SV_SAVELIST.RowPosition, "ACC_NO")+"\n";
            	tmpMSG += "계약일     = "+dsT_SV_SAVELIST.nameValue(dsT_SV_SAVELIST.RowPosition, "CON_YMD")+"\n";

	            if( confirm(tmpMSG) ){
					var ENO_NO = dsT_SV_SAVELIST.nameValue(dsT_SV_SAVELIST.RowPosition, "ENO_NO");
					var BNK_CD  = dsT_SV_SAVELIST.nameValue(dsT_SV_SAVELIST.RowPosition, "BNK_CD");
					var ACC_NO  = dsT_SV_SAVELIST.nameValue(dsT_SV_SAVELIST.RowPosition, "ACC_NO");

					dsT_SV_SAVELIST.DeleteRow(dsT_SV_SAVELIST.RowPosition);

					// 파라미터 추가
					trT_SV_SAVELIST.Parameters = "ENO_NO="+ENO_NO+",BNK_CD="+BNK_CD+",ACC_NO="+ACC_NO;

					trT_SV_SAVELIST.KeyValue = "tr02(I:dsT_SV_SAVELIST=dsT_SV_SAVELIST)";
					trT_SV_SAVELIST.action = "/servlet/GauceChannelSVL?cmd=hr.sav.a.sava010.cmd.SAVA010CMD&S_MODE=DEL";
					trT_SV_SAVELIST.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
  			document.form1.txtENO_NO_SHR.value = "";
  			document.form1.txtENO_NM_SHR.value = "";
            document.getElementById("txtSTR_YMD_SHR").value = "";
            document.getElementById("txtEND_YMD_SHR").value = "";

            fnc_DisableElementAll(elementList);
	        document.getElementById("resultMessage").innerText = ' ';

			// 콤보박스 기본 선택
			document.form1.cmbSAV_CD.selectedIndex      = 0;
			document.form1.cmbBNK_CD.selectedIndex      = 0;
			document.form1.cmbPIN_YN.selectedIndex      = 0;
			document.form1.cmbPIN_MTH.selectedIndex     = 0;
			document.form1.cmbCAN_TAG.selectedIndex     = 0;
			document.form1.cmbCAN_TAG_SHR.selectedIndex = 0;

        	dsT_SV_SAVELIST.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_SV_SAVELIST.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if ( !dsT_SV_SAVELIST.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	// 은행종류 구분코드 조회
   			dsT_TACCCOD_BK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sav.a.sava010.cmd.SAVA010CMD&S_MODE=SHR_02";
			dsT_TACCCOD_BK.reset();

			// 저축종류 구분 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_V1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_V1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_V1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbSAV_CD").add(oOption);
			}

			cfStyleGrid(form1.grdT_SV_SAVELIST,15,"false","false");      // Grid Style 적용
			fnc_DisableElementAll(elementList);
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        //입력 element 리스트
        var elementList = new Array(     "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"cmbBNK_CD"
                                        ,"txtACC_NO"
                                        ,"cmbSAV_CD"
                                        ,"txtCON_YMD"
                                        ,"txtDUE_YMD"
                                        ,"medCONM_AMT"
                                        ,"txtCON_CNT"
                                        ,"medCON_AMT"
                                        ,"cmbPIN_MTH"
                                        ,"cmbCAN_TAG"
                                        ,"txtCAN_YMD"
                                        ,"cmbPIN_YN"
                                        
                                        ,"FindEmpl"
                                        ,"imgCON_YMD"
                                        ,"imgDUE_YMD"
                                        ,"imgCAN_YMD"
                                        
                                        ,"medTOT_CONM_AMT"
                                        ,"medTOT_SUM_SAV"
                                     );
        
        //입력할때 예외 처리 항목 (해약 사항을 사용 못하게)
        var exceptionList1 = new Array(  "cmbCAN_TAG"
                                        ,"txtCAN_YMD"
                                        ,"imgCAN_YMD"
                                        ,"cmbPIN_YN"
                                        
                                        ,"medTOT_CONM_AMT"
                                        ,"medTOT_SUM_SAV"
                                      );
        var exceptionList2 = new Array(  "txtENO_NO"
                                        ,"txtENO_NM"
                                        
                                        ,"FindEmpl"
                                        
                                        ,"medTOT_CONM_AMT"
                                        ,"medTOT_SUM_SAV"
                                      );

        
        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");
            
            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }   
        
        /**
         * 사원 정보를 조회 한다. 
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        } 
         
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            
            // 정규직 전체
            obj = fnc_GetEnoNm("txtENO_NO");
            if(document.getElementById("txtENO_NO").value != "") {
            
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtCET_NO").value      = obj.cet_no;
                
                document.getElementById("hidDPT_CD").value      = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("hidJOB_CD").value      = obj.job_cd;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                
                document.getElementById("hidOCC_CD").value      = obj.occ_cd;
                document.getElementById("txtOCC_NM").value      = obj.occ_nm;
                document.getElementById("txtACC_NO_CM").value   = obj.acc_no;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
                
                document.getElementById("hidDPT_CD").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("hidJOB_CD").value      = "";
                document.getElementById("txtJOB_NM").value      = "";

                document.getElementById("hidOCC_CD").value      = "";
                document.getElementById("txtOCC_NM").value      = "";
                document.getElementById("txtACC_NO_CM").value   = "";                
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

        /********************************************
         * 월불입액, 계약횟수 필드에서 포커스 떠날때 계약금액 산정*
         ********************************************/
        function fnc_sum(){
        	var conm_amt = document.form1.medCONM_AMT.Text;
        	var con_cnt  = document.form1.txtCON_CNT.value;
        	var sum = "";
        	if( conm_amt != "0" && conm_amt != ""){
        		if(con_cnt != "" && con_cnt != ""){
        			sum = eval(conm_amt+"*"+con_cnt);
        		}else{
        			sum = conm_amt;
        		}
        	}
        	document.form1.medCON_AMT.Text = sum+"";
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
    | 2. 이름은 ds_ + 주요 테이블명(T_SV_SAVELIST)			   |
    | 3. 사용되는 Table List(T_SV_SAVELIST) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SV_SAVELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 은행코드 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(HDPS.TACCCOD)			   |
    | 3. 사용되는 Table List(HDPS.TACCCOD) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_TACCCOD_BK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_SV_SAVELIST)		       |
    | 3. 사용되는 Table List(T_SV_SAVELIST)			       |
    +------------------------------------------------------>
	<Object ID="trT_SV_SAVELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SV_SAVELIST=dsT_SV_SAVELIST,I:dsT_SV_SAVELIST=dsT_SV_SAVELIST)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 저축종류 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_V1"/>
       <jsp:param name="CODE_GUBUN"    value="V1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_SV_SAVELIST Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SV_SAVELIST.CountRow);


            
            //조회시 해약된 저축일경우 필드 수정 불가 처리
            fnc_DisableElementAll(elementList);
            if( dsT_SV_SAVELIST.NameValue(0, "CAN_YMD") == "" ){
                fnc_EnableElementAll(elementList, exceptionList2);
            }            
            
            //기존에 신규로 등록한 데이타가 있다면 그 데이타로 가서 입력된 데이타 확인 가능하게 DS의 값을 변경 시킴
            if(vENO_NO != "" && vBNK_CD != "" && vACC_NO != "") {
                for(var i=1; i<dsT_SV_SAVELIST.CountRow; i++) {
                    if(dsT_SV_SAVELIST.NameString(i, "ENO_NO") == vENO_NO
                            && dsT_SV_SAVELIST.NameString(i, "BNK_CD") == vBNK_CD
                            && dsT_SV_SAVELIST.NameString(i, "ACC_NO") == vACC_NO) {
                        dsT_SV_SAVELIST.RowPosition = i;
                        break;       
                    }
                }
            }
            
            vENO_NO = "";
            vBNK_CD = "";
            vACC_NO = "";
        }
    </Script>

	<Script For=dsT_TACCCOD_BK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("은행 구분코드가 없습니다!");
		} else {
        	// 은행 구분 콤보박스 생성
			for( var i = 1; i <= dsT_TACCCOD_BK.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_TACCCOD_BK.NameValue(i,"CODE");
                oOption.text  = dsT_TACCCOD_BK.NameValue(i,"CODE_NAME");
				document.getElementById("cmbBNK_CD").add(oOption);
			}
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_SV_SAVELIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


	<Script For=dsT_TACCCOD_BK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_SV_SAVELIST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_SV_SAVELIST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_SV_SAVELIST event="OnFail()">
        alert(trT_SV_SAVELIST.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리			   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_SV_SAVELIST event=OnClick(row,colid)>
        //조회시 해약된 저축일경우 필드 수정 불가 처리
        fnc_DisableElementAll(elementList);
        if( dsT_SV_SAVELIST.NameValue(0, "CAN_YMD") == "" ){
            fnc_EnableElementAll(elementList, exceptionList2);
        }  
	</script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_SV_SAVELIST event=CanRowPosChange(row)>
		if ( dsT_SV_SAVELIST.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_SV_SAVELIST.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SV_SAVELIST.NameValue(row,"BNK_CD") == "" ) {
			alert("[ " + grdT_SV_SAVELIST.GetHdrDispName('-3','BNK_CD') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SV_SAVELIST.NameValue(row,"ACC_NO") == "" ) {
			alert("[ " + grdT_SV_SAVELIST.GetHdrDispName('-3','ACC_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SV_SAVELIST.NameValue(row,"CON_YMD") == "" ) {
			alert("[ " + grdT_SV_SAVELIST.GetHdrDispName('-3','CON_YMD') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SV_SAVELIST.NameValue(row,"CONM_AMT") == "" ) {
			alert("[ " + grdT_SV_SAVELIST.GetHdrDispName('-3','CONM_AMT') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SV_SAVELIST.NameValue(row,"CAN_TAG") == "" && dsT_SV_SAVELIST.NameValue(row,"CAN_YMD") != "" ) {
			alert("해약여부를 선택하십시오.");
			return false;
		}
		if ( dsT_SV_SAVELIST.NameValue(row,"CAN_TAG") == "C" && dsT_SV_SAVELIST.NameValue(row,"CAN_YMD") == "" ) {
			alert("해약일자를 입력하십시오.");
			return false;
		}
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별저축금관리</td>
					<td align="right" class="navigator">HOME/저축금/<font color="#000000">개인별저축금관리</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>                
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->
    

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="50"></col>
                            <col width="220"></col>
                            <col width="80"></col>
                            <col width="120"></col>
                            <col width="60"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>                   
                            <td class="searchState" align="right">사번</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) cfNumberCheck(); fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                            </td>
                            <td class="searchState" align="right">해약저축조회</td>
                            <td class="padding2423" align="left">
                                <select id="cmbCAN_TAG_SHR" style="width:100px">
                                    <option value="0">제외</option>
                                    <option value="1">포함</option>
                                </select>
                            </td>
                            <td class="searchState" align="right">계약일</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','510','407');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                 ~
                                <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','600','407');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>                            
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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="180"></col>
			<col width="80"></col>
			<col width="170"></col>
			<col width="80"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
            <td align="center" class="creamBold">사번</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" maxlength="12" size="15" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="FindEmpl" name="FindEmpl" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
            </td>
            <td align="center" class="creamBold">성명</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" maxlength="12" size="15" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
            </td>  
			<td align="center" class="creamBold">주민번호</td>
			<td class="padding2423">
                <input id="txtCET_NO" size="15" class="input_ReadOnly" readonly>
            </td>
		</tr>
		<tr>
			<td align="center" class="creamBold">소속</td>
			<td class="padding2423">
				<input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
				<input type="hidden" id="hidDPT_CD" size="10">
			</td>
			<td align="center" class="creamBold">직위</td>
			<td class="padding2423">
				<input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
				<input type="hidden" id="hidJOB_CD" size="10">
			</td>
			<td align="center" class="creamBold">근로구분</td>
			<td class="padding2423">
				<input id="txtOCC_NM" size="15" class="input_ReadOnly" readonly>
				<input type="hidden" id="hidOCC_CD" size="10">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">송금계좌</td>
			<td class="padding2423">
                <input id="txtACC_NO_CM" size="15" class="input_ReadOnly" readonly>
            </td>
			<td align="center" class="creamBold">월불입누계</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="60%">
					<comment id="__NSID__"><object id="medTOT_CONM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=9>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">총불입계</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="56%">
					<comment id="__NSID__"><object id="medTOT_SUM_SAV" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=9>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> 계약사항</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="180"></col>
			<col width="80"></col>
			<col width="170"></col>
			<col width="80"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">금융기관</td>
			<td class="padding2423">
				<select id="cmbBNK_CD" style="width:70%"></select>
			</td>
			<td align="center" class="creamBold">계좌번호</td>
			<td class="padding2423"><input id="txtACC_NO" size="15" maxLength="16"></td>
			<td align="center" class="creamBold">저축종류</td>
			<td class="padding2423">
				<select id="cmbSAV_CD" style="width:65%"></select>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">계약일</td>
			<td class="padding2423">
				<input type="text" id="txtCON_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCON_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgCON_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtCON_YMD','','105','229');"></a>
			</td>
			<td align="center" class="creamBold">만기일</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtDUE_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDUE_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgDUE_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtDUE_YMD','','373','229');"></a>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">월불입액</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="72%">
					<comment id="__NSID__"><object id="medCONM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">계약횟수</td>
			<td class="padding2423">
                <input id="txtCON_CNT" size="15" maxLength="2" onFocusout="fnc_sum()">
            </td>
			<td align="center" class="creamBold">계약금액</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="58%">
					<comment id="__NSID__"><object id="medCON_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> 불입사항</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="180"></col>
			<col width="80"></col>
			<col width="90"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">불입액</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="72%">
					<comment id="__NSID__"><object id="medSUM_SAV" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">불입횟수</td>
			<td class="padding2423"><input id="txtSUMP_CNT" size="5" maxLength="2"></td>
			<td align="center" class="creamBold">불입방법</td>
			<td class="padding2423">
				<select id="cmbPIN_MTH" style="width:90%">
					<option value="0">급여</option>
					<option value="1">상여</option>
					<option value="C">현금</option>
				</select>
			</td>
			<td align="center" class="creamBold">최종불입일</td>
			<td class="padding2423"><input id="txtFAPP_YMD" size="12" maxLength="10"></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> 해약사항</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="180"></col>
			<col width="80"></col>
			<col width="170"></col>
			<col width="80"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">해약여부</td>
			<td class="padding2423">
				<select id="cmbCAN_TAG" style="width:70%">
					<option value="">무</option>
					<option value="C">해약</option>
					<option value="Y">만기</option>
				</select>
			</td>
			<td align="center" class="creamBold">해약일</td>
			<td class="padding2423">
				<input type="text" id="txtCAN_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCAN_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgCAN_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtCAN_YMD','','373','362');"></a>
			</td>
			<td align="center" class="creamBold">불입보류</td>
			<td class="padding2423">
				<select id="cmbPIN_YN" style="width:40%">
					<option value="N">무</option>
					<option value="Y">보류</option>
				</select>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->
    
    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_SV_SAVELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:100px;">
						<param name="DataID" value="dsT_SV_SAVELIST">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width="30"		name="NO"			align="center"	value={String(Currow)}</C>
                            <C> id="DPT_NM"         width="80"     name="부서"          align="center"  Edit=none   </C>
                            <C> id="JOB_NM"         width="70"     name="직위"          align="center"  Edit=none   </C>                            
							<C> id="ENO_NO"			width="70"		name="사원번호"		align="center"	Edit=none	</C>
							<C> id="ENO_NM"			width="70"		name="성명"			align="center"	Edit=none	</C>
							<C> id="CET_NO"			width="100"		name="주민번호"		align="center"	Edit=none	Show="false"</C>
							<C> id="OCC_NM"			width="100"		name="근로구분"			align="center"	Edit=none	Show="false"</C>
							<C> id="ACC_NO_CM"		width="100"		name="송금계좌"		align="center"	Edit=none	Show="false"</C>
							<C> id="SAV_CD"			width="100"		name="저축종류"		align="left"	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_V1:CODE:CODE_NAME"	LeftMargin="10"</C>
							<C> id="BNK_CD"			width="100"		name="은행명"			align="left"	Edit=none	EditStyle=Lookup  Data="dsT_TACCCOD_BK:CODE:CODE_NAME"		LeftMargin="10"</C>
							<C> id="BNK_NM"			width="80"		name="은행명"			align="center"	Edit=none	Show="false"</C>
							<C> id="ACC_NO"			width="120"		name="계좌번호"		align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="OCC_CD"			width="60"		name="근로구분"			align="center"	Edit=none	Show="false"</C>
							<C> id="CON_YMD"		width="80"		name="계약일"			align="center"	Edit=none</C>
							<C> id="DUE_YMD"		width="80"		name="만기일"			align="center"	Edit=none</C>
							<C> id="CON_CNT"		width="40"		name="횟수"			align="center"	Edit=none</C>
							<C> id="CON_AMT"		width="80"		name="계약금액"		align="right"	Edit=none	RightMargin="10"</C>
							<C> id="CONM_AMT"		width="80"		name="월불입액"		align="right"	Edit=none	RightMargin="10"</C>
							<C> id="TOT_CONM_AMT"	width="80"		name="월불입누계"		align="right"	Edit=none	Show="false"</C>
							<C> id="DSC_PCT"		width="80"		name="할인율"			align="right"	Edit=none	Show="false"</C>
							<C> id="DSC_AMT"		width="80"		name="할인액"			align="right"	Edit=none	Show="false"</C>
							<C> id="SUMP_CNT"		width="40"		name="누적;횟수"		align="center"	Edit=none</C>
							<C> id="SUM_SAV"		width="80"		name="불입액"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="TOT_SUM_SAV"	width="80"		name="총불입액"		align="right"	Edit=none	Show="false"</C>
							<C> id="FAPP_YMD"		width="80"		name="최종;불입일"	align="center"	Edit=none</C>
							<C> id="PIN_MTH"		width="40"		name="불입;방법"		align="center"	Edit=none	EditStyle=Combo		Data="0:급여,1:상여,C:현금"</C>
							<C> id="PIN_YN"			width="40"		name="불입;보류"		align="center"	Edit=none</C>
							<C> id="CAN_TAG"		width="40"		name="해약;여부"		align="center"	Edit=none	EditStyle=Combo		Data="C:중도,Y:만기"</C>
							<C> id="CAN_YMD"		width="80"		name="해약일"			align="center"	Edit=none</C>
							<C> id="TJC_AMT"		width="80"		name="임의장려금지급액"align="center"	Edit=none	Show="false"</C>
							<C> id="WOL_AMT"		width="80"		name="실질월불입액"	align="right"	Edit=none	Show="false"</C>
							<C> id="OTHP_AMT"		width="80"		name="기타지불금액"	align="right"	Edit=none	Show="false"</C>
							<C> id="OTH_AMT"		width="80"		name="기타공제금액"	align="right"	Edit=none	Show="false"</C>
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

	<input type="hidden" id="hidBIR_YMD" size="10">
	</form>
	<!-- form 끝 -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_SV_SAVELIST 설정 테이블 -->
	<object id="bndT_SV_SAVELIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_SV_SAVELIST">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO			Ctrl=txtENO_NO			Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
			<C>Col=CET_NO			Ctrl=txtCET_NO			Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM			Param=value</C>
			<C>Col=OCC_NM			Ctrl=txtOCC_NM			Param=value</C>
			<C>Col=ACC_NO_CM		Ctrl=txtACC_NO_CM		Param=value</C>
			<C>Col=SAV_CD			Ctrl=cmbSAV_CD			Param=value</C>
			<C>Col=BNK_CD			Ctrl=cmbBNK_CD			Param=value</C>
			<C>Col=ACC_NO			Ctrl=txtACC_NO			Param=value</C>
			<C>Col=OCC_CD			Ctrl=hidOCC_CD			Param=value</C>
			<C>Col=CON_YMD			Ctrl=txtCON_YMD			Param=value</C>
			<C>Col=DUE_YMD			Ctrl=txtDUE_YMD			Param=value</C>
			<C>Col=CON_CNT			Ctrl=txtCON_CNT			Param=value</C>
			<C>Col=CON_AMT			Ctrl=medCON_AMT			Param=Text</C>
			<C>Col=CONM_AMT			Ctrl=medCONM_AMT		Param=Text</C>
			<C>Col=TOT_CONM_AMT		Ctrl=medTOT_CONM_AMT	Param=Text</C>
			<C>Col=DSC_PCT			Ctrl=txtDSC_PCT			Param=value</C>
			<C>Col=DSC_AMT			Ctrl=medDSC_AMT			Param=Text</C>
			<C>Col=SUM_SAV			Ctrl=medSUM_SAV			Param=Text</C>
			<C>Col=TOT_SUM_SAV		Ctrl=medTOT_SUM_SAV		Param=Text</C>
			<C>Col=SUMP_CNT			Ctrl=txtSUMP_CNT		Param=value</C>
			<C>Col=FAPP_YMD			Ctrl=txtFAPP_YMD		Param=value</C>
			<C>Col=PIN_MTH			Ctrl=cmbPIN_MTH			Param=value</C>
			<C>Col=PIN_YN			Ctrl=cmbPIN_YN			Param=value</C>
			<C>Col=CAN_TAG			Ctrl=cmbCAN_TAG			Param=value</C>
			<C>Col=CAN_YMD			Ctrl=txtCAN_YMD			Param=value</C>
			<C>Col=TJC_AMT			Ctrl=medTJC_AMT			Param=Text</C>
			<C>Col=WOL_AMT			Ctrl=medWOL_AMT			Param=Text</C>
			<C>Col=OOTHP_AMT		Ctrl=medOTHP_AMT		Param=Text</C>
			<C>Col=OTH_AMT			Ctrl=medOTH_AMT			Param=Text</C>
		">
	</object>