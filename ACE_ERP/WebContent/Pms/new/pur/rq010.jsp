<!-- /******************************************************************************
 * 시스템명 	 	 : 구매의뢰서 - 작성
 * 프로그램ID 	 : PMS/RQ010
 * J  S  P	 : rq010.jsp
 * 서 블 릿		 : 
 * 작 성 자		 : 김도연
 * 작 성 일		 : 2018-05-30
 * 기능정의		 : 구매의뢰서 - 작성
 * [ 수정일자 ][수정자] 내용
 * [ 2018-06-05 ][김도연] 신규개발

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


<!-- HTML 시작 : doctype를 html5로 해볼까? 훔;;-->

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
	
	<!--  head.jsp -->
	<jsp:include page="/Pms/common/include/head.jsp"/>
	<!--  //head.jsp -->
   
   
   
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>


<script language="javascript">

	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var menuWin;	//새창 띄우기용.
	
	/*
	 * 페이지로딩
	 */
	
	 
	 

	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list

		fnInit();
	}
	
	
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    
	    fnSelect();

    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	
    	
    	v_job="S";
    	
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
											+ ",v_project=" + v_project.value	//project명 , 검색조건
											;

        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
		            "JSP(O:DS_DEFAULT=ds_default)", //화면 출력
		            param);
        

        tr_post(tr1);
        
    }
    
    
        
    
    
    <%//저장 %>
	function fnApply(){
		
		v_job = "A";
		
		v_default_row = ds_default.RowPosition;

		
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
	 	
	 	
	 	
	 	
	 	if(v_ty_buytype=="선택"||v_ty_buytype==null||v_ty_buytype==' '){
	 		alert("구매근거를 선택해주세요.");
	 		return;
	 	}
	 	
	 	//if(v_remark==""||v_remark==null){
	 	//	alert("비고를 입력해주세요.");
	 	//	return; }

 		ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
	                "JSP(I:DS_DEFAULT=ds_default)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                //+ "v_cost_cd"			+ ds_default.namevalue(ds_default.rowposition,"COST_CD") 			//프로젝트 코드
	                //+ "v_no_ma_request"		+ ds_default.namevalue(ds_default.rowposition,"NO_MA_REQUEST") 		//구매의뢰서 번호
	                //+ "v_ds_ma_request" 	+ ds_default.namevalue(ds_default.rowposition,"DS_MA_REQUEST")		//contents
	                //+ "v_ty_buytype" 		+ ds_default.namevalue(ds_default.rowposition,"TY_BUYTYPE")			//구매근거
	                //+ "v_remark" 			+ ds_default.namevalue(ds_default.rowposition,"REMARK")				//비고
                	);

 		
		//prompt(this, ds_default.text);
   			 		
        tr_post(tr1);



        		
        		
	}
	

	
    
    <%//행추가%>
    function fnAddRowDt1(){
    	
    	ds_default.addrow();
    	
    	//ds_default.namevalue(ds_default.RowPosition, "NO_MA_REQUEST")= "자동채번";
    	ds_default.namevalue(ds_default.RowPosition, "NO_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>" + '0000';
    	
    	//행추가시 의뢰일자 자동 출력. (현재 날짜로 출력)
    	ds_default.namevalue(ds_default.RowPosition, "DT_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>";
    	
    	//행추가시 의뢰자 자동 출력. (성명으로 출력)
    	ds_default.namevalue(ds_default.RowPosition, "NM_REQUEST")="<%=gusrnm%>";
    	
    	//행추가시 구매근거 자동 출력. (선택으로 출력)
    	ds_default.namevalue(ds_default.RowPosition, "TY_BUYTYPE")= " ";
    	
    	//행추가시 상태 자동 출력. (작성중으로 출력)
    	ds_default.namevalue(ds_default.RowPosition, "TY_APPROVAL")= "작성중";
    	
    	
    	
    	ds_default.namevalue(ds_default.RowPosition, "ca_sid") = ds_default.namevalue(ds_default.RowPosition,"CA_SID");
    	ds_default.namevalue(ds_default.RowPosition, "canbr") = ds_default.namevalue(ds_default.RowPosition,"CANBR");

		msgTxt.innerHTML=" 행이 삽입되었습니다.";		
		
		
		
    }
    
    
    <%//행삭제%>
	 function fnc_deleterow() {


		   		if(ds_default.countrow > 0 ) {

		   			
			        if(confirm("행삭제하시면 바로 삭제됩니다.\n\n삭제하시겠습니까?")==false){
			        	
			            return;
					}				   			

					
					for (var i=1;i<=ds_default.countrow;i++){
						
						if (ds_default.namevalue(i,"CHK") =="T"){

							ds_default.DeleteRow(i);
							
							i--;
							
					 		ln_TRSetting(tr1, 
					                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
					                "JSP(I:DS_DEFAULT=ds_default)",
					                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				                	);

							//prompt(this, ds_default.text);
					   			 		
					        tr_post(tr1);

						} 
						
					}
	
					
				}else{
					
					alert("데이터가 존재하지 않습니다");
					
				}

		   		fnSelect();
		   		
		   		
	}
   


   <%//승인요청%>
   function fnRequest(){

		v_job = "A";
	   
        if (confirm("승인요청하시겠습니까?")){

	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
					         + ",v_stat=R" 				//승인요청 status
		                	 );

		//prompt(this, ds_default.text);
			 		
        tr_post(tr1);

		}

	}
   

    </script>
    
    
    

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">


	if(v_job=="A"){
		
		alert("성공적으로 처리되었습니다.");
		
		fnSelect();
	}
	
	
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

	<!-- 조회 팝업 -->
	<script language=javascript  for=gr_cul event=OnPopup(Row,Colid,data)>
	
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;
		var strPos;

		
		//컬럼 값이 PLJ_NM 'Project'이면 실행해라.
		if(Colid == "PLJ_NM"){
			
			
			//값 가져오는거
			strURL = "<%=dirPath%>/Pms/new/pur/rq012.jsp";
			
			strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,'',strPos);
			
			if(ds_default.namevalue(ds_default.rowposition,"PLJ_NM") == ""){
				
				if (arrResult != null) {

		    		arrParam = arrResult.split(";");
		    	   	
		    		ds_default.namevalue(ds_default.rowposition,"PLJ_NM")=arrParam[1];
		    		ds_default.namevalue(ds_default.rowposition,"COST_CD")=arrParam[0];
		    		
		        }else{

		        	ds_default.namevalue(ds_default.rowposition,"PLJ_NM")="";
		        	ds_default.namevalue(ds_default.rowposition,"COST_CD")="";
		        	
		        }
				
			}
			
			

		//컬럼 값이 거래처이면 실행해라.
		}else if(Colid == "VEND_NM"){


			if (ds_default.namevalue(ds_default.rowposition,"TY_BUYTYPE") != "H"){
				
				alert("구매근거가 현업추천일 경우에만 선택가능합니다");
				
				return;

			}
			
	        strURL = "<%=dirPath%>/Pms/new/pro/gczm_vender_popup.jsp";
  	    	
  	    	strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:no";
  	    	
  	    	arrResult = showModalDialog(strURL,'',strPos);
  	    	
  	    	if (arrResult != null) {

  	    		arrParam = arrResult.split(";");

	    		ds_default.namevalue(ds_default.rowposition,"VEND_CD")=arrParam[0];
	    		ds_default.namevalue(ds_default.rowposition,"VEND_NM")=arrParam[1];  	    		

  	        }    

		}
		

	</script>
		
	
	<script language=javascript  for=gr_cul event=OnClick(Row,Colid)>

    
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;
		var strPos;
	
    	//컬럼 값이 FUNC이면 구매의뢰 화면으로 이동하라
		if(Colid == "FUNC"){
			
			//값 보내는 부분

			 if (ds_default.namevalue(ds_default.rowposition,"COST_CD")!="") {
				 
				 arrParam[0] = ds_default.NameValue(ds_default.rowposition,"NO_MA_REQUEST");		//구매의뢰서 번호
		         arrParam[1] = ds_default.NameValue(ds_default.rowposition,"COST_CD");				//Project Code
		         arrParam[2] = ds_default.NameValue(ds_default.rowposition,"PLJ_NM");				//Project
		         
		         strURL = "<%=dirPath%>/Pms/new/pur/rq011.jsp";
		         
			 	 strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
			 	 
			     arrResult = showModalDialog(strURL,arrParam,strPos);
			     
			     sApproveLine = arrResult; 
			
			} 

	    }
    	
    </Script>
    
    
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




<jsp:include page="/Common/sys/body_s10.jsp"/>

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
							<img src="<%=dirPath%>/Sales/images/save.gif"  		style="cursor:pointer" onclick="fnApply()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>     
        
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="1002px">
           			<tr>
                        <td align="center" class="text" width="90">Project</td>
                        <td align="left" bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_project' id="v_project" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">                        
                        </td>
					</tr>
           		</table>
            </td>
        </tr> 
        
        
        <tr height='10px'>
            <td></td>
        </tr>
        
        
        <tr>
        	<td height='30px' align='right'>
        		<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:pointer" onClick="fnAddRowDt1()" >
        		<img src="<%=dirPath%>/Sales/images/minus.gif"		style="cursor:pointer" onClick="fnc_deleterow()" >
        		<img src="<%=dirPath%>/Sales/images/request.gif"	style="cursor:pointer" onClick="fnRequest()" >
        	</td>
        </tr>
        
        
        <tr>
            <td valign="top">
                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='450px' border='1'>
                    <param name="DataID"            value="ds_default">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
					<param name=ColSelect    		value="True">
					<param name="ColSizing"         value="true">																								                                        
                    <param name="Format"            value="
                    	<C> name='선택'					ID=CHK						width=40 	align=center 	bgcolor=#f5f5f5 	EditStyle=CheckBox	 cursor=hand	 sort=false</C>
                    	<C> name='구매의뢰서 번호'		ID='NO_MA_REQUEST'			width=90 	align=CENTER  	edit=none			mask='XXXXXXXX-XXXX'</C>
                    	<C> name='Code'					ID='COST_CD'				width=50 	align=CENTER 	show=false 			</C>                 	
                        <C> name='Project'				ID='PLJ_NM'					width=180 	align=left	 	EditStyle=Popup 	</C>
                        <C> name='Contents'				ID='DS_MA_REQUEST'   		width=130 	align=left		</C>
                        <C> name='의뢰일자' 			ID='DT_MA_REQUEST'			width=70 	align=CENTER	decao=0  			mask='XXXX-XX-XX'	edit=none	readonly=true		</C>
                        <C> name='의뢰자'				ID='NM_REQUEST' 			width=70 	align=CENTER	readonly=true </C>
                        <C> name='구매근거'				ID='TY_BUYTYPE' 			width=70 	align=CENTER	EditStyle=Combo		 Data=' :선택,A:일반구매,H:현업추천'</C>
                        <C> name='상태'					ID='TY_APPROVAL'			width=70 	align=CENTER 	edit=none	readonly=true</C>
                        <C> name='거래처'				ID='VEND_CD'				width=70 	align=CENTER	show=false 	   </C>                        
                        <C> name='거래처'				ID='VEND_NM'				width=100 	align=left 		EditStyle=Popup</C>
                        <C> name='비고'					ID='REMARK'					width=80 	align=left		</C>
                        <C> name='작성'					ID='FUNC'					width=80 	align=center	Color='red' value={'구매의뢰'}</C>
                 ">                             
                </object>                 
            </td>
        </tr>
 
    </table>
    
    <table border='0' cellpadding='0' cellspacing='0'> 
        <tr>
            <td valign="top">
		            <br>※ 처리 프로세스<br>
		            　			    1. <b><font color=red>행추가</font></b>　 : 구매의뢰에 대한 Master 값을 만듭니다. 버튼 클릭후 Project column을 더블클릭해서 Project를 선택합니다.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;2. <b><font color=red>구매의뢰 작성</font></b>　 : [구매의뢰] 버튼을 누르면, 구매의뢰하는 화면으로 이동합니다.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;3. <b><font color=red>승인요청</font></b>　 : [승인요청] 버튼을 누르면, 승인요청 상태로 넘어갑니다.				
            </td>
        </tr>
    </table>    
    
    
</body>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


