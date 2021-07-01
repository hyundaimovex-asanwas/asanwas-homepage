<!-- /******************************************************************************
 * 시스템명 	 : 구매의뢰서 - 발주 list
 * 프로그램ID 	 : PMS/RQ040
 * J  S  P	 	 : rq040.jsp
 * 서 블 릿		 : 
 * 작 성 자		 : 김도연
 * 작 성 일		 : 2018-06-21
 * 기능정의		 : 구매의뢰서 - 발주 list
 * [ 수정일자 ][수정자] 내용
 * [ 2018-06-21 ][김도연] 신규개발

 *****************************************************************************/ -->
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>



<%	// ContextPath 변수 설정.

	String dirPath = request.getContextPath(); //HDASan
	SmartRequest sr = new SmartRequest(request);	

	//로그인 체크 : 2013-12-04 심동현 수정 ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//페이지 이동시 세션ID 체크(이건 웬만한 곳은 하지 말끄나?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//페이지 이동시 세션변수("로긴") 체크
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크
	
%>


<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<!-- <meta charset=euc-kr"> -->
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="Cache-control" content="no-cache"/>
	<meta http-equiv="Cache-control" content="no-store"/>
	<meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=1080" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	

	<jsp:include page="/Pms/common/include/head.jsp"/>


<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">

		var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
		
		var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
		
		var menuWin;	//새창 띄우기용.
		
	
		function fnOnLoad(tree_idx){
			
			fnInit_tree(tree_idx);	//트리초기화 호출
			
			cfStyleGrid(getObjectFirst("gr_default"), "comn");	//card usage list
	
			fnInit();
			
		}
		
		
		
	    <%//초기작업 %>
	    
	    function fnInit(){
	    	
		    v_job ="I";
		    
		    fnSelect();
		    
	    }
		    
	    
	    <%//메인 조회 %>
	    function fnSelect(){
	    	
	    	v_job="S";
	    	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
								+ ",v_project=" + v_project.value				//검색조건
								;
	
	
	        ln_TRSetting(tr1, 
			            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq040",
			            "JSP(O:DS_DEFAULT=ds_default)", 
			            param);
		        
	        tr_post(tr1);
	        
	        
	    }
	    
	    
	
	
	
	    <%//저장 %>
		function fnApply() {
	
				v_job = "A";
				
				var v_default_row   = ds_default.RowPosition;
				
		
			  	var v_cost_cd		=	ds_default.namevalue(ds_default.rowposition,"COST_CD"); 			//프로젝트 코드
			 	var v_no_ma_request	=	ds_default.namevalue(ds_default.rowposition,"NO_MA_REQUEST"); 		//구매의뢰서 번호
			 	var v_ds_ma_request	=	ds_default.namevalue(ds_default.rowposition,"DS_MA_REQUEST"); 		//contents
			 	var v_ty_buytype	=	ds_default.namevalue(ds_default.rowposition,"TY_BUYTYPE"); 			//구매근거
			 	var v_remark		=	ds_default.namevalue(ds_default.rowposition,"REMARK"); 				//비고
			 	
		 	
			 	if(v_cost_cd==""||v_cost_cd==null){
			 		
			 		alert("Project를 입력해주세요.");
			 		return;
			 		
			 	}
			 	
			 	if(v_ds_ma_request==""||v_ds_ma_request==null){
			 		
			 		alert("Contents를 입력해주세요.");
			 		return;
			 		
			 	}
			 	
			 	if(v_ty_buytype=="선택"||v_ty_buytype==null){
			 		
			 		alert("구매근거를 선택해주세요.");
			 		return;
			 		
			 	}
			 	
			 	if(v_remark==""||v_remark==null){
			 		
			 		alert("비고를 입력해주세요.");
			 		return;
			 		
			 	}
		 		
	
				var param   = "v_cost_cd"			+ ds_default.namevalue(ds_default.rowposition,"COST_CD")				//project code
					        + "v_no_ma_request"		+ ds_default.namevalue(ds_default.rowposition,"NO_MA_REQUEST") 			//구매의뢰서 번호
					        + "v_ds_ma_request"		+ ds_default.namevalue(ds_default.rowposition,"DS_MA_REQUEST") 			//
					        + "v_ty_buytype"		+ ds_default.namevalue(ds_default.rowposition,"TY_BUYTYPE") 			// 
					        + "v_remark"			+ ds_default.namevalue(ds_default.rowposition,"REMARK") 				//      
		        ;
	
	
		 		ln_TRSetting(tr1, 
			                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq040",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
			                param
		                	);
	
		        tr_post(tr1);
		        
		        
	
			}
	
		
		
		
		     
		    <%//행추가%>
		    function fnAddRow(){
	
		    	
		    	ds_default.addrow();
	
		    	ds_default.namevalue(ds_default.RowPosition, "NO_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>" + '0000';
	
	
		    	//행추가시 의뢰일자 자동 출력. (현재 날짜로 출력)
		    	ds_default.namevalue(ds_default.RowPosition, "DT_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>";
		    	
		    	//행추가시 의뢰자 자동 출력. (성명으로 출력)
		    	ds_default.namevalue(ds_default.RowPosition, "NM_REQUEST")="<%=gusrnm%>";
		    	
		    	//행추가시 구매근거 자동 출력. (선택으로 출력)
		    	ds_default.namevalue(ds_default.RowPosition, "TY_BUYTYPE")= "선택";
		    	
		    	//행추가시 상태 자동 출력. (작성중으로 출력)
		    	ds_default.namevalue(ds_default.RowPosition, "TY_APPROVAL")= "작성중";
	
	
		    }
		 	
		 	
		     <%//deleterow data %>	   
			 function fnDeleteRow(){
			    	
				   		if(ds_default.countrow > 0 ) {
	
							var i;
							
							for ( i=1;i<=ds_default.countrow;i++){
								
	
								if (ds_default.namevalue(i,"CHK") =="T"){
									
									if  (fnc_Appoint_Chkd(i)){
										
										//alert("rowPosition : "+i);
										
										ds_default.DeleteRow(i);
										
										i--;
										
										
									}else{
										
										//alert("여기 들어와?");
										
										break;
										
									}
								} 
							}
			
						}else{
							
							alert("데이터가 존재하지 않습니다");
							
						}
				   		
				}
	        		
		
	    
	
	    
		
	    function fnc_Appoint_Chkd(i){
	
			return true;
	
	
		}
	
	    

    </script>
    
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>


<script language="javascript" for="tr1" event="OnSuccess()">


	if(v_job=="A"){
		
		alert("성공적으로 저장되었습니다.");
		
		fnSelect();
		
	}

</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<!-- 마우스 이벤트 - 더블클릭 -->
<script language=javascript for=gr_default event="OnDblClick(Row,Colid)">

			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"NO_MA_REQUEST");		//구매의뢰서 번호
			arrParam[1] = ds_default.NameValue(ds_default.rowposition,"COST_CD");				//Project Code
			arrParam[2] = ds_default.NameValue(ds_default.rowposition,"PLJ_NM");				//Project
			
			strURL = "<%=dirPath%>/Pms/new/pur/rq041.jsp";
			     
			strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			sApproveLine = arrResult; 

</script>	

    	
  	
    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
		    <param name="KeyName"    value="toinb_dataid4"/>
		    <param name="ServerIP"   value=""/>
		    <param name="Action"     value=""/>
		    <param name="KeyValue"   value=""/>
		    <param name="Parameters" value=""/>
</object>




</head>

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
    
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
			     		<td align=left >
							
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<!--<img src="<%=dirPath%>/Sales/images/save.gif"  		style="cursor:pointer" onclick="fnApply()">-->
                        </td>
                    </tr>
                </table>
            </td>
        </tr> 
        
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="1002px">
           			<tr>
                        <td align="center" class="text" width="150">Project</td>
                        <td align="left" bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_project' id="v_project" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">                 
                        </td>
					</tr>
           		</table>
            </td>
        </tr> 
        
        <tr height='10px'>
            <td></td>
        </tr>
        
        <!--  
        <tr>
        	<td height='30px' align='right'>
        		<img src="<%=dirPath%>/Sales/images/plus.gif"			style="cursor:pointer" 		onclick="fnAddRow()">
        		<img src="<%=dirPath%>/Sales/images/minus.gif"			style="cursor:pointer" 		onclick="fnDeleteRow()" >
        	</td>
        </tr>
        -->
        
        <tr>
            <td valign="top">
                <object id=gr_default classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='550px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="Editable"          	value="false">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name=ColSelect    			value="True">
					<param name="ColSizing"         	value="true">																								                                        
                    <param name="Format"            	value="
                    	<C> name='선택'					ID=CHK						width=40 	align=center    EditStyle=CheckBox show=false</C>
						<C> name='No'					ID='{CurRow}'		 		width=40 	align=CENTER	edit=none </C>	
                    	<C> name='구매의뢰서 번호'		ID='NO_MA_REQUEST'			width=100 	align=CENTER  	edit=none			readonly=true 	mask='XXXXXXXX-XXXX'</C>
                    	<C> name='Code'					ID='COST_CD'				width=70 	align=CENTER 	show=true 			readonly=true	show=false</C>                 	
                        <C> name='Project'				ID='PLJ_NM'					width=180 	align=left 		readonly=true	</C>
                        <C> name='제목'					ID='DS_MA_REQUEST'			width=180 	align=left 		readonly=true	</C>
                        <C> name='의뢰일자' 			ID='DT_MA_REQUEST'			width=80 	align=CENTER	mask='XXXX-XX-XX'	edit=none	readonly=true</C>
                        <C> name='의뢰자'				ID='NM_REQUEST' 			width=60 	align=CENTER	readonly=true 		</C>
                        <C> name='구매근거'				ID='TY_BUYTYPE' 			width=80 	align=CENTER	EditStyle=Combo		 Data=' :선택,A:일반구매,H:현업추천'	</C>
                        <C> name='요청 납기일'			ID='DT_DELIVERY'			width=80 	align=CENTER	mask='XXXX-XX-XX'	readonly=true	</C>
                        <C> name='진행 상태'			ID='TY_APPROVAL_PO' 		width=80 	align=CENTER	EditStyle=Combo		 Data=' :선택,Y:승인완료,R:승인요청,B:반려'		</C>
                        <C> name='비고'					ID='REMARK'					width=100 	align=left	</C>
                 ">                             
                </object>
            </td>
        </tr>
        
    </table>
    
</body>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>




