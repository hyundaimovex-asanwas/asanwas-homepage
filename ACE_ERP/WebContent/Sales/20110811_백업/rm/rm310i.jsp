<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 포캐스팅 변경
 * 프로그램ID 	 : RM310I
 * J  S  P		 : rm310i
 * 서 블 릿		 : RM310I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-06-26
 * 기능정의		 : 포캐스팅 변경 (조회, 저장, 취소)
 * 기능정의		 : 관광객에 메세지 발송
 * 				      메세지를 발송하는 페이지는 외부SMS 모듈 처리를 위해 windwos서버에 ASP로 되어 있음.
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   String firstday = m_today.format(date.getTime());		   
   date.set(java.util.Calendar.HOUR_OF_DAY, 120);      
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
        var div='';

        var v_upjang_sid  = "";
        var v_use_date    = "";

	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
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
		gr1.TitleHeight = "35";        
		gr2.TitleHeight = "35";  
		
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";		 		

        //검색
        ds6.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM017&s_Item1=Y";
        ds6.Reset();
                
/*        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310I",
            "JSP(O:DS3=ds3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);*/
        
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds3.Reset(); //지역코드
		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds1.isUpdated || ds2.IsUpdated ) { 
			alert("수정중인 행이 있습니다."); 
		} else {    
			if ( sBgnDate.text.trim() == '' ||  sEndDate.text.trim() == '' ) {
				alert("출발일자를 입력해 주세요.");
				return;
			}
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sEndDate=" + sEndDate.text + ","
	            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid") + ","
	            + "sUpjangSid=" + ds4.namevalue(ds4.rowposition,"upjang_sid") + ","
	            + "sRoomTypeSid=" + ds5.namevalue(ds5.rowposition,"room_type_sid") + ","
	            + "sQTypeCd=" + ds6.namevalue(ds6.rowposition,"detail") + ","            	                                                
	            + "sQTypeStr=" + sQTypeStr.value;          	            
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310I",
	            "JSP(O:DS1=ds1,O:DS2=ds2)",
	            param);
	        tr_post(tr1);

           for ( i=1;i<=ds1.CountRow;i++ ) {
              if ( ds1.namevalue(i,"upjang_sid") == v_upjang_sid && ds1.namevalue(i,"use_date") == v_use_date ) {
                 ds1.rowposition=i;
                 break;
              }
           }

           for ( i=1;i<=ds2.CountRow;i++ ) {
              if ( ds2.namevalue(i,"upjang_sid") == v_upjang_sid && ds2.namevalue(i,"use_date") == v_use_date ) {
                 ds2.rowposition=i;
                 ds2.ResetStatus;
                 break;
              }
           }
           v_upjang_sid = "";
           v_use_date   = "";               
        }
    }
	/*
	 * 영업장 조회
	 */		
	function fnSelectDs4() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid");	
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310I",
            "JSP(O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	  
	/*
	 * 객실타입 조회
	 */		
	function fnSelectDs5() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid") + ","
            + "sUpjangSid=" + ds4.namevalue(ds4.rowposition,"upjang_sid");
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310I",
            "JSP(O:DS5=ds5)",
            param);
        tr_post(tr3)
	}	
	/*
	 * 적용
	 */
	function fnApply() {
		if (ds1.isUpdated || ds2.isUpdated ){ 

           v_upjang_sid = ds1.namevalue(ds1.RowPosition, "upjang_sid");
           v_use_date   = ds1.namevalue(ds1.RowPosition, "use_date");

	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310I",
	             "JSP(I:DS1=ds1,I:DS2=ds2,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * 취소
	 */
	function fnCancel() {
		if ( ds1.isUpdated || ds2.IsUpdated ) {
			ds1.undoall();				
			ds2.undoall();		
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
			if ( !ds2.isUpdated ) {
				for ( i=1;i<=ds2.CountRow;i++ ) {
					if ( ds1.namevalue(row,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(row,"use_date") == ds2.namevalue(i,"use_date") ) {
						ds2.rowposition=i;
						ds2.namevalue(i,"select_div") = 'Y';
					} else {
						ds2.namevalue(i,"select_div") = 'N';				
					}
				}
				ds2.ResetStatus();				
			}
		</script>

		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			if ( !ds2.isUpdated ) {		
				for ( i=1;i<=ds2.CountRow;i++ ) {
					if ( ds1.namevalue(row,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(row,"use_date") == ds2.namevalue(i,"use_date") ) {
						ds2.rowposition=i;
						ds2.namevalue(i,"select_div") = 'Y';
					} else {
						ds2.namevalue(i,"select_div") = 'N';				
					}
				}
				ds2.ResetStatus();				
			}
		</script>

		<script language="javascript"  for=gr2 event=OnClick(row,colid)>
		   if (row < 1 && colid=='over_block_cnt' ) {
			   	for(i=1;i<=ds2.CountRow;i++)
		     		ds2.namevalue(i,colid) = ds2.namevalue(1,colid);
		   }		
		   if (row < 1 && colid=='int_rsv_yn' ) {
			   	for(i=1;i<=ds2.CountRow;i++)
		     		ds2.namevalue(i,colid) = ds2.namevalue(1,colid);
		   }				
		</script>

		<script language=JavaScript for=gr2 event=OnDblClick(row,colid)>
			if ( colid == 'use_cnt2' ) {
				if ( ds2.namevalue(row,"use_yn2") == 'N' )
					ds2.namevalue(row,"use_yn2") = 'Y';
				else
					ds2.namevalue(row,"use_yn2") = 'N';		
				if ( ds2.namevalue(row,"use_yn2") == 'Y' ) {
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
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";					
				}								
			}
			if ( colid == 'use_cnt1' ) {
				if ( ds2.namevalue(row,"use_yn1") == 'N' )
					ds2.namevalue(row,"use_yn1") = 'Y';
				else
					ds2.namevalue(row,"use_yn1") = 'N';	
				if ( ds2.namevalue(row,"use_yn1") == 'Y' ) {
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
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";					
				}									
			}			
		</script>
		
		<script language="javascript"  for=gr2 event=OnColumnPosChanged(row,colid)>
			if ( colid == 'rsv_close_date' || colid == 'use_date' || colid == 'yoil_nm' || colid == 'room_type_cd' ) {
				if ( ds2.namevalue(row,"select_div") == 'Y' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";		
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";	
				}				
			} else if ( colid == 'use_cnt2' ) {
				if ( ds2.namevalue(row,"use_yn2") == 'N' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";				
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";					
				}
			} else if ( colid == 'use_cnt1' ) {
				if ( ds2.namevalue(row,"use_yn1") == 'N' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";				
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";					
				}	
			} else if ( colid == 'over_block_cnt' || colid == 'int_rsv_yn' ||  colid == 'remarks1' || colid == 'remarks2' || colid == 'remarks3' ) {
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
				gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
				gr2.SelectionColorProp("EditCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("EditRow", "BgColor") = "";
				gr2.SelectionColorProp("CurCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("CurRow", "BgColor") = "";
				gr2.SelectionColorProp("SelRow", "BgColor") = "";			
			}	
		</script>		
		
		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs4()
		</script>		
		
		<script language=JavaScript for= lc2 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs5()
		</script>			
		
	    <script language=JavaScript for=sBgnDate event=OnKillFocus()>
	        if( sBgnDate.Modified == true )
				sEndDate.text = sBgnDate.text;
	    </script>			
	    
		<script language=JavaScript for=gr2 event=onKeyPress(keycode)>
			if ( keycode == 32 ) {
				if ( gr2.GetColumn() == 'use_cnt2' ) {
					if ( ds2.namevalue(ds2.rowposition,"use_yn2") == 'N' )
						ds2.namevalue(ds2.rowposition,"use_yn2") = 'Y';
					else
						ds2.namevalue(ds2.rowposition,"use_yn2") = 'N';		
					if ( ds2.namevalue(ds2.rowposition,"use_yn2") == 'Y' ) {
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
						gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
						gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
						gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
						gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("EditRow", "BgColor") = "";
						gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("CurRow", "BgColor") = "";
						gr2.SelectionColorProp("SelRow", "BgColor") = "";					
					}								
				}
				if ( gr2.GetColumn() == 'use_cnt1' ) {
					if ( ds2.namevalue(ds2.rowposition,"use_yn1") == 'N' )
						ds2.namevalue(ds2.rowposition,"use_yn1") = 'Y';
					else
						ds2.namevalue(ds2.rowposition,"use_yn1") = 'N';	
					if ( ds2.namevalue(ds2.rowposition,"use_yn1") == 'Y' ) {
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
						gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
						gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
						gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
						gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("EditRow", "BgColor") = "";
						gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2'";
						gr2.SelectionColorProp("CurRow", "BgColor") = "";
						gr2.SelectionColorProp("SelRow", "BgColor") = "";					
					}									
				}
			}
		</script>
	    

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
            for ( i=1; i<=msgDS.CountRow; i++ )
            	msg+=msgDS.namevalue(i,"pMsg")+"\n";
            if ( msgDS.CountRow > 0 ) 
	          	alert(msg);     
	        fnSelect();   
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		div='';  
		
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);  
		    
        var msg='';
        //메시지 처리
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		    		
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        div='';             
         
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);           
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr3" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        div='';             
         
        var alertMsg = '';
       	var nErrCnt = tr3.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr3.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr3.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);           
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
	for ( i=1;i<=ds2.CountRow;i++ ) {
		if ( ds1.namevalue(ds1.rowposition,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(ds1.rowposition,"use_date") == ds2.namevalue(i,"use_date") ) {
			ds2.rowposition=i;
			ds2.namevalue(i,"select_div") = 'Y';
		} else {
			ds2.namevalue(i,"select_div") = 'N';				
		}
	}      
	ds2.ResetStatus();	 
</script>
<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	fnSelectDs4(); 
</script>
<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
	div='';	
	fnSelectDs5(); 
</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!--  검색 -->
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<%
				/*---------------------------------------------------------------------------->
					HTML Desc	: 검색 부분 
								: 담당자명, 담당자코드
				-----------------------------------------------------------------------------*/
				%>
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="10px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
												<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>										
				<tr height="25px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left class="text" width="70"><b>출발일자</b></td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																						
										     <comment id="__NSID__"><object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000-00-00">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="0">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll   value="true">																				
												<param name=SelectAllOnClick   value="true">	
												<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																										
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;~
										     <comment id="__NSID__"><object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000-00-00">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="0">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll   value="true">																				
												<param name=SelectAllOnClick   value="true">	
												<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																										
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
											</td>
			            					<td align=left class="text" width="70">지역</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
			            					<td align=left class="text" width="70">영업장</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
													<param name=BindColumn      value="upjang_sid">
                                                    <param name=BindColVal      value="upjang_sid">
													<param name=EditExprFormat	value="%,%;upjang_sid,upjang_nm">
													<param name=ListExprFormat  value="upjang_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
			            					<td align=left class="text" width="70">객실타입</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="room_type_sid">
                                                    <param name=BindColVal      value="room_type_sid">
													<param name=EditExprFormat	value="%,%;room_type_sid,room_type_cd">
													<param name=ListExprFormat  value="room_type_cd^0^80"></object>
												<%=HDConstant.COMMENT_END%>
											</td>																																																									
			            				</tr>
			                            <tr bgcolor="#6f7f8d">											            				
			            					<td align=left width=70 class="text">검색</td>
			                                <td align=left bgcolor="#ffffff" colspan="7">&nbsp;																									
  												<%=HDConstant.COMMENT_START%>
					                            <object id=sQTypeCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^80"></object>
												<%=HDConstant.COMMENT_END%>&nbsp;
												<input id="sQTypeStr" type="text" class="textbox"  style= "position:relative;left:-0px;top:0px;width:100px; height:20px;">																				
											</td>	
										</tr>												            				
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="10">
					<td></td>
				</tr>		
				<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%
									/*---------------------------------------------------------------------------->
										HTML Desc	: 검색 종류 - 
										Object ID 	: 그리드 , gr1
										Data ID		: ds1
									-----------------------------------------------------------------------------*/
									%>							
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:185" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>		
										<param name=ColSelect    value="True">																								                                        
										<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
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
										<param name="Format" 			value="
							                <C> name='영업장SID'     ID='upjang_sid'    align=left show=false </C>																		
							                <C> name='마감일'     ID='rsv_close_date'    width=70 align=left show=true mask=XXXX-XX-XX suppress=1</C>
							                <C> name='출발일'     ID='use_date'  fontstyle=bold     width=80 align=left edit=none show=true mask=XXXX-XX-XX  suppress=2 </C>
							                <C> name='요일'      ID='yoil_nm'       width=30 align=center edit=none show=true  suppress=3 </C>
							                <C> name='호텔'    ID='upjang_nm'     width=100 align=left edit=none show=true  suppress=4 </C>
							                <C> name='운영'       ID='open_goods_nm'       width=40 align=right edit=none show=true suppress=5</C>
							                <C> name='운영가능'        ID='open_cnt'         width=60 edit=none align=right show=true</C>
							                <C> name='이용'     ID='use_cnt'      width=40 align=right edit=none how=true</C>
							                <C> name='가용\\(2박)'        ID='use_cnt2'     fontstyle=bold     width=40 align=right edit=none show=true</C>
							                <C> name='가용\\(1박)'   ID='use_cnt1'   fontstyle=bold  width=40 align=right edit=none show=true</C>
							                <C> name='오버\\블록'     ID='over_block_cnt'      width=40 align=right edit=none show=true</C>
							                <C> name='투숙\\예정'     ID='stay_cnt'      width=40 align=right edit=none show=true</C>
							                <C> name='블록'     ID='assign_block_cnt'      width=40 align=right edit=none show=true</C>
							                <C> name='블록\\예약'  ID='rsv_block_cnt'           width=40 align=right edit=none show=true</C>
							                <C> name='예약'  ID='rsv_cnt'           width=40 align=right edit=none show=true</C>
							                <C> name='인터넷'       ID='int_rsv_cnt'        width=50 align=right edit=none show=true</C>
							                <C> name='내금'  ID='naekum_cnt'        width=40 align=right edit=none show=true  suppress=2</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<%
	/*---------------------------------------------------------------------------->
		HTML Desc	: 검색 부분 
					: 
	-----------------------------------------------------------------------------*/
	%>											
	<tr height="10">
		<td></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						<%
						/*---------------------------------------------------------------------------->
							HTML Desc	: 검색 종류 - 
							Object ID 	: 그리드 , gr2
							Data ID		: ds2
						-----------------------------------------------------------------------------*/
						%>							
						<%=HDConstant.COMMENT_START%>
						<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:185" border="1" >
                			<param name="DataID"		VALUE="ds2">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
							<param name=MultiRowSelect    value=true>
							<param name=SuppressOption value=1>																																						
							<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='EditCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusEditRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='EditRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusCurCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='CurCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusCurRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='CurRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusSelRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='SelRow', BgColor='', TextColor='Black'</SC>
																						">								                                        											                                        
							<param name="Format" 			value="
				                <C> name='선택여부'     ID='select_div'   Width=60  align=center edit=none show=false </C> 																                																																				
				                <C> name='영업장SID'     ID='upjang_sid'   Width=60  align=center edit=none show=false </C> 																                																		
				                <C> name='객실SID'     ID='room_type_sid'   Width=60  align=center show=false </C> 																                																																	                
				                <C> name='마감일'     ID='rsv_close_date'    bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} width=70 align=left edit=none show=true mask=XXXX-XX-XX suppress=1</C>															                
				                <C> name='출발일'     ID='use_date' fontstyle=bold   bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} Width=80  align=center edit=none mask=XXXX-XX-XX suppress=2</C> 																                
				                <C> name='요일'     ID='yoil_nm'   bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} Width=30  align=center edit=none suppress=3</C> 
				                <C> name='객실'     ID='room_type_cd'   bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} Width=100  align=center edit=none suppress=4</C> 																                
				                <C> name='운영가능'     ID='open_cnt'   bgColor=#fefec0 Width=100  align=right edit=none suppress=5</C> 
				                <C> name='이용'     ID='use_cnt'   bgColor=#fefec0 Width=40  align=right edit=none suppress=6</C> 															                
				                <C> name='가용\\(2박)'       ID='use_cnt2'     bgColor={IF(use_yn2='N','#F7B7F2','#FFFFFF')} fontstyle=bold Width=40  align=right edit=none </C>
				                <C> name='가용\\(2박) 여부'       ID='use_yn2'     Width=70  align=right show=false </C>															                
				                <C> name='가용\\(1박)'       ID='use_cnt1'     bgColor={IF(use_yn1='N','#F7B7F2','#FFFFFF')} fontstyle=bold Width=40  align=right edit=none  </C> 
				                <C> name='가용\\(1박) 여부'       ID='use_yn1'     Width=60  align=right show=false </C> 															                
				                <C> name='오버\\블록√'       ID='over_block_cnt'     Width=40  align=right </C> 
				                <C> name='투숙\\예정'       ID='stay_cnt'     bgColor=#fefec0 Width=40  align=right edit=none </C>	 													                
				                <C> name='블록'       ID='assign_block_cnt'     bgColor=#fefec0 Width=40  align=right edit=none </C>														                															                
				                <C> name='블록\\예약'       ID='rsv_block_cnt'     bgColor=#fefec0 Width=40  align=right edit=none </C> 															                															                
				                <C> name='예약'       ID='rsv_cnt'     bgColor=#fefec0 Width=40  align=right edit=none </C>	 													                															                															                
				                <C> name='인터넷'       ID='int_rsv_cnt'     bgColor=#fefec0 Width=50  align=right edit=none </C>	 													                															                															                
				                <C> name='참고1'       ID='remarks1'     Width=150  align=left </C>	 													                															                															                
				                <C> name='참고2'       ID='remarks2'     Width=150  align=left </C>	 													                															                															                
				                <C> name='참고3'       ID='remarks3'     Width=150  align=left </C>	 													                															                															                															                															                															                
				                <C> name='인터넷\\가능√'       ID='int_rsv_yn'   Width=50  align=center editstyle=checkbox  </C>	 													                															                															                
							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>		
				</tr>
			</table>
		</td>
	</tr>											
</table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

