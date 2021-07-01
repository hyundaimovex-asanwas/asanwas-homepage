<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%/******************************************************************************
 * 시스템명 	 : 블럭확정
 * 프로그램ID 	 : RM520I
 * J  S  P		 : rm520i
 * 서 블 릿		 : RM520I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-06-19
 * 기능정의		 : 블럭확정 (조회, 저장, 삭제, 취소)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-11-12][심동현] 개성관광 추가에 따른 사업소 선택콤보 추가 및 검색조건 정리. 
 * [2008-11-10][박경국]	검색메뉴 추가 : 실적유무
 * [2017-02-07][심동현] 오라클 버전으로 수정 ㅋ. java, procedure까지
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	//날짜기본값
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat(
			"yyyyMMdd");
	String firstday = m_today.format(date.getTime());
	date.add(date.MONTH, 1);
	String lastday = m_today.format(date.getTime());
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/*=============================================================================
	Developer Java Script
   =============================================================================*/
%>
<script language="javascript">
	var v_job = "H";

	var v_btn_auth = "S";	//select (기본값)
	//get_cookdata();
	
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();

		//메뉴 내 수정 권한: 2008-11-10 BY 심동현
//		ds_btnAuth.DataId = "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>BtnAuth?proType=S&dsType=1&userid=2030003&tree_idx=555";//테스트용.
		ds_btnAuth.DataId = "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>BtnAuth?proType=S&dsType=1&userid=<%=(String)session.getAttribute("vusrid")%>&tree_idx="+tree_idx;//서버용.
		//alert(ds_btnAuth.DataId);
		ds_btnAuth.Reset();
		
	}
	/*
	 * 데이타셋 헤더 설정
	 */
	function fnSetHeader(){
	}
	/*
	 * 선조회
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=lastday%>';

		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");
		fnSetHeader();
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        //모객률타입, 보증금율
        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm520I",
            "JSP(O:DS4=ds4,O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);

		//사업소 (help/CommonH.java)
        ds10.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds10.Reset(); //지역코드      

        //조회조건
        ds9.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM016&s_Item1=Y";
        ds9.Reset();
        //블록상태
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM010&s_Item1=Y";
        ds3.Reset();
        //상품정보
//        ds7.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
//        ds7.Reset();
        //객실타입
        ds8.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds8.Reset();
        //대리점
        ds6.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds6.Reset();

	}
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( ( sBgnDate.text.trim() == '' ||  sEndDate.text.trim() == '' ) &&  ( sAcceptBgnDate.text.trim() == '' ||  sAcceptEndDate.text.trim() == '' ) && ( sTlBgnDate.text.trim() == '' ||  sTlEndDate.text.trim() == '' ) ) {
			alert("출발일자, 신청일자, T/L일자 중에 적어도 하나는 입력해 주세요.");
			return;
		}
		if (ds1.isUpdated || ds2.IsUpdated ) {
			alert("수정중인 행이 있습니다.");
		} else {
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sEndDate=" + sEndDate.text +","
	            + "sClientSid=" + sClientSid.value + ","
	            + "sGoodsSid=" + ds7.namevalue(ds7.rowposition,"goods_sid") + ","
            	+ "sBlockStatusCd=" + ds3.namevalue(ds3.rowposition,"detail") + ","
	            + "sAcceptBgnDate=" + sAcceptBgnDate.text + ","
	            + "sAcceptEndDate=" + sAcceptEndDate.text + ","
	            + "sTlBgnDate=" + sTlBgnDate.text + ","
	            + "sTlEndDate=" + sTlEndDate.text + ","
	            + "sQTypeCd=" + ds9.namevalue(ds9.rowposition,"detail") + ","
	            + "sQTypeStr=" + sQTypeStr.value + ","
	            + "sBlockNo=" + sBlockNo.value + ","
                + "sSaupSid=" + ds10.namevalue(ds10.rowposition,"saup_sid") + ","
                if ( sResultsYn.checked == true ) {
		            param += "sResultsYn=Y";
        	    } else {
	        	    param += "sResultsYn=N";            
	            }
               
	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm520I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*	 * 상품 조회	 */		
	function fnSelectDs1() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds10.namevalue(ds10.rowposition,"saup_sid");	

        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm520I",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr2);
	}	  
    
	/*
	 *  디테일조회
	 */
    function fnSelectDetail() {
		if (ds2.IsUpdated ) {
			alert("수정중인 행이 있습니다.");
		} else {
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sEndDate=" + sEndDate.text +","
	            + "sClientSid=" + sClientSid.value + ","
	            + "sGoodsSid=" + ds7.namevalue(ds7.rowposition,"goods_sid") + ","
            	+ "sBlockStatusCd=" + ds3.namevalue(ds3.rowposition,"detail") + ","
	            + "sAcceptBgnDate=" + sAcceptBgnDate.text + ","
	            + "sAcceptEndDate=" + sAcceptEndDate.text + ","
	            + "sTlBgnDate=" + sTlBgnDate.text + ","
	            + "sTlEndDate=" + sTlEndDate.text + ","
	            + "sQTypeCd=" + ds9.namevalue(ds9.rowposition,"detail") + ","
	            + "sQTypeStr=" + sQTypeStr.value + ","
	            + "sBlockNo=" + sBlockNo.value + ","
	            + "sMBlockSid=" + ds1.namevalue(ds1.rowposition,"m_block_sid");
	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm520I",
	            "JSP(O:DS2=ds2)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * 행추가(그리드별)
	 */
	function fnAddRow() {
		if(v_btn_auth=="S"){		//Select 권한
			alert("현재 사용자는 권한이 없습니다.");
		}else if("U"==v_btn_auth){	//Update 권한
			
			if (ds1.countrow < 1){
				alert("조회를 먼저해주세요.");
			} else {
				ds2.addrow();
				ds2.namevalue(ds2.rowposition,"select_div") = '';
				ds2.namevalue(ds2.rowposition,"m_block_sid")=ds1.namevalue(ds1.rowposition,"m_block_sid");
				ds2.namevalue(ds2.rowposition,"depart_date")=ds1.namevalue(ds1.rowposition,"depart_date");
				ds2.namevalue(ds2.rowposition,"nights")=ds1.namevalue(ds1.rowposition,"nights");
				//객실타입명 setting
				if ( ds1.namevalue(ds1.rowposition,"goods_sid") == '30' ) {
					ds2.namevalue(ds2.rowposition,"c_room_type_cd") = '1DBZO';
			        var flag = false;
		            for(var i=1; i<=ds8.CountRow; i++){
		                if(ds8.NameValue(i, "room_type_cd")==ds2.NameValue(ds2.rowposition, "c_room_type_cd")){
		                    ds2.NameValue(ds2.rowposition, "c_room_type_sid") = ds8.NameValue(i, "room_type_sid");
		                    ds2.NameValue(ds2.rowposition, "c_room_type_nm") = ds8.NameValue(i, "room_type_nm");
		                    ds2.NameValue(ds2.rowposition, "std_persons") = ds8.NameValue(i, "std_persons");
			                flag = true;
		                    return;
		                }
		            }
		            if(!flag) {
		                ds2.NameValue(ds2.rowposition, "c_room_type_sid") = 0;
		                ds2.NameValue(ds2.rowposition, "c_room_type_nm") = "";
		                ds2.NameValue(ds2.rowposition, "std_persons") = 0;
	                }
					//인원 = 표준인원 * 객실수
			        ds2.namevalue(ds2.RowPosition,"confirm_persons") = ds2.namevalue(ds2.RowPosition,"std_persons") * ds2.namevalue(ds2.RowPosition,"c_room_cnt");
		        }
			}
			
		}//if(v_btn_auth=="S"){		//Select 권한
	}
	/*
	 * 행삭제(그리드별)
	 */
	function fnDeleteRow() {
		if(v_btn_auth=="S"){		//Select 권한
			alert("현재 사용자는 권한이 없습니다.");
		}else if("U"==v_btn_auth){	//Update 권한

			if (ds1.countrow < 1){
				alert("조회를 먼저해주세요.");
			} else {
				ds2.deleterow(ds2.rowposition);
			}
			gr2.focus();
			
		}//if(v_btn_auth=="S"){
	}
	/*
	 * 적용
	 */
	function fnApply() {
		if(v_btn_auth=="S"){		//Select 권한
			alert("현재 사용자는 권한이 없습니다.");
		}else if("U"==v_btn_auth){	//Update 권한
			
			if (ds1.countrow < 1){
				alert("조회를 먼저해주세요.");
			}else{
		         v_job = "I";
		         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
					for (i=1;i<=ds2.CountRow;i++ )  {
						if (ds2.RowStatus(i) == 1 || ds2.RowStatus(i) == 3 ) {
							if ((ds2.NameValue(i, "block_status_cd") == "OK") && (ds2.NameValue(i, "tl_date") == '')) {
								alert("T/L 일자를 입력하십시오.");
								return;
							}
						}
					}
	
		         ln_TRSetting(tr1,
		             "<%=dirPath%><%=HDConstant.PATH_RM%>Rm520I",
		             "JSP(I:DEFAULT=ds2,O:msgDS=msgDS)",
		             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
		         tr_post(tr1);
	         }


		}//if(v_btn_auth=="S"){
			
	}
	/*
	 * 취소
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
		if (ds2.IsUpdated ) {
			ds2.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
		ds2.rowposition=ds1.rowposition;
	}
	/*
	 * 대리점팝업
	 */
	function fnPopup() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	}
	/*
	 * 대리점, 상품정보 자동셋팅(조건)
	 */
	function fnSetting(dataSet) {
		var exit=false;
		if ( dataSet == 'ds6' ) {	//대리점
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if (ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = 0;
				sClientNm.value = '';
			}
		}
	}
	
    </script>

<%/*=============================================================================
			 Gauce Components Event Scripts
	=============================================================================*/
%>
<script language="javascript" for=gr1 event=OnClick(row,colid)>
			fnSelectDetail();
		</script>

<script language="javascript" for=gr2 event=OnClick(row,colid)>
			if ( row > 0 )
				ds1.rowposition=ds1.NameValueRow("block_sid",ds2.namevalue(row,"block_sid"));
		</script>

<script language=JavaScript for=gr2 event=OnDblClick(row,colid)>
			if ( row > 0 )
				ds1.rowposition=ds1.NameValueRow("block_sid",ds2.namevalue(row,"block_sid"));
		</script>

<script language="javascript" for=gr2
   event=OnColumnPosChanged(row,colid)>
<%//			if ( ds2.RowStatus(row) == 0) {
//				if(ds2.namevalue(row,"block_status_cd") =='OK' ){
//					gr2.ColumnProp('block_status_cd','Edit')='None';
//					gr2.ColumnProp('c_room_type_cd','Edit')='None';
//					gr2.ColumnProp('c_room_cnt','Edit')='None';
//					gr2.ColumnProp('confirm_persons','Edit')='None';
//					gr2.ColumnProp('tl_date','Edit')='None';
//					gr2.ColumnProp('plan_pay_date','Edit')='None';
//					gr2.ColumnProp('cust_rate_type','Edit')='None';
//					gr2.ColumnProp('deposit_rate','Edit')='None';
//					gr2.ColumnProp('c_remarks','Edit')='None';
//				}	else {
//					gr2.ColumnProp('block_status_cd','Edit')='';
//					gr2.ColumnProp('c_room_type_cd','Edit')='';
//					gr2.ColumnProp('c_room_cnt','Edit')='';
//					gr2.ColumnProp('confirm_persons','Edit')='';
//					gr2.ColumnProp('tl_date','Edit')='';
//					gr2.ColumnProp('plan_pay_date','Edit')='';
//					gr2.ColumnProp('cust_rate_type','Edit')='';
//					gr2.ColumnProp('deposit_rate','Edit')='';
//					gr2.ColumnProp('c_remarks','Edit')='';
//				}
//			} else {
//				gr2.ColumnProp('block_status_cd','Edit')='';
//				gr2.ColumnProp('c_room_type_cd','Edit')='';
//				gr2.ColumnProp('c_room_cnt','Edit')='';
//				gr2.ColumnProp('confirm_persons','Edit')='';
//				gr2.ColumnProp('tl_date','Edit')='';
//				gr2.ColumnProp('plan_pay_date','Edit')='';
//				gr2.ColumnProp('cust_rate_type','Edit')='';
//				gr2.ColumnProp('deposit_rate','Edit')='';
//				gr2.ColumnProp('c_remarks','Edit')='';
//			}
%>
			if ( ds2.RowStatus(row) == 0) {
				if(ds2.namevalue(row,"block_status_cd") =='OK' ){
				gr2.ColumnProp('block_status_cd','Edit')='';
				gr2.ColumnProp('c_room_type_cd','Edit')='';
				gr2.ColumnProp('c_room_cnt','Edit')='';
				gr2.ColumnProp('confirm_persons','Edit')='';
				gr2.ColumnProp('tl_date','Edit')='';
				gr2.ColumnProp('plan_pay_date','Edit')='';
				gr2.ColumnProp('cust_rate_type','Edit')='';
				gr2.ColumnProp('deposit_rate','Edit')='';
				gr2.ColumnProp('c_remarks','Edit')='';
				}
			}
		</script>

	<script language=JavaScript for=gr2 event=OnPopup(row,colid,data)>
	        if(colid=="c_room_type_cd") {
	            var arrParam    = new Array();
	            var arrResult   = new Array();
	            var strURL;
	            var strPos;
				//객실타입정보
	            strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
	            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	            arrResult = showModalDialog(strURL,arrParam,strPos);
	            if (arrResult != undefined) {
	                arrParam = arrResult.split(";");
	                ds2.namevalue(ds2.RowPosition,"c_room_type_sid")=arrParam[0];
	                ds2.namevalue(ds2.RowPosition,"c_room_type_cd")=arrParam[1];
	                ds2.namevalue(ds2.RowPosition,"c_room_type_nm")=arrParam[2];
	                ds2.namevalue(ds2.RowPosition,"std_persons")=arrParam[4];
	            } else {
	                ds2.namevalue(ds2.RowPosition,"c_room_type_sid")=0;
	                ds2.namevalue(ds2.RowPosition,"c_room_type_cd")='';
	                ds2.namevalue(ds2.RowPosition,"c_room_type_nm")='';
	                ds2.namevalue(ds2.RowPosition,"std_persons")=0;
	            }
				//인원 = 표준인원 * 객실수
	            ds2.namevalue(ds2.RowPosition,"confirm_persons") = ds2.namevalue(ds2.RowPosition,"std_persons") * ds2.namevalue(ds2.RowPosition,"c_room_cnt");
	        }
	</script>

	<script language=JavaScript for=gr2 event=OnExit(row,colid,olddata)>
			if ( colid == 'c_room_cnt' ) {
				//인원 = 표준인원 * 객실수
				if ( olddata != ds2.namevalue(ds2.RowPosition,"c_room_cnt") )
			        ds2.namevalue(ds2.RowPosition,"confirm_persons") = ds2.namevalue(ds2.RowPosition,"std_persons") * ds2.namevalue(ds2.RowPosition,"c_room_cnt");
			}
			//객실타입명 setting
	        var flag = false;
	        if(colid=='c_room_type_cd'){
	            for(var i=1; i<=ds8.CountRow; i++){
	                if(ds8.NameValue(i, "room_type_cd")==ds2.NameValue(row, colid)){
	                    ds2.NameValue(row, "c_room_type_sid") = ds8.NameValue(i, "room_type_sid");
	                    ds2.NameValue(row, "c_room_type_nm") = ds8.NameValue(i, "room_type_nm");
	                    ds2.NameValue(row, "std_persons") = ds8.NameValue(i, "std_persons");
		                flag = true;
	                    return;
	                }
	            }
	            if(!flag) {
	                ds2.NameValue(row, "c_room_type_sid") = 0;
	                ds2.NameValue(row, "c_room_type_nm") = "";
	                ds2.NameValue(row, "std_persons") = 0;
                }
				//인원 = 표준인원 * 객실수
		        ds2.namevalue(ds2.RowPosition,"confirm_persons") = ds2.namevalue(ds2.RowPosition,"std_persons") * ds2.namevalue(ds2.RowPosition,"c_room_cnt");
	        }
	</script>

<!-- <script language=JavaScript for=gr2 event=OnCloseUp(row,colid)>
			if ( colid == 'block_status_cd' ) {
			   if (ds1.OrgNameValue(ds2.rowposition, "block_status_cd") == 'UK') {
               return;
			   } else if (ds2.namevalue(ds2.rowposition,"block_status_cd") == 'OK' || ds2.namevalue(ds2.rowposition,"block_status_cd") == 'DK' ) {
					ds2.namevalue(ds2.rowposition,"c_room_type_sid") = ds1.namevalue(ds1.rowposition,"a_room_type_sid");
					ds2.namevalue(ds2.rowposition,"c_room_type_cd") = ds1.namevalue(ds1.rowposition,"a_room_type_cd");
					ds2.namevalue(ds2.rowposition,"c_room_type_nm") = ds1.namevalue(ds1.rowposition,"a_room_type_nm");
					ds2.namevalue(ds2.rowposition,"c_room_cnt") = ds1.namevalue(ds1.rowposition,"a_room_cnt");
					ds2.namevalue(ds2.rowposition,"std_persons") = ds1.namevalue(ds1.rowposition,"a_std_persons");
					ds2.namevalue(ds2.rowposition,"confirm_persons") = ds1.namevalue(ds1.rowposition,"accept_persons");
				}
			}
		</script>
-->
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
	        if( sBgnDate.Modified == true )
				sEndDate.text = sBgnDate.text;
	</script>

	<script language=JavaScript for=sAcceptBgnDate event=OnKillFocus()>
	        if( sAcceptBgnDate.Modified == true )
				sAcceptEndDate.text = sAcceptBgnDate.text;
	</script>

	<script language=JavaScript for=sTlBgnDate event=OnKillFocus()>
	        if( sTlBgnDate.Modified == true )
				sTlEndDate.text = sTlBgnDate.text;
	</script>

	<script language="javascript" for=gr2  event=OnColumnPosChanged(row,colid)>
			if ( ds2.namevalue(row,"select_div") == 'Y' ) {
				gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFD253";
				gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFD253";
				gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
				gr2.SelectionColorProp("EditCol", "BgColor") = "#FFD253";
				gr2.SelectionColorProp("EditRow", "BgColor") = "";
				gr2.SelectionColorProp("CurCol", "BgColor") = "#FFD253";
				gr2.SelectionColorProp("CurRow", "BgColor") = "";
				gr2.SelectionColorProp("SelRow", "BgColor") = "";
			} else if ( ds2.namevalue(row,"select_div") == 'N' ) {
				if ( ds2.namevalue(ds2.rowposition,"block_status_cd") == 'RQ' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#D8D5D5";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#D8D5D5";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#D8D5D5";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#D8D5D5";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";
				}
			} else {
				gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF";
				gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF";
				gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
				gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF";
				gr2.SelectionColorProp("EditRow", "BgColor") = "";
				gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF";
				gr2.SelectionColorProp("CurRow", "BgColor") = "";
				gr2.SelectionColorProp("SelRow", "BgColor") = "";
			}
	</script>
	
<%/*=============================================================================
			 Transaction Component's Event Message Scripts
    =============================================================================*/
%>

<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업성공
%>
<script language="javascript" for="tr1" event="onsuccess()">
         var selectDiv = 'Y';
         var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            for ( i=1; i<=msgDS.CountRow; i++ ) {
               if (msgDS.NameValue(i, "pYn") == 'N') {
            		selectDiv='N';
               }
            	msg+=msgDS.NameValue(i, "pMsg")+"\n";
           	}
            if (msgDS.CountRow > 0 ) {
	          	alert(msg);
	          	msgDS.ClearAll();
            }
	        if (selectDiv != 'N' )
				fnSelect();
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%///////////////////////////////////////////////////////////////////////////////
			// Description	:  작업실패

			%>
<script language="javascript" for="tr1" event="onfail()">
   if (v_job=="I") {
      window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
   } else if(v_job == "H" || v_job=="S")
      window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

   var alertMsg = '';
   var nErrCnt = tr1.SrvErrCount("ERROR");

   for(i = 0; i < nErrCnt; i++)
      alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";

   if(nErrCnt > 0 )
      alert(alertMsg);

   //메시지 처리
   var msg='';
   for(j=1; j<=msgDS.CountRow; j++ )
      msg+=msgDS.namevalue(j,"pMsg")+"\n";

   if (msgDS.CountRow > 0 ) {
      alert(msg);
      msgDS.ClearData();
   }

</script>

<%///////////////////////////////////////////////////////////////////////////////
			// Description	:  작업성공
%>
<script language="javascript" for="tr2" event="onsuccess()">
	</script>
<%
			///////////////////////////////////////////////////////////////////////////////
			// Description	:  작업실패

			%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>
	
	<script language=JavaScript for=lc_area event=OnSelChange()>
			fnSelectDs1();
	</script>	
<%/*=============================================================================
			 DataSet Component's Event Message Scripts
	=============================================================================*/
%>
<script language=JavaScript for=ds1 event="OnLoadStarted()">
	 window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language=JavaScript for=ds1 event="OnLoadCompleted(row)">
	if ( ds1.CountRow > 0 )
		fnSelectDetail();
</script>

<script language=JavaScript for=ds2 event="OnLoadCompleted(row)">
	for ( i=1;i<=ds2.CountRow;i++ ) {
		if ( eval(ds1.namevalue(ds1.rowposition,"depart_date")) < eval(ds2.namevalue(i,"tl_date")) ) {
			ds2.namevalue(i,"select_div") = 'Y';
		} else {
			ds2.namevalue(i,"select_div") = 'N';
		}
	}
	if ( ds2.namevalue(ds2.rowposition,"select_div") == 'Y' ) {
		gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFD253";
		gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
		gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFD253";
		gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
		gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
		gr2.SelectionColorProp("EditCol", "BgColor") = "#FFD253";
		gr2.SelectionColorProp("EditRow", "BgColor") = "";
		gr2.SelectionColorProp("CurCol", "BgColor") = "#FFD253";
		gr2.SelectionColorProp("CurRow", "BgColor") = "";
		gr2.SelectionColorProp("SelRow", "BgColor") = "";
	} else if ( ds2.namevalue(ds2.rowposition,"select_div") == 'N' ) {
		if ( ds2.namevalue(ds2.rowposition,"block_status_cd") == 'RQ' ) {
			gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF";
			gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
			gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF";
			gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
			gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
			gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF";
			gr2.SelectionColorProp("EditRow", "BgColor") = "";
			gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF";
			gr2.SelectionColorProp("CurRow", "BgColor") = "";
			gr2.SelectionColorProp("SelRow", "BgColor") = "";
		} else {
			gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#D8D5D5";
			gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
			gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#D8D5D5";
			gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
			gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
			gr2.SelectionColorProp("EditCol", "BgColor") = "#D8D5D5";
			gr2.SelectionColorProp("EditRow", "BgColor") = "";
			gr2.SelectionColorProp("CurCol", "BgColor") = "#D8D5D5";
			gr2.SelectionColorProp("CurRow", "BgColor") = "";
			gr2.SelectionColorProp("SelRow", "BgColor") = "";
		}
	}
	ds2.ResetStatus();
</script>

<script language=JavaScript for=ds8 event="OnLoadCompleted(row)">
	window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
</script>

<script language=JavaScript for=ds_btnAuth event=OnLoadCompleted(rowcnt)>
	if(rowcnt==0){
		v_btn_auth = "S";
	}else{		
		v_btn_auth = ds_btnAuth.NameValue(1, "BTN_AUTH");
	}
</script>
<%/*=============================================================================
			 DataSet Components(DS) 선언
   =============================================================================*/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value=false>
</object>
<!--  블록상태 -->
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value=false>
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>
<!--  대리점  -->
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>
<!--  상품정보 -->
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>
<!--   객실타입 -->
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>
<!--   조회조건 -->
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>
<!--   사업소  -->
<object id=ds10 classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>

<object id=ds_btnAuth classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<!-- 메시지  -->
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
   <param name="SyncLoad" value="False">
</object>
<object id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
   <param name="ServerIP" value="">
   <param name="Action" value="">
   <param name="KeyName" value="">
   <param name="KeyValue" value="">
   <param name="Parameters" value="">
</object>
<object id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
   <param name="ServerIP" value="">
   <param name="Action" value="">
   <param name="KeyName" value="">
   <param name="KeyValue" value="">
   <param name="Parameters" value="">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
	  <table border="0" width="845px" cellpadding="0" cellspacing="0">
		<tr>
		  <td align="left">
			<table width="845px" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td align="right">
				  <table border="0" cellpadding="0" cellspacing="0" width="100%" >
					<tr>
					  <TD>
						  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
							<tr bgcolor="#6f7f8d">
							  	<td align=CENTER width=70 class="text">실적(有)</td>
		                        <td align=left width=208 bgcolor="#ffffff" valign="middle">&nbsp;																							
									<input name='sResultsYn' type='checkbox' value='Y'>																				
								</td>
							</TR>
						  </TABLE>
					  </TD>
					  <td align="right"><img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onclick="fnSelect()">
                         <img src="<%=dirPath%>/Sales/images/plus.gif" style="cursor:hand" onClick="fnAddRow()">
                         <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" onClick="fnDeleteRow()">
                         <img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:hand" onClick="fnApply();"> 
                         <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand" onclick="fnCancel()">
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
		<tr height="30px">
		  <td align="left">
			<table width="845px" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td width="845px">
				  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
					<tr bgcolor="#6f7f8d">
					  <td align=CENTER width=70 class="text">출발일자</td>
					  <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                        <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                           <param name=Text value="">
                           <param name=Alignment value=1>
                           <param name=Format value="0000-00-00">
                           <param name=Cursor value="iBeam">
                           <param name=Border value="0">
                           <param name=InheritColor value="true">
                           <param name=ReadOnly value="false">
                           <param name=SelectAll value="true">
                           <param name=SelectAllOnClick value="true">
                           <param name=SelectAllOnClickAny value="false">
                        </object>&nbsp;-
                        <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                           <param name=Text value="">
                           <param name=Alignment value=1>
                           <param name=Format value="0000-00-00">
                           <param name=Cursor value="iBeam">
                           <param name=Border value="0">
                           <param name=InheritColor value="true">
                           <param name=ReadOnly value="false">
                           <param name=SelectAll value="true">
                           <param name=SelectAllOnClick value="true">
                           <param name=SelectAllOnClickAny value="false">
                        </object>
					  </td>
					  <td align=left width=70 class="text">&nbsp;지역</td>
					  <td align=left bgcolor="#ffffff">&nbsp; 
						
						<object id=lc_area classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
						<param name=ComboDataID		value=ds10>
						<param name=BindColumn      value="saup_sid">
						<param name=BindColVal      value="saup_sid">
						<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
						<param name=ListExprFormat  value="saup_nm^0^120"></object>
						
					  </td>
					  <td align=left width=70 class="text">&nbsp;상품</td>
					  <td align=left bgcolor="#ffffff" width=210>&nbsp;
                         <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
                        <param name=ComboDataID value=ds7>
                        <param name=BindColumn value="goods_sid">
                        <param name=BindColVal value="goods_sid">
                        <param name=EditExprFormat value="%,%;goods_sid,goods_nm">
                        <param name=ListExprFormat value="goods_nm^0^140">
                        </object> &nbsp;
					  </td>
					</tr>
					<tr bgcolor="#6f7f8d">
					  <td align=left width=70 class="text">&nbsp;신청일자</td>
					  <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                        <object id=sAcceptBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                           <param name=Text value="">
                           <param name=Alignment value=1>
                           <param name=Format value="0000-00-00">
                           <param name=Cursor value="iBeam">
                           <param name=Border value="0">
                           <param name=InheritColor value="true">
                           <param name=ReadOnly value="false">
                           <param name=SelectAll value="true">
                           <param name=SelectAllOnClick value="true">
                           <param name=SelectAllOnClickAny value="false">
                        </object>&nbsp;-
                        <object id=sAcceptEndDate
                           classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
                           height=17 width=70 align=center
                           class="textbox">
                           <param name=Text value="">
                           <param name=Alignment value=1>
                           <param name=Format value="0000-00-00">
                           <param name=Cursor value="iBeam">
                           <param name=Border value="0">
                           <param name=InheritColor value="true">
                           <param name=ReadOnly value="false">
                           <param name=SelectAll value="true">
                           <param name=SelectAllOnClick value="true">
                           <param name=SelectAllOnClickAny value="false">
                        </object>
					  </td>
					  <td align=left width=70 class="text">검색</td>
					  <td align=left bgcolor="#ffffff">&nbsp; 
                        <object id=sQTypeCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                           <param name=ComboDataID value=ds9>
                           <param name=BindColumn value="detail">
                           <param name=BindColVal value="detail">
                           <param name=EditExprFormat value="%,%;detail,detail_nm">
                           <param name=ListExprFormat value="detail_nm^0^80">
                        </object> &nbsp; 
                        <input id="sQTypeStr" type="text" class="textbox" style="position:relative;left:-0px;top:0px;width:100px; height:20px;">
					  </td>
					  <td align=left width=70 class="text">&nbsp;블록상태</td>
					  <td align=left bgcolor="#ffffff" width=210>&nbsp;
                         <object id=sBlockStatusCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                           <param name=ComboDataID value=ds3>
                           <param name=BindColumn value="detail">
                           <param name=BindColVal value="detail">
                           <param name=EditExprFormat value="%,%;detail,detail_nm">
                           <param name=ListExprFormat value="detail_nm^0^50">
                        </object> 
					  </td>
					</tr>
					<tr bgcolor="#6f7f8d">
					  <td align=left width=70 class="text">&nbsp;T/L일자</td>
					  <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                        <object id=sTlBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                           <param name=Text value="">
                           <param name=Alignment value=1>
                           <param name=Format value="0000-00-00">
                           <param name=Cursor value="iBeam">
                           <param name=Border value="0">
                           <param name=InheritColor value="true">
                           <param name=ReadOnly value="false">
                           <param name=SelectAll value="true">
                           <param name=SelectAllOnClick value="true">
                           <param name=SelectAllOnClickAny value="false">
                        </object>&nbsp;-
                        <object id=sTlEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
                           <param name=Text value="">
                           <param name=Alignment value=1>
                           <param name=Format value="0000-00-00">
                           <param name=Cursor value="iBeam">
                           <param name=Border value="0">
                           <param name=InheritColor value="true">
                           <param name=ReadOnly value="false">
                           <param name=SelectAll value="true">
                           <param name=SelectAllOnClick value="true">
                           <param name=SelectAllOnClickAny value="false">
                        </object>
					  </td>
					  <td align=left width=70 class="text">블록번호</td>
					  <td align=left bgcolor="#ffffff" width=210>&nbsp; <input id="sBlockNo" type="text" class="textbox" style="position:relative;left:-0px;top:0px;width:100px; height:20px;"></td>
					  <td align=left width=70 class="text">&nbsp;대리점</td>
					  <td align=left bgcolor="#ffffff">&nbsp; 
					  	<input id="sClientSid" type="hidden" value="0"> 
					  	<input id="sClientCd" type="text" class="textbox" style="position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds6')"> 
					  	<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();"> 
					  	<input id="sClientNm" type="text" class="boardt04" style="position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
		<tr height="10"><td></td>
		</tr>
		<tr>
		  <td width="845px">
			<table border="0" cellpadding="0" cellspacing="0">
			  <tr valign="top"">
				<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
				 
				<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:200" border="1">
					<param name="DataID" VALUE="ds1">
					<param name="BorderStyle" VALUE="0">
					<param name=ColSizing value="true">
					<param name="editable" value="true">
					<param name=UsingOneClick value="1">
					<Param Name="AllShowEdit" value="True">
					<param name="SortView" value="Right">
					<param name="ViewSummary" value="1">
					<param name=SuppressOption value=1>
					<param name=SelectionColor value="
                     	<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						">
					<param name="Format" value="
                     	<C> name='M블록SID'     ID='m_block_sid'   HeadAlign=Center Width=70  align=center edit=none show=false</C>
						<C> name='블록SID'       ID='block_sid'     HeadAlign=Center Width=60  align=center show=false edit=none</C>
						<C> name='블록No'     ID='block_no'   HeadAlign=Center Width=75  align=center edit=none sort=true sumtext=총건수 sumbgcolor=#E0CFE4 sumcolor=#000000 mask=XXXXXX-XXXX suppress=1</C>
						<G> name='상품구분'
							<C> name='상품'          ID='goods_nm'    Width=100   align=left   edit=none sumbgcolor=#E0CFE4 sumcolor=#000000 sort=true sumtext=@count suppress=1</C>
							<C> name='상품박수'     ID='nights'        Width=70    align=center   edit=none mask=XXXX-XX-XX sumbgcolor=#E0CFE4 sumcolor=#000000 show=false</C>
							<C> name='출발일'     ID='depart_date'        Width=70    align=center   edit=none  sumbgcolor=#E0CFE4 sumcolor=#000000 sort=true mask=XXXX-XX-XX suppress=1</C>
						</G>
						<C> name='대리점'     ID='client_nm'   HeadAlign=Center Width=100  align=left edit=none  sumbgcolor=#E0CFE4 sumcolor=#000000 sort=true show=true suppress=1</C>
						<C> name='신청자'       ID='a_emp_nm'   HeadAlign=Center Width=55  align=left show=true sumbgcolor=#E0CFE4 sumcolor=#000000</C>
						<G> name='신청사항' edit=none
						    <C> name='표준인원'          ID='a_std_persons'    Width=60   align=left   sumbgcolor=#E0CFE4 sumcolor=#000000 show=false</C>
						    <C> name='타입SID'          ID='a_room_type_sid'    Width=60   align=left   edit=none sumbgcolor=#E0CFE4 show=false</C>
						    <C> name='타입'          ID='a_room_type_cd'    Width=50   align=left   edit=none sumbgcolor=#E0CFE4 show=true sort=true</C>
						    <C> name='타입명'          ID='a_room_type_nm'    Width=90   align=left   sumbgcolor=#E0CFE4 edit=none </C>
						    <C> name='객실수'     ID='a_room_cnt'        Width=40    align=right  sumbgcolor=#E0CFE4 edit=none  sumcolor=#000000 sumtext=@sum   </C>
						    <C> name='인원'     ID='accept_persons'        Width=40    align=right sumbgcolor=#E0CFE4 edit=none sumcolor=#000000 sumtext=@sum  </C>
						</G>
						<C> name='단체명'       ID='group_nm'     HeadAlign=Center Width=150  align=left show=true edit=none sumbgcolor=#E0CFE4 suppress=1</C>
						<C> name='요청사항'       ID='a_remarks'     HeadAlign=Center Width=300  align=left show=true edit=none sumbgcolor=#E0CFE4 suppress=1</C>
						<C> name='블록'       ID='block_status_cd'     HeadAlign=Center Width=50  align=center show=true editstyle=lookup Data='ds3:detail:detail' edit=none sumbgcolor=#E0CFE4 </C>
						<C> name='신청일시'     ID='a_date'     HeadAlign=Center Width=80  align=left show=true sort=true sumbgcolor=#E0CFE4 sumcolor=#000000</C>
					">
				</object>
				
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
	</td>
  </tr>

  <tr height="10"><td></td>
  </tr>
  <tr>
	<td width="845px">
	  <table border="0" cellpadding="0" cellspacing="0">
		<tr valign="top"">
		  <td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
			
			<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:230" border="1">
				<param name="DataID" VALUE="ds2">
				<param name="BorderStyle" VALUE="0">
				<param name=ColSizing value="true">
				<param name="editable" value="true">
				<param name=UsingOneClick value="1">
				<Param Name="AllShowEdit" value="True">
				<param name="SortView" value="Right">
				<param name="ViewSummary" value="1">
				<param name=SelectionColor value="
				  <SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
				  <SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
				">
				<param name="Format" value="
				  <C> name='선택여부'     ID='select_div'   Width=60  align=center edit=none show=false </C>
				  <C> name='마스터블록SID'     ID='m_block_sid'   HeadAlign=Center Width=50  align=center show=false</C>
				  <C> name='블록SID'     ID='block_sid'   HeadAlign=Center Width=50  align=center editlimit=12 show=false</C>
				  <C> name='블록No'     ID='block_no' bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }  HeadAlign=Center Width=75  align=center edit=none  sort=true sumtext=총건수 sumbgcolor=#E0CFE4 sumcolor=#000000 mask=XXXXXX-XXXX</C>
				  <G> name='확정사항' show=true
				      <C> name='상태'     ID='block_status_cd'  bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } HeadAlign=Center Width=50  align=center editlimit=2 editstyle=lookup Data='ds3:detail:detail'  sort=true sumtext=@count sumbgcolor=#E0CFE4 sumcolor=#000000 show=true</C>
				      <C> name='표준인원'     ID='std_persons'   HeadAlign=Center Width=50  align=left sumbgcolor=#E0CFE4 show=false</C>
				      <C> name='타입SID'     ID='c_room_type_sid'   HeadAlign=Center Width=50  align=left editlimit=12 sumbgcolor=#E0CFE4 show=false</C>
				      <C> name='타입'     ID='c_room_type_cd' bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }  HeadAlign=Center Width=50  align=left editstyle=popup editlimit=10 sumbgcolor=#E0CFE4 sumcolor=#000000 show=true sort=true</C>
				      <C> name='타입명'     ID='c_room_type_nm' bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }  HeadAlign=Center Width=90  align=left  edit=none editlimit=50 sumbgcolor=#E0CFE4 sumcolor=#000000 show=true</C>
				      <C> name='객실수'       ID='c_room_cnt'  bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }   HeadAlign=Center Width=40  align=right editlimit=5 sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
				      <C> name='인원'       ID='confirm_persons'   bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }  HeadAlign=Center Width=40  align=right editlimit=5 sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
				      <C> name='T/L'       ID='tl_date'  bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }   HeadAlign=Center Width=80  align=center editlimit=8 show=true  sort=true sumbgcolor=#E0CFE4 mask=XXXX-XX-XX</C>
				  </G>
				  <G> name='실적내역'
				      <C> name='객실수'     ID='actual_room_cnt' bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } HeadAlign=Center Width=40  align=right editlimit=5 edit=none sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
				      <C> name='인원'     ID='actual_persons' bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } HeadAlign=Center Width=40  align=right editlimit=5 edit=none sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
				      <C> name='비율'     ID='actual_rate'  bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } HeadAlign=Center Width=40  align=right editlimit=22 edit=none sumbgcolor=#E0CFE4 show=true decao=2</C>
				  </G>
				  <C> name='기재사항'     ID='c_remarks' bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }  HeadAlign=Center Width=300  align=left editlimit=100 sumbgcolor=#E0CFE4 sort=true show=true</C>
				  <C> name='최초확정'       ID='f_emp_nm'   HeadAlign=Center Width=55  align=left edit=none show=true bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } sumbgcolor=#E0CFE4 sumcolor=#000000</C>
				  <C> name='최초확정일시'     ID='f_date'     HeadAlign=Center Width=80  align=left edit=none show=true bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } sumbgcolor=#E0CFE4 sumcolor=#000000</C>
				  <C> name='확정자'       ID='c_emp_nm'   HeadAlign=Center Width=55  align=left edit=none show=true bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } sumbgcolor=#E0CFE4 sumcolor=#000000</C>
				  <C> name='확정일시'     ID='c_date'     HeadAlign=Center Width=80  align=left edit=none show=true bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) } sumbgcolor=#E0CFE4 sumcolor=#000000</C>
				  <G> name='Deposit' show=true
				      <C> name='모객율타입'       ID='cust_rate_type'   bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }  HeadAlign=Center Width=70  align=center editstyle=lookup data= 'ds4:cust_rate_type:cust_rate_type' editlimit=2 sumbgcolor=#E0CFE4 show=true</C>
				      <C> name='보증금율'       ID='deposit_rate'  bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }   HeadAlign=Center Width=60  align=right editstyle=lookup data= 'ds5:detail:detail' editlimit=5 sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
				      <C> name='보증금'       ID='deposit_amt'   bgColor={IF( select_div='Y','#FFD253',IF( select_div='N',IF(block_status_cd='RQ','#FFFFFF','#D8D5D5' ),'#FFFFFF') ) }  HeadAlign=Center Width=60  align=right editlimit=12 edit=none sumbgcolor=#E0CFE4 sumcolor=#000000 sumtext=@sum show=true</C>
				  </G>
				  ">
			</object>
			
		  </td>
		</tr>
	  </table>
	</td>
  </tr>
</table>   


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

