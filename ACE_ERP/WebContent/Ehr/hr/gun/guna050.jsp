	<!--*************************************************************************
	* @source      : guna050.jsp												*
	* @description : 근태변경신청서 PAGE										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/09            채갑병          	        최초작성									    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String DPTCD = (String)request.getSession().getAttribute("SESSION_DPTCD");
	String DPTNM = (String)request.getSession().getAttribute("SESSION_DPTNM");
	String ENONO = (String)request.getSession().getAttribute("SESSION_ENONO");
 %>
<html>
<head>
	<title>근태변경신청서(guna050)</title>
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

		var today = getToday();
		var btnList = 'TFTTFFTT';
		var isSHR = false;
		var REQ_NO = "";
		var REQ_YMD = "";

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            var DPT_CD_SHR   = document.form1.txtDPT_CD_SHR.value;
			var GUN_YMD_SHR  = document.form1.txtGUN_YMD_SHR.value;
			var REQ_NO_SHR  = document.form1.cmbREQ_NO_SHR.value;//신규시에는 데이터가 없으면 된다.

			if(DPT_CD_SHR == ""){
				alert("소속를 입력하십시오.");
				return;
			}
			if(GUN_YMD_SHR == ""){
				alert("해당근태일자를 입력하십시오.");
				return;
			}

			document.form1.txtCHN_YMD.value = GUN_YMD_SHR;

			isSHR = true;

			trT_DI_DILIGENCE.KeyValue = "tr05(O:dsO_one=dsT_DI_DILIGENCE, O:dsO_two=dsT_DI_APPROVAL)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna050.cmd.GUNA050CMD&S_MODE=SHR&DPT_CD_SHR="+DPT_CD_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR+"&REQ_NO_SHR="+REQ_NO_SHR;
			trT_DI_DILIGENCE.post();

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

            if(REQ_YMD == ""){
                REQ_YMD = document.getElementById("txtREQ_YMD").value;
                REQ_NO =  document.getElementById("txtREQ_NO").value;
            }

            //처음에 자동으로 들어가면 않넘어가므로 상태를 바꾸어준다.
            dsT_DI_APPROVAL.UserStatus(1) = "1";

			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna050.cmd.GUNA050CMD&S_MODE=SAV&REQ_YMD="+REQ_YMD+"&REQ_NO="+REQ_NO;
			trT_DI_DILIGENCE.post();

            fnc_SearchREQ_NO();
			fnc_SearchList();

        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {

            GUN_YMD = document.getElementById("txtGUN_YMD_SHR").value;

           	// 근태변경신청서 삭제
            if (dsT_DI_APPROVAL.CountRow > 0 && dsT_DI_APPROVAL.NameValue(1,"APP_YN") == "결재") {
                alert("결재완료된 데이터는 삭제할 수 없습니다!");
	        	return;
			}

			if (dsT_DI_DILIGENCE.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "신청번호 = "+REQ_NO+"\n";
            	tmpMSG += "사번 = "+dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "성명 = "+dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM")+"\n";


	            if( confirm(tmpMSG) ){

					dsT_DI_DILIGENCE.DeleteRow(dsT_DI_DILIGENCE.RowPosition);

					trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
					trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna050.cmd.GUNA050CMD&S_MODE=DEL&REQ_YMD="+REQ_YMD+"&REQ_NO="+REQ_NO+"&GUN_YMD="+GUN_YMD;
					trT_DI_DILIGENCE.post();

					fnc_SearchList();
				}
			}
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
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

			document.form1.cmbREQ_NO_SHR.value = "";//신규시에는 데이터가 없으면 된다.
            fnc_SearchList()

        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {

            var ENO_NO = "<%=ENONO%>";//신청자 사번
            var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;

            //정규직 전체
            obj = fnc_GetApprover(ENO_NO, DPT_CD, "3");//결재자 검색(신청자 사번 입력)

            //결재자 정보가 없으면 입력 안함
            if(obj.eno_no == "") {
                return;
            }

            //결재자 정보가 없으면 등록할 공간을 확보
            if (dsT_DI_APPROVAL.CountRow == 0) {
                dsT_DI_APPROVAL.AddRow();
            }

            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition, "SEQ_NO") = 1;
       		dsT_DI_APPROVAL.NameValue(1, "GUN_DPT") = DPT_CD;
       		dsT_DI_APPROVAL.NameValue(1, "DPT_CD")  = DPT_CD; // 조회된 소속의 소속코드
       		dsT_DI_APPROVAL.NameValue(1, "REQ_YMD") = REQ_YMD;
       		dsT_DI_APPROVAL.NameValue(1, "GUN_YMD") = document.form1.txtCHN_YMD.value;
       		dsT_DI_APPROVAL.NameValue(1, "GUN_GBN") = "U";  // 근태변경신청서
       		dsT_DI_APPROVAL.NameValue(1, "ENO_NO")  = obj.eno_no;
       		dsT_DI_APPROVAL.NameValue(1, "ENO_NM")  = obj.eno_nm;
       		dsT_DI_APPROVAL.NameValue(1, "JOB_CD")  = obj.job_cd;
       		dsT_DI_APPROVAL.NameValue(1, "JOB_NM")  = obj.job_nm;

            document.getElementById("txtA1_ENO_NM").innerText   = obj.job_nm+" "+obj.eno_nm;
            document.getElementById("txtA1_APP_STS").innerText  = "";

        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

			document.form1.txtDPT_CD_SHR.value = '<%=DPTCD %>';
			document.form1.txtDPT_NM_SHR.value = '<%=DPTNM %>';
			//document.form1.txtGUN_YMD_SHR.value = today;
	        document.form1.txtCHN_YMD.value = "";
	        document.form1.txtDPT_NM.value = "";
	        isSHR = false;
	        REQ_YMD = "";
	        REQ_NO = "";

        	dsT_DI_DILIGENCE.ClearData();
        	dsT_DI_APPROVAL.ClearData();

        	disableInput();

        	fnc_SearchREQ_NO();

	        document.getElementById("txtGUN_YMD_SHR").focus();

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_DI_DILIGENCE.IsUpdated)  {
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

            if (dsT_DI_APPROVAL.CountRow > 0 && dsT_DI_APPROVAL.NameValue(1,"APP_YN") == "결재") {
                alert("결재완료된 데이터는 저장할 수 없습니다!");
	        	return false;
			}

			if(REQ_YMD == ""){
                alert("신청일자를 입력하세요.");
                return false;
			}

            if(REQ_YMD < dsT_DI_DILIGENCE.NameValue(1,"MONTH_AGO")){
                alert("한달 이전의 근태변경서 신청내역은 저장할수 없습니다!");
                return false;
            }

         	if ( !dsT_DI_DILIGENCE.isUpdated ) {
	         	if ( dsT_DI_APPROVAL.isUpdated ) {
	         		var flag = true;
	         		for(var i=0; i<dsT_DI_DILIGENCE.CountRow; i++){
	         			if(dsT_DI_DILIGENCE.RowStatus(i) == 3){ // update
	         				flag = false;
	         			}
	    	     	}
	         	}
			}
       		if( !flag && !dsT_DI_DILIGENCE.isUpdated ){
        		alert("근태 변경신청서를 작성하십시오.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
	            return false;
     		}

     		for(var i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
     		    //사유 반드시 입력이 필요하다.
                if(dsT_DI_DILIGENCE.RowStatus(i) == 3 && dsT_DI_DILIGENCE.NameValue(i,"REASON").trim() == "" ){
                    alert("해당 사유는 반드시 입력해야합니다..");
                    dsT_DI_DILIGENCE.RowPosition = i;
                    form1.grdT_DI_DILIGENCE.SetColumn("REASON");
                    return false;
                }
     		}

			if(document.form1.txtREQ_YMD.value == ""){
				alert("신청일자를 입력하십시오.");
				return false;
			}

            if(dsT_DI_APPROVAL.CountRow == 0){
                alert("결재선을 지정하십시오.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("approval_flag").value = "N";//무한루프 방지

			cfStyleGrid(form1.grdT_DI_DILIGENCE,15,"true","false");      // Grid Style 적용

			disableInput();

            document.getElementById("txtGUN_YMD_SHR").value = today;
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";

            fnc_SearchREQ_NO();

            document.getElementById("txtGUN_YMD_SHR").focus();

<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");
			document.getElementById("ImgDptCd").style.display = "none";
<%
    }
%>
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

		/********************************************
         * 그리드 클릭시 근태구분선택 팝업                 			*
         ********************************************/
        function fnc_SearchGun(row, colid) {

        	var orgCD = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_CD");

        	if( colid == "GUN_CD"){
	        	var obj =  new String();
        		obj = fnc_commonCodePopupReturn('근태구분','H4');

        		if(obj != null){

	        		if(obj.comm_cd == dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN")){
	        		    alert("변경전 근태와 변경후 근태가 같습니다.");
	        		    //dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_CD") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_CD");
	        		    return false;
	        		}

	        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_CD") = obj.comm_cd;


        			if(orgCD != "" && orgCD != obj.comm_cd){
		        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "FLAG") = "UPT";
        			}

					if(obj.comm_cd == "Q"){  //기념일 휴가
                        var ATT_Q = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ATT_Q");
                        var ATT_Q_USE = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ATT_Q_USE");
                        var ATT_Q_USE_DTL = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ATT_Q_USE_DTL");

                        if(ATT_Q == ""){
                            alert("기념일 휴가를 사용할 수 없습니다.");
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_CD") = "";
                            return;

                        }else if(parseInt(ATT_Q) < parseInt(ATT_Q_USE)+1 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "Q"){
                            alert("사용가능한 기념일 휴가를 모두 사용하였습니다.");
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_CD") = "";

                        }else{
                            if( ATT_Q == "2" ){
                                if(ATT_Q_USE == "1"){
                                  if(ATT_Q_USE_DTL == "결혼기념"){
                                      dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH") = "본인생일";
                                  }else{
                                      dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH") = "결혼기념";
                                  }

                                }else{
                                    var obj2 =  new String();
                                    obj2 = fnc_commonCodePopupReturn('기념일구분','SG');
                                    if(obj2 != null){
                                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH") = obj2.comm_nm;
                                    }
                                }

                                if(dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH").trim() == ""){
                                    alert("기념일을 선택하지 않았습니다.");
                                    dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_CD") = "";
                                }

                            }else{
                                dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH") = "본인생일";
                            }
                        }

	        		}else if(obj.comm_cd == "I"){  //특별 휴가
   						var obj3 =  new String();
	        			obj3 = fnc_commonCodePopupReturn('특별휴가구분','SF');
    					if(obj3 != null){
    						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH") = obj3.comm_nm;
        				}

	        		}else if(obj.comm_cd == "L"){  //기타
   						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH") = "정직";

	        		}else{//비고가 없으면 공백처리
	        		    dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK_CH") = "";
	        		}
        		}
        	}

        }


		/********************************************
         * 날짜 형식 유효성 체크                    *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

         /********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  			document.form1.txtREQ_YMD.readOnly = false;
	  		document.form1.txtREQ_YMD.className = "";
  			document.getElementById("imgREQ_YMD").disabled = false;
  			document.getElementById("imgREQ_YMD").style.display = "";
  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  			document.form1.txtREQ_YMD.readOnly = true;
	  		document.form1.txtREQ_YMD.className = "input_ReadOnly";
  			document.getElementById("imgREQ_YMD").disabled = true;
  			document.getElementById("imgREQ_YMD").style.display = "none";
  		}

  		/********************************************
         * 신청일자에서 포커스 떠날때 해당근태일자와 비교		*
         ********************************************/
		function cfCheckDateTermUser(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("신청일자가 해당근태일자보다 큽니다.");
					document.getElementById(p_obj).value = "";
				}
			}
		}

		function fnc_SearchREQ_NO(){

           	var DPT_CD_SHR   = document.form1.txtDPT_CD_SHR.value;
            var GUN_YMD_SHR  = document.form1.txtGUN_YMD_SHR.value;

            if(DPT_CD_SHR == ""){
                document.getElementById("req_no_title").innerText = ' ';
                document.getElementById("req_no_cmb").style.display = "none";
                return;
            }
            if(GUN_YMD_SHR == ""){
                document.getElementById("req_no_title").innerText = ' ';
                document.getElementById("req_no_cmb").style.display = "none";
                return;
            }

            //번호가 바뀌므로 초기화
            document.getElementById("cmbREQ_NO_SHR").value = "";

            dsT_DI_DILIGENCE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna050.cmd.GUNA050CMD&S_MODE=SHR_05&DPT_CD_SHR="+DPT_CD_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR;
            dsT_DI_DILIGENCE_01.reset();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		 	   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <Object ID="dsT_DI_DILIGENCE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet(결재선)						   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)		 	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">

		if(dsT_DI_DILIGENCE.NameValue(1, "ENO_NO") == "NOTEXIST"){

                //해당일자에 근태현황이 없을때
				dsT_DI_DILIGENCE.ClearData();
                document.form1.txtCHN_YMD.value = "";
				document.form1.txtDPT_NM.value = "";
				REQ_YMD = "";
				disableInput();
				alert("해당일의 일일근태현황이 등록되지 않았습니다..");

		}else{

			document.form1.txtDPT_NM.value = dsT_DI_DILIGENCE.NameValue(1,"DPT_NM");

			//조회버튼 을 누르면 true가 된다.
		    if(isSHR ){
				// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
				fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);

				for(var i=0; i<=dsT_DI_DILIGENCE.CountRow; i++){
					if(dsT_DI_DILIGENCE.NameValue(i,"REQ_NO") != ""){
					    REQ_NO  = dsT_DI_DILIGENCE.NameValue(i,"REQ_NO");
						REQ_YMD = dsT_DI_DILIGENCE.NameValue(i,"REQ_YMD");
						document.getElementById("txtREQ_YMD").value = REQ_YMD;
						document.getElementById("txtREQ_NO").value = REQ_NO;
						document.getElementById("txtREQ_YMD").focus();

						break;
					}else{
						REQ_YMD = "";
						REQ_NO = "";
						document.getElementById("txtREQ_YMD").value = REQ_YMD;
						document.getElementById("txtREQ_NO").value = REQ_NO;
						document.getElementById("txtREQ_YMD").focus();

					}
				}

			}else{
				fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
			}

        }

    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            //않보인다
            document.getElementById("req_no_title").innerText = ' ';
            document.getElementById("req_no_cmb").style.display = "none";

        } else {
            //보인다.
            document.getElementById("req_no_title").innerText = '신청번호  ';
            document.getElementById("req_no_cmb").style.display = "";

            //삭제후 생성
            document.getElementById("cmbREQ_NO_SHR").options.length = 0;

            //신청번호
            for(var i=1; i<=iCount; i++) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_DI_DILIGENCE_01.NameValue(i,"REQ_NO");
                oOption.text  = dsT_DI_DILIGENCE_01.NameValue(i,"REQ_NO");
                document.getElementById("cmbREQ_NO_SHR").add(oOption);
            }

        }

    </Script>

	<Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
		if (iCount == 0) {

            if(document.getElementById("approval_flag").value == "Y"){//무한루프 방지
              document.getElementById("approval_flag").value = "N";
              return false;
            }

            document.getElementById("approval_flag").value = "Y";//무한루프 방지

			//enableInput();
			disableInput();
			document.getElementById("txtREQ_YMD").value = getToday();


            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA1_APP_STS").innerText  = "";

            document.getElementById("imgSelectapproval").disabled = false;
            document.getElementById("imgSelectapproval").style.display = "";
            document.getElementById("imgAddnew").disabled = true;
            document.getElementById("imgAddnew").style.display = "none";

            var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;
            var GUN_YMD_SHR  = document.getElementById("txtGUN_YMD_SHR").value;

            //조회시 결재선이 지정되어 있지 않으면 최근 결재선 가져오고 없으면 부서장 자동지정
            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna050.cmd.GUNA050CMD&S_MODE=SHR_04&DPT_CD_SHR="+DPT_CD_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR;
            dsT_DI_APPROVAL.Reset();

		} else {

            document.getElementById("approval_flag").value = "N";//무한루프 방지

	        if(dsT_DI_APPROVAL.NameValue(1,"APP_YN") == "결재" || dsT_DI_APPROVAL.NameValue(1,"APP_YN") == "부결"){
	            document.getElementById("imgSelectapproval").disabled = true;
	            document.getElementById("imgSelectapproval").style.display = "none";

                //처음꺼에서만 신청가능
                if(document.getElementById("cmbREQ_NO_SHR").selectedIndex == 0){
	            //if(document.getElementById("cmbREQ_NO_SHR").selectedIndex+1 == document.getElementById("cmbREQ_NO_SHR").options.length){//마지막꺼에서만 재신청 가능
	                document.getElementById("imgAddnew").disabled = false;
	                document.getElementById("imgAddnew").style.display = "";
                }else{
	                document.getElementById("imgAddnew").disabled = true;
	                document.getElementById("imgAddnew").style.display = "none";
                }
	        }else{
                document.getElementById("imgSelectapproval").disabled = false;
                document.getElementById("imgSelectapproval").style.display = "";
                document.getElementById("imgAddnew").disabled = true;
                document.getElementById("imgAddnew").style.display = "none";
	        }

            //결재선 기본값 셋팅 구분
            if(dsT_DI_APPROVAL.NameValue(1,"APP_YN") == ""){
                //결재선 저장이 가능하게 입력상태로 변경
                dsT_DI_APPROVAL.UserStatus(1) = "1";
            }else{
                disableInput();//키값이라 수정 불가
            }


	        var APP_STS = "";
	        var ENO_NM = dsT_DI_APPROVAL.NameValue(1,"ENO_NM");
	        var JOB_NM = dsT_DI_APPROVAL.NameValue(1,"JOB_NM");
	        var APP_YN = dsT_DI_APPROVAL.NameValue(1,"APP_YN");
	        var UPT_YMD = dsT_DI_APPROVAL.NameValue(1,"UPT_YMD");

	        if(UPT_YMD.trim() != ""){
	            APP_STS = APP_YN + " " +"("+UPT_YMD+")";
	        }else{
	            APP_STS = APP_YN
	        }

	        document.getElementById("txtA1_ENO_NM").innerText   = JOB_NM+" "+ENO_NM;
	        document.getElementById("txtA1_APP_STS").innerText  = APP_STS;

        }

        if(dsT_DI_APPROVAL.NameValue(1,"APP_YN") == "결재"){
			document.grdT_DI_DILIGENCE.ColumnProp("GUN_CD", "Show") = "false";
			document.grdT_DI_DILIGENCE.ColumnProp("GUN_CD_CP", "Show") = "true";
			document.grdT_DI_DILIGENCE.ColumnProp("REASON", "Show") = "false";
			document.grdT_DI_DILIGENCE.ColumnProp("REASON_CP", "Show") = "true";
		}else{
			document.grdT_DI_DILIGENCE.ColumnProp("GUN_CD", "Show") = "true";
			document.grdT_DI_DILIGENCE.ColumnProp("GUN_CD_CP", "Show") = "false";
			document.grdT_DI_DILIGENCE.ColumnProp("REASON", "Show") = "true";
			document.grdT_DI_DILIGENCE.ColumnProp("REASON_CP", "Show") = "false";
		}

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnSuccess()">
		// 해당코딩을 입력하세요.
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        alert(trT_DI_DILIGENCE.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Grid 클릭시 근태현황 조회	  							   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_DILIGENCE event=OnClick(row,colid)>
		fnc_SearchGun(row, colid);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태변경신청서</td>
					<td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">근태변경신청서</font></td>
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
			    <input type="hidden"id="approval_flag">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()" style="DISPLAY:none"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- power Search테이블 시작 -->
	<table width="800px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="100"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width="180"></col>
							<col width="80"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">해당근태일자&nbsp;</td>
							<td class="padding2423">
								<input type="text" id="txtGUN_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13){fnc_SearchREQ_NO();fnc_SearchList();}cfDateHyphen(this);cfCheckNumber();" onchange="fnc_SearchREQ_NO();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgGUN_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgGUN_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtGUN_YMD_SHR','','350','109');"></a>
							</td>
                            <td class="searchState" align="right">소속&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13){fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');fnc_SearchREQ_NO();}" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');fnc_SearchREQ_NO();">
                                <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                            </td>
                            <td class="searchState" align="right"><span id="req_no_title">&nbsp;</span></td>
                            <td class="padding2423">
                                <span id="req_no_cmb" style="display:none">
                                    <select id="cmbREQ_NO_SHR" style="width:100" onChange="fnc_SearchList();">
                                    </select>
                                </span>
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
	<table width="800px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8" width="55%">
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="85"></col>
						<col width="125"></col>
						<col width="85"></col>
						<col width=""></col>
					</colgroup>
					<tr>
						<td align="center" class="creamBold">신청번호</td>
						<td class="padding2423"><input id="txtREQ_NO" size="15" class="input_ReadOnly"  readonly></td>
						<td align="center" class="creamBold">신청소속</td>
						<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					</tr>
					<tr>
						<td align="center" class="creamBold">해당근태일자</td>
						<td class="padding2423"><input id="txtCHN_YMD" size="15" class="input_ReadOnly"  readonly></td>
						<td align="center" class="creamBold">신청일자</td>
						<td class="padding2423">
							<input type="text" id="txtREQ_YMD" style="ime-mode:disabled" size="15" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermUser('txtREQ_YMD', 'txtCHN_YMD', 'txtREQ_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgREQ_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgREQ_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtREQ_YMD','','313','201');"></a>
						</td>
					</tr>
				</table>
			</td>
            <td width="15%" align="left">
                &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)">  <img src="/images/button/btn_SelectapprovalOn.gif"   name="imgSelectapproval" width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            </td>
            <td class="paddingTop8">
	            <table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse"  bordercolor="#999999" align="center">
	                 <tr align="center" height="25">
	                     <td rowspan="2" class="creamBold" width="50">결재<br>현황<input type="hidden" id="txtA2_ENO_NO"></td>
	                     <td id="txtA1_ENO_NM" width="120"></td>
	                 </tr>
	                 <tr align="center" height="25">
	                     <td id="txtA1_APP_STS"></td>
	                 </tr>
	             </table>
            </td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->
	</td>
</tr>
</table>

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="450px" align="left" class="paddingTop8">
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
			<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:284px;">
						<param name="DataID" value="dsT_DI_DILIGENCE">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29	name="NO"			align=center	value={String(Currow)}        </C>
							<C> id="DPT_NM"		width=120	name="소속"			align=left		Edit=none	leftMargin="10"   </C>
							<C> id="JOB_NM"		width=90	name="직위"			align=left		Edit=none	leftMargin="10"   </C>
							<C> id="ENO_NO"		width=70	name="사번"			align=center	Edit=none                     </C>
							<C> id="ENO_NM"		width=65	name="성명"			align=center	Edit=none                     </C>
							<G> name="변경전근태"  HeadBgColor="#F7DCBB"
								<C> id="GUN_GBN"		width=45	name="근태"	align=center	Edit=none                     </C>
								<C> id="REMARK"			width=100	name="비고"	align=center	Edit=none                     </C>
							</G>
							<G> name="변경후근태"  HeadBgColor="#F7DCBB"
								<C> id="GUN_CD"			width=45	name="근태"	align=center	Edit=none                     </C>
								<C> id="GUN_CD_CP"		width=45	name="근태"	align=center	Edit=none	show="false"      </C>
								<C> id="REMARK_CH"		width=100	name="비고"	align=center	Edit=none                     </C>
								<C> id="REASON"			width=100	name="사유"	align=left	                                  </C>
								<C> id="REASON_CP"		width=100	name="사유"	align=left  	Edit=none	show="false"      </C>
							</G>
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

</body>
</html>
