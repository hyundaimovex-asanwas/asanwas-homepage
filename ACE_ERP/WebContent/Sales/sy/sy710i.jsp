<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 리서치 저장
 * 프로그램ID 	: SY710I (코드는 대문자)
 * J  S  P		: sy710i (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: Sy710i
 * 작 성 자		: 정하나
 * 작 성 일		: 2011-03-03
 * 기능정의		: 리서치 저장 
* 				      메세지를 발송하는 페이지는 외부SMS 모듈 처리를 위해 windwos서버에 ASP로 되어 있음.
 * [수  정   일  자][수정자] 내용
 * 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
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

		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩 
// Parameter 	: 
%>
	function fnOnLoad(tree_idx){
	//	fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  선조회
// Parameter 	: 
%>
			function fnInit(){ 
		        cfStyleGrid(getObjectFirst("gr1"), "comn");						
				fnSelectDs2();
				fntPopup();

			}
			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
			function fnSetHeaderDs1(){

			}
			
		function fntPopup() {
	       var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	            
	        strURL = "<%=dirPath%>/Sales/sy/sy710h.jsp";
	        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	        arrResult = showModalDialog(strURL,arrParam,strPos);    
	   /* 
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            zip_cd.Text= arrParam[0];
	            address1.value = arrParam[1];
	            
	        } else {
	          zip_cd.Text = "";
	          address1.value = "";
	        }       				*/
		}			
					
	    
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [조회]
%>

    function fnSelect() {
        //window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        //document.all.LowerFrame.style.visibility="visible";
      
        v_job = "S";
           
     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" + "," 
                    + "v_empno=" +login_id + "," 
                   // + "v_empno=" +6080002 + ","  //+ "v_empno=" +login_id + "," 
					+ "v_research_cd=" + ds2.namevalue(ds2.rowposition,"detail") ;
     
         //      alert(param);
        ln_TRSetting(tr1, 
   		    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy710I", 
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1); 					              
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  리서치 항목 조회
// Parameter 	: 
%>
			
			function fnSelectDs2() {			
				ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY016&s_item1=Y";				
        		ds2.Reset(); 
        	}			
						

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ] 
// 					: 마스터  
%>

			
    function fnApply() {
    	var j=1;
		if (ds1.isUpdated ){  		
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "RS_YN")=="T"){    				
    					j++;
    			}
    			if(j>4)
    				{
    	               alert("각 항목당 최대 3개까지만 선택가능합니다.");
      		           return;
        		     }        		     
            }          		 	  		 
	      var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	   	     	+ "v_empno=" + login_id  ;
	   	     	//+ "v_empno=" + 6080002+ ","        //+login_id
	   	 //    	+ "v_research_cd=" + v_research_cd.BindColVal;  	   	     		   	     	
	   	     	//    alert(param);
		   ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy710I",
		             "JSP(I:DEFAULT=ds1)",  
		            param);
		         tr_post(tr1);
		  		alert("저장되었습니다.");		         
 	             fnSelect();
		 }else{
		  		alert("저장할 값이 없습니다. 다시 선택해주세요");
		 }
	}
	

    			
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
		function fnCancel(){
			if(ds1.IsUpdated ) {
				ds1.undoall();
			}
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";							
			return;
		}
						
		</script>
		
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>		
<%
////////////////////////////////////////////////////////////////////////////////
//// 포케스팅 정보를 조회한다 
%>	
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
//		if ( colid == 'use_yn' ) {
//				if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
//					ds1.namevalue(row,"use_yn") = 'F';		
//					alert("시작일자와 종료일자를 입력하셔야 합니다.");
//				} 
//			}
		</script>

		
		<script language=JavaScript for= v_research_cd event=OnSelChange()>
				fnSelect();
		</script>		
		
<%
////////////////////////////////////////////////////////////////////////////////
//// 포케스팅 정보 조회
%>		
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>

		
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
		//	fnSelectDs2(); 
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
     	window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);          
	</script>			
			
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
		
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName" value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		



											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
												<%
												/*---------------------------------------------------------------------------->
													HTML Desc	: 검색 부분 
																: 담당자명, 담당자코드
												-----------------------------------------------------------------------------*/
												%>											
												<tr height="50px">
													<td align="left" >
														<table width="1050px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td align="right">
																	<table border="0"  cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td align="right" height="30px">		
																				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">	
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand" onClick="fnCancel()">																
																 			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>	
													</td>											
												</tr>
												
												<tr height="30px">
													<td align="left" >
														<table width="1050px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td  width="1050px">
																	<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
																		<tr  bgcolor="#6f7f8d" height="30px" width="590">
																			<td width="70px" class="text">항목 </td>
																			<td bgcolor="#ffffff">
																				<table width=150 border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
																					<tr>
																						<td width="150px" align="center"  bgcolor="#FFFFFF">
																						
																						<%=HDConstant.COMMENT_START%>
																						<object id=v_research_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=120 style="position:relative;left:1px;top:2px" class="txtbox" >
																						<param name=ComboDataID			value=ds2>
																						<param name=BindColumn      value="detail">
														                                <param name=BindColVal      value="detail">
																						<param name=EditExprFormat	value="%,%;detail,detail_nm">
																						<param name=ListExprFormat  value="detail_nm^0^100">
																						</object>
																						<%=HDConstant.COMMENT_END%>																																											
																						</td>	
																					</tr>
																				</table>
																			</td>
																			<td width="870px" class="text"> 각 항목당 3개까지 선택이 가능합니다. 글자 수 제한으로 "의미" 항목을 클릭하시면 좀 더 자세한 내용을 보실 수 있습니다. 
																			<br>각 항목별로 3개를 선택하고 다음 항목으로 넘어가기 전에 저장하셔야 합니다.
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
													<td width="1050px">
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="1050px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
																<%
																/*---------------------------------------------------------------------------->
																	HTML Desc	: 검색 종류 - 주제
																	Object ID 	: 그리드 , gr1
																	Data ID		: ds1
																-----------------------------------------------------------------------------*/
																%>							
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=1050px; height:580" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true"> 
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">	
								                                        <param name=RowHeight  value="20">						             
																		<param name="Format" 			value="
																			<C> name='생성'  		ID='RS_YN'   	HeadAlign=Center Width=30 Heigh=300 align=center editstyle=checkbox </C>																				
																			<C> name='리서치_seq' 		ID='RESEARCH_SEQ' 				 	HeadAlign=Center Width=50  align=left show=false</C>																																																									
																			<C> name='명칭' 		ID='RESEARCH_NM' 				 	HeadAlign=Center Width=180  align=left EDIT=NONE </C>																																							
																			<C> name='의미' 		ID='RESEARCH_MNG' 				 	HeadAlign=Center Width=1000  align=left  BgColor=#fefec0  </C>																																																																																			
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>		
																<td width="25px">
																</td>					
															</tr>
														</table>
													</td>
												</tr>											
<input type="hidden" name="row" value="">

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
<script language=javascript>
	var login_id;
	var login_nm;
	get_cookdata();
	login_id=GetCookie("vusrid");
	login_nm=GetCookie("vusrnm");
</script>

