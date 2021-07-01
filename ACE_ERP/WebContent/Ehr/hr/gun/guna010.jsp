	<!--*************************************************************************
	* @source      : guna010.jsp												*
	* @description : 일일근태 현황등록 PAGE										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/09            채갑병          	        최초작성				*
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
	<title>일일근태 현황(guna010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var today = getToday();
		var btnList = 'TFTTFFFT';
		var SANG_YN = "N";
        var GBN = "";

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {
			var DPT_CD_SHR  = document.form1.txtDPT_CD_SHR.value;
			var GUN_YMD_SHR  = document.form1.txtGUN_YMD_SHR.value;

			if(DPT_CD_SHR == ""){
				alert("소속을 입력하십시오.");
				return;
			}

            GBN = "SHR";

			trT_DI_DILIGENCE.KeyValue = "tr05(O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY, O:dsO_one=dsT_DI_DILIGENCE, O:dsO_two=dsGun)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna010.cmd.GUNA010CMD&S_MODE=SHR_02&DPT_CD_SHR="+DPT_CD_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR;
			trT_DI_DILIGENCE.post();
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
            var DPT_CD_SHR  = document.form1.txtDPT_CD_SHR.value;
            var GUN_YMD_SHR  = document.form1.txtGUN_YMD_SHR.value;

			//무조건 수정시키기 위해서 작동...
            for(i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
                dsT_DI_DILIGENCE.NameValue(i,"GUN_GBN_CP") = "0";
            }

            GBN = "SAV";

            if ( !fnc_SaveItemCheck() ) {
                return;
            }

			// save (해당 레코드 없으면 개인별 신규생성)
			trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna010.cmd.GUNA010CMD&S_MODE=SAV"+"&DPT_CD_SHR="+DPT_CD_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR;
			trT_DI_DILIGENCE.post();

        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요

            var DPT_CD_SHR = document.getElementById('txtDPT_CD_SHR').value;
			var DPT_NM_SHR = document.getElementById('txtDPT_NM_SHR').value;
            var GUN_YMD_SHR = document.getElementById('txtGUN_YMD_SHR').value;
            var DPT_CNT = document.getElementById('txtDPT_CNT').value;

            var url = "guna010_PV.jsp?DPT_CD_SHR="+DPT_CD_SHR+"&DPT_NM_SHR="+DPT_NM_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR+"&DPT_CNT="+DPT_CNT;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

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
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {

       }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/

        function fnc_Remove() {

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {
			document.form1.txtDPT_CD_SHR.value = '<%=DPTCD %>';
			document.form1.txtDPT_NM_SHR.value = '<%=DPTNM %>';
			//document.form1.txtGUN_YMD_SHR.value = today;

            document.getElementById("resultMessage").innerText = ' ';


        	dsGun.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_DI_DILIGENCE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
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

         	if ( !dsT_DI_DILIGENCE.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
	           return false;
			}

            //관리자는 가능하다.
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
	        /*
			//등록시간 체크 임시 주석 (김우태 대리, 2007-09-05)
			if( new Date().getHours() >= "9"){
				alert("일일 근태 현황등록은 오전 9시 이전에 이루어져야합니다.");
				return false;
			}

			// 근태일자 체크 임시 주석 해제
			var GUN_YMD = dsT_DI_DILIGENCE.NameValue(1, "GUN_YMD");
			if(GUN_YMD != getToday().replace("-","").replace("-","")){
				alert("근태일자가 오늘 날짜가 아닙니다.");
				return false;
			}
			*/
<%
    }
%>

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("approval_flag").value = "N";//무한루프 방지

			document.form1.txtGUN_YMD_SHR.value = today;

			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"true","false");      // Grid Style 적용

			cfStyleGrid(form1.grdGun,0,"true","false");      // Grid Style 적용
			form1.grdGun.HiddenHScroll  = true;
			form1.grdGun.HiddenVScroll  = true;
			form1.grdGun.DisableNoHScroll = false;
			form1.grdGun.DisableNoVScroll = false;
			form1.grdGun.IgnoreSelectionColor = "true";

            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";


<%
    //마스터는 모든부서 통할
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
	   
<%//A 는 자기부서만 통할
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
		  fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
		  fnc_ChangeStateElement(false, "ImgDptCd");
		 document.getElementById("ImgDptCd").style.display = "none";

	     form1.grdT_DI_DILIGENCE.Editable = false;

<%
    }else{
%>
		  fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
		  fnc_ChangeStateElement(false, "ImgDptCd");
		 document.getElementById("ImgDptCd").style.display = "none";

	     form1.grdT_DI_DILIGENCE.Editable = false;

<%
	}
%>


			//권한 및 요일구분 조회
			//dsT_DI_HOLIDAY.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna010.cmd.GUNA010CMD&S_MODE=SHR&GUN_YMD_SHR="+today+"&GUN_DPT="+'<%=DPTCD %>';
			//dsT_DI_HOLIDAY.reset();

			fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 		*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

		/********************************************
         * 그리드 클릭시 근태구분선택 팝업          *
         ********************************************/
        function fnc_SearchGun(row, colid, olddata) {

        	// 아래 GUN_GBN <- 데이타set 의 칼럼명으로 유동적으로 변경해야 함
        	var PrevGBN = "";
        	var PrevRMK = "";

        	if( colid == "POPUP" || colid == "GUN_GBN" ){
	        	var obj =  new String();

	        	if(colid == "POPUP"){//팝업
		        	PrevGBN = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN");
	                PrevRMK = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
                    obj = fnc_commonCodePopupReturn('근태구분','H4');

                }else{//입력
                    PrevGBN = olddata;
                    PrevRMK = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
                    obj.comm_cd = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN");
                    obj.comm_nm = "";
                }

        		if(obj != null ){
	        		var YRP_CNT = parseFloat(dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "YRP_CNT"));
	        		var YRP_USE = parseFloat(dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "YRP_USE"));
	        		var HIR_YMD = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HIR_YMD");//입사일
	        		var GUN_YMD = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_YMD");  //근태일자

        			if(obj.comm_cd == "I"){  //특별 휴가
		        		var obj3 = new String();
		        		obj3 = fnc_commonCodePopupReturn('특별휴가구분','SF');
		        		if(obj3 != null){
			        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
			        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = obj3.comm_nm;
			        	}

	        		}else if(obj.comm_cd == "T"){  //대체 휴가
                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";

	        		}else if(obj.comm_cd == "U"){  //대체 반차

                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";

	        		}else if(obj.comm_cd == "V"){  //대체+연반차

                        if(HIR_YMD.substring(0,4) == GUN_YMD.substring(0,4)){//올해입사자 여부
                            alert("올해 입사자이므로 대체+선연반차를 사용합니다.");
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
                        }else if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "V"){
                            alert("연반차가 부족해 대체+연반차를 사용할 수 없습니다.");
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
                        }else{
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
                        }
	        		}else if(obj.comm_cd == "J"){  //여직원휴가
		        		var MF_TAG = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "MF_TAG");  // 남/녀 구분
		        		if(MF_TAG == "M"){
		        			alert("여직원휴가는 선택할 수 없습니다.");
		        			if(PrevGBN==""){
		        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = "W";
		        			}else{
		        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = PrevGBN;
		        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK")  = PrevRMK;
		        			}
		        		}else{
			        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
		        		}

        			}else if(obj.comm_cd == "L"){//기타
	        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
	        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "정직";

	        		}else{
						if(HIR_YMD.substring(0,4) == GUN_YMD.substring(0,4)){//올해입사자 여부
		        			if(obj.comm_cd == "H"){
								if(YRP_CNT < YRP_USE+1 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "H"){
		        					alert("올해 입사자이므로 선연차를 사용합니다.");
	        					}
		        			}
		        			if(obj.comm_cd == "P"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "P"){
		        					alert("올해 입사자이므로 오전선연반차를 사용합니다.");
	        					}
		        			 }
		        			if(obj.comm_cd == "R"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "R"){
		        					alert("올해 입사자이므로 오후선연반차를 사용합니다.");
	        					}
		        			}
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
						}else{
		        			if(obj.comm_cd == "H"){
								if(YRP_CNT < YRP_USE+1 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "H"){
		        					alert("연차를 사용할 수 없습니다.");
	        					}
		        			}
		        			if(obj.comm_cd == "P"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "P"){
		        					alert("오전연반차를 사용할 수 없습니다.");
	        					}
		        			 }
		        			if(obj.comm_cd == "R"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "R"){
		        					alert("오후연반차를 사용할 수 없습니다.");
	        					}
		        			}
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
	        			}
	        		}

	        		var orgGUN_GBN = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN");

       				// 특별휴가(신규,수정,삭제 구분)
	        		if( orgGUN_GBN != "I" && obj.comm_cd == "I" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // 신규
       				}else if( orgGUN_GBN == "I" && obj.comm_cd == "I" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // 수정
       				}else if( orgGUN_GBN == "I" && obj.comm_cd != "I" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // 삭제
       				}

       				// 대체휴가(신규,수정,삭제 구분)
	        		if( orgGUN_GBN != "T" && obj.comm_cd == "T" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // 신규
       				}else if( orgGUN_GBN == "T" && obj.comm_cd == "T" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // 수정
       				}else if( orgGUN_GBN == "T" && obj.comm_cd != "T" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // 삭제
        				//삭제정보를 위해 임시로 넣었다. 둘다 HOL_YMD사용
        				//dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HOL_YMD") = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
       				}

       				// 대체반차(신규,수정,삭제 구분)
	        		if( orgGUN_GBN != "U" && obj.comm_cd == "U" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // 신규
       				}else if( orgGUN_GBN == "U" && obj.comm_cd == "U" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // 수정
       				}else if( orgGUN_GBN == "U" && obj.comm_cd != "U" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // 삭제
        				//삭제정보를 위해 임시로 넣었다. 둘다 HOL_YMD사용
        				//dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HOL_YMD") = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
       				}

       				// 대체+연반차(신규,수정,삭제 구분)
	        		if( orgGUN_GBN != "V" && obj.comm_cd == "V" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // 신규
       				}else if( orgGUN_GBN == "V" && obj.comm_cd == "V" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // 수정
       				}else if( orgGUN_GBN == "V" && obj.comm_cd != "V" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // 삭제
        				//삭제정보를 위해 임시로 넣었다. 둘다 HOL_YMD사용
        				//dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HOL_YMD") = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
       				}

       				// 기타
	        		if( orgGUN_GBN != "L" && obj.comm_cd == "L" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // 신규
       				}else if( orgGUN_GBN == "L" && obj.comm_cd == "L" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // 수정
       				}else if( orgGUN_GBN == "L" && obj.comm_cd != "L" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // 삭제
       				}

       				if( orgGUN_GBN == "Q" || orgGUN_GBN == "I" || orgGUN_GBN == "T" || orgGUN_GBN == "U" || orgGUN_GBN == "V" || orgGUN_GBN == "L" ){
       					if(obj.comm_cd == "Q" || obj.comm_cd == "I" || obj.comm_cd == "T" || obj.comm_cd == "U" || obj.comm_cd == "V" || obj.comm_cd == "L"){
	        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "REP"; // 대체
       					}
       				}
					//alert("DTL_STS : "+dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS"));

	        	}
        	}
        }
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
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

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet(권한 조회용)						   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_HOLIDAY)			   |
    | 3. 사용되는 Table List(T_DI_HOLIDAY) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet(근태집계 조회용)						   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		 	   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsGun" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">
    //alert("1:dsT_DI_HOLIDAY");
            document.form1.txtHOL_GBN.value    = dsT_DI_HOLIDAY.NameValue(1, "HOL_GBN");
    </Script>

	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
    //alert("2:dsT_DI_DILIGENCE");
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			document.form1.txtDPT_CNT.value = "0";
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);

			document.form1.txtDPT_CNT.value = dsT_DI_DILIGENCE.NameValue(1, "DPT_CNT");

			// 최초 조회시 근태구분 공백일 경우 (W:정상출근) 으로 세팅
			for(var i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
				if( dsT_DI_DILIGENCE.NameValue(i, "GUN_GBN") == "" ){
					//dsT_DI_DILIGENCE.NameValue(i, "GUN_GBN") = "W";

		            // 휴일이면 Y세팅
		            if( dsT_DI_HOLIDAY.NameValue(1, "HOL_GBN") != "평일" ){ // 휴일
                      dsT_DI_DILIGENCE.NameValue(i, "GUN_GBN") = "Y";
                    }
				}
			}
        }

    </Script>

	<Script For=dsGun Event="OnLoadCompleted(iCount)">
    //alert("3:dsGun");
		if (iCount == 0)    {
			// 필요한 소스 구현
		} else {
			// 필요한 소스 구현
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
        //alert("trT_DI_DILIGENCE");
        if(GBN == "SAV"){
            fnc_SearchList();
		    fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        }
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        alert(trT_DI_DILIGENCE.ErrorMsg);
    </script>

<%
    //조회만 가능하게..
    if(!box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
	<!-----------------------------------------------------+
    | Grid 클릭시 근태현황 조회	  							   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_DILIGENCE event=OnClick(row,colid)>
		/*
        if(colid == "POPUP"){
            fnc_SearchGun(row, colid);
        }
		*/
	</script>
<%
    }
%>

	<script language="javascript"  for=grdT_DI_DILIGENCE event=OnExit(row,colid,olddata)>

	    var GUN_GBN = dsT_DI_DILIGENCE.NameValue(row,colid);
	    var HOL_GBN = dsT_DI_HOLIDAY.NameValue(1, "HOL_GBN");

        /*
	    alert("Occur OnEnter Event :" + "<row :" + row +">" +
	          "<colid :" + colid + ">" +
	          "<Before Data :" + olddata +
	          "> -->"+GUN_GBN );
	    */

	    //유효코드 확인
	    for(i=1; i<=dsGun.CountRow; i++){
            if(dsGun.NameValue(i,"GUN_GBN1").substring(0,1) == GUN_GBN || dsGun.NameValue(i,"GUN_GBN2").substring(0,1) == GUN_GBN){

                //일일근태 휴일에 입력가능한 코드 : 출장(E), 훈련(G), 휴직(K), 휴일(Y), 정상(W), 교육(F), 기타(L)
                if( (HOL_GBN == "휴일" || HOL_GBN == "특별휴일") &&
                    (GUN_GBN != "E" && GUN_GBN != "G" && GUN_GBN != "K" && GUN_GBN != "Y" && GUN_GBN != "W" && GUN_GBN != "F" && GUN_GBN != "L") ){

                    alert("휴일에는 해당 근태항목을 등록할 수 없습니다.");
                    dsT_DI_DILIGENCE.NameValue(row,colid) = olddata;
                    return false;
                }

                fnc_SearchGun(row, colid, olddata);
                return true;
	        }
        }

        alert("잘못된 근태항목입니다. 근태코드를 확인하세요.");
        dsT_DI_DILIGENCE.NameValue(row,colid) = olddata;
        return false;

    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">일일근태 현황</td>
					<td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">일일근태 현황</font></td>
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
				<!--
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				-->
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<!--
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print();"></a>
			-->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="30"></col>
							<col width="145"></col>
							<col width="60"></col>
							<col width="100"></col>
							<col width="30"></col>
							<col width="70"></col>
							<col width="40"></col>
							<col width="35"></col>
							<col width="55"></col>
							<col width="70"></col>
							<col width="30"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">소속</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13){fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');fnc_SearchList();}"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');fnc_SearchList();">
								<input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
		                        	<img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT');fnc_SearchList();">
	                        	</a>
							</td>
							<td class="searchState" align="right">근태일자</td>
							<td class="padding2423" align="left"><input id="txtGUN_YMD_SHR" size="10" maxLength="10" onblur="cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGUN_YMD_SHR','','190','115');"></a></td>
							<td class="searchState" align="right">총인원</td>
							<td class="padding2423" align="left"><input id="txtDPT_CNT" size="4" class="input_ReadOnly"  readonly></td>
							<td class="searchState" align="right">요일구분</td>
							<td class="padding2423" align="left"><input id="txtHOL_GBN" size="10" class="input_ReadOnly"  readonly></td>
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
				<tr align="center" valign="middle" height="55">
					<td rowspan="4">
						<comment id="__NSID__">
						<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:460px;height:348px;">
							<param name="DataID" value="dsT_DI_DILIGENCE">
							<param name="Editable" value="false">
							<param name="DragDropEnable" value="true">
							<param name="SortView" value="Left">
							<param name="Format" value='
								<C> id="{CUROW}"	width=35	name="NO"			align=center	value={String(Currow)}      </C>
								<C> id="JOB_NM"		width=50	name="직위"			align=center	Edit=none                   </C>
								<C> id="ENO_NO"		width=80	name="사번"			align=center	Edit=none                   </C>
								<C> id="ENO_NM"		width=80	name="성명"			align=center	Edit=none                   </C>
								<C> id="GUN_GBN"	width=54	name="근태항목"		align=center	Edit=none                 </C>
								<C> id="GUN_GBN_CP"	width=54	name="근태항목"		align=center	Edit=none	show="false"    </C>
								<C> id="POPUP"      width=20    name=" "            align=center    Edit=none                   </C>
								<C> id="POPUP_CP"   width=20    name=" "            align=center    Edit=none   show="false"    </C>
								<C> id="REMARK"		width=120	name="비고"			align=left		Edit=none	leftmargin="10"	</C>
							'>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td class="paddingTop3">
						<img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> 근태집계
					</td>
				</tr>
				<tr>
					<td>
					<comment id="__NSID__">
					<object id="grdGun" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:340px;height:276px;">
						<param name="DataID" value="dsGun">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="GUN_GBN1"		width=113	name="근태"			align=left		Edit=none	leftmargin="10"</C>
							<C> id="GUN_CNT1"		width=55	name="계"			align=right 	Edit=none	rightmargin="10"</C>
							<C> id="GUN_GBN2"		width=113	name="근태"			align=left		Edit=none	leftmargin="10"</C>
							<C> id="GUN_CNT2"		width=55	name="계"			align=right		Edit=none	rightmargin="10"</C>
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
