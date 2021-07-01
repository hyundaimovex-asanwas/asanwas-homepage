
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
    SmartRequest sr = new SmartRequest(request);
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	
%>




    


<!-- HTML 시작-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
	<jsp:include page="/Pms/common/include/head.jsp"/>	
	

    
<script language="javascript">

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	
    
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//project list

		fnInit();

	}
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    
        fnSelect();
        
    }
    
    
    <%//기본 온로드  %>
    function fnSelect() {
    	
   	 v_job="S";
   	 //변수값 넣어주기 
	   	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"        ;
	   	
	   	// ",v_fr_rqst_date=" + fr_date    + ",v_to_rqst_date=" + to_date    + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index)
   		ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd010",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);
  	
        tr_post(tr1);
		        
		        
    }
    
    
    <% //프로젝트 검색시 %>
    function fnReSearch(){
    	
    	v_job="S";
    	
    	//alert("조회가 눌렸습니다." + document.getElementById("pro_text").value );
    	
    	// 검색 값 관련 
    	var pText = document.getElementById("pro_text").value;
    	
    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							    		+ ",v_project=" + pText 
							    		+ ",v_stat=" + v_stat.value						    		
							    		+ ",v_kind=" + "1"
							    		;
    	
    	ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd010",
                "JSP(O:DS_DEFAULT=ds_default)",
                param);
    	
            tr_post(tr1);
            
    }
    
    
    
    <%//행추가%>
    function fnAddRowDt1(){
    	
    	var img = document.getElementById('saveImg');
    	
    	img.style.visibility = 'visible';
    	
    	ds_default.addrow();
    	
    	//ds_default.NameValue(ds_default.rowposition,"TY_BUDGET")
    	
    	txtView.innerHTML="추가행 관련 더블 클릭시 행삭제가 가능합니다.";
    	
    	ds_default.NameValue(ds_default.rowposition,"I_EMPNO")="<%=gusrid%>";		
    	
    	
    }    
    
    
    <%//저장버튼 클릭 %>
    function fnAddSave(){
    	
   		 v_job = "A";

    	var img = document.getElementById('saveImg');
    	
    	var V_COST_CD = ds_default.NameValue(ds_default.rowposition,"COST_CD"); 	// 원가코드
    	
    	var V_TY_BUDGET = ds_default.NameValue(ds_default.rowposition,"TY_BUDGET"); // 구분  가예산 (A)입찰예산(B) 실행예산(C)
    	
    	var V_DS_BUDGET = ds_default.NameValue(ds_default.rowposition,"DS_BUDGET"); //적요 내용
    	
    	var V_PLJ_NM = ds_default.NameValue(ds_default.rowposition,"PLJ_NM"); 		//적요 내용
    	
    	var V_I_EMPNO =<%=gusrid%>; // 사원번호 
    	
    	
    	//행번 출력 
		var v_default_row = ds_default.RowPosition;
    	
    	//alert("DS_BUDGET"+V_DS_BUDGET+"sdsdsd"+(ds_default.rowposition,"DS_BUDGET"));
    	
      	var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
		    		+ ",v_default_row=" + v_default_row;
    	       
      	var RowCnt = ds_default.CountRow;
      	
		
		var V_COST_CD_txt ;
		
		var V_TY_BUDGET_txt ;
		
		var V_DS_BUDGET_txt ;
		
		var V_PLJ_NM_txt ;
		
		
		
		for(i=1; i<=RowCnt; i++){
			
			V_COST_CD_txt = ds_default.NameValue(i,"V_COST_CD");
			
			V_TY_BUDGET_txt = ds_default.NameValue(i,"TY_BUDGET");
			
			V_DS_BUDGET_txt = ds_default.NameValue(i,"DS_BUDGET");
			
			V_PLJ_NM_txt = ds_default.NameValue(i,"PLJ_NM");
			
			if(V_COST_CD_txt == ""){
				alert(i+"번째의 행의 COST_CD를 입력해 주시길 바랍니다." );
				ds_default.RowPosition = i;
				return false;
			}else if(V_TY_BUDGET_txt == ""){
				alert(i+"번째의 행의 COST_CD를 입력해 주시길 바랍니다." );
				ds_default.RowPosition = i;
				return false;
			}else if(V_DS_BUDGET_txt == ""){
				alert(i+"번째의 행의 COST_CD를 입력해 주시길 바랍니다." );
				ds_default.RowPosition = i;
				return false;
			}else if(V_PLJ_NM_txt == ""){
				alert(i+"번째의 행의 COST_CD를 입력해 주시길 바랍니다." );
				ds_default.RowPosition = i;
				return false;
			}

		}
      	
		
		
      	if(V_DS_BUDGET != '' && V_TY_BUDGET !='' ){
      		
	    	ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd010",
		                "JSP(I:DS_DEFAULT=ds_default)",
		                param);
	    	
	        tr_post(tr1);
	        		
	        
       		img.style.visibility = 'hidden';
       		
       		fnReSearch();
	            	
		}
      	
    }
    
</script>



<!-- 팝업창 -->
<script language=JavaScript for=gr_default event=OnPopup(Row,Colid,data,xpos,ypos)>

		var cost_cd = ds_default.NameValue(ds_default.rowposition,"COST_CD");
		var no_budget =  ds_default.NameValue(ds_default.rowposition,"NO_BUDGET");	
		
		
		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;
					
		if(Colid == "PLJ_NM"){
			
				strURL = "<%=dirPath%>/Pms/new/bud/bd015.jsp";
				
				strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				
				arrResult = showModalDialog(strURL,arrParam,strPos);
				
				sApproveLine = arrResult; 
				
				//프로젝트 리턴값 삽입 

				if (arrResult != null) {
					
					//alert("arrResult !null   ->"+arrResult);
		    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
		    	   	
		    		arrParam = arrResult.split(";");
		    		
		    	   	ds_default.namevalue(ds_default.rowposition,"COST_CD")=arrParam[0];		
		    	   	ds_default.namevalue(ds_default.rowposition,"PLJ_NM")=arrParam[1];	

				}
				
				
		}	
		
		
		 if(Colid == "DS_BUDGET"){
			 
			 arrParam[0] = cost_cd;
			 arrParam[1] = no_budget;
			 
		//	 alert("여기로 넘어 오나용?"+arrParam[0] +arrParam[1] );
		
			strURL = "<%=dirPath%>/Pms/new/bud/bd020.jsp";
			
			strPos = "dialogWidth:1000px;dialogHeight:900px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
		} 
		
</script>



<!-- 더블클릭 추가 행 제거  보류 for=gr_default  -->
 <script language=JavaScript for=gr_default event=OnDblClick(row,colid)>

	  	var cost_cd_value =ds_default.NameValue(ds_default.rowposition,"COST_CD");
		var cost_cd = ds_default.NameValue(ds_default.rowposition,"COST_CD");
		var no_budget =  ds_default.NameValue(ds_default.rowposition,"NO_BUDGET");	  	
	  	var approval_value =ds_default.NameValue(ds_default.rowposition,"TY_APPROVAL");  	
	  	
	  	//alert(colid);
	  	
		if(colid == 'DS_APPROVAL'){
			

			if(approval_value == 'S'){
		
				  ds_default.DeleteRow(row);
				  
			}else if(approval_value == 'R'){
				
				alert("승인요청중인 건은 지울수 없습니다.");
				
			}else if(approval_value == 'Y'){
				
				alert("승인완료된 건은 지울수 없습니다.");
			}
		
		}else if(colid == 'COST_CD'){
		
		
			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
		
		
		 	arrParam[0] = cost_cd;
		 	arrParam[1] = no_budget;
		 
		 	//alert("여기로 넘어 오나용?"+arrParam[0] +arrParam[1] );
	
			strURL = "<%=dirPath%>/Pms/new/bud/bd021.jsp";
		
			strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
		
			arrResult = showModalDialog(strURL,arrParam,strPos);
		
		
		}

	 
 </script> 


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

    
</script>


<script language=JavaScript for=tr1 event=OnFail()>

alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
    
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
 	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
 	
        msgTxt.innerHTML="조회가 완료 되었습니다.";

	</script> 

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>



</head>


<!-- //body_s.jsp -->
<jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->

<!--------------------------------- 코딩 부분 시작 ------------------------------>     
<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
			     		<td align=right>
							<img src="<%=dirPath%>/Sales/images/save.gif" 		id="saveImg" style="visibility: hidden;"	style="cursor:pointer" onClick="fnAddSave()" >							
			     		
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnReSearch()">
        					<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:pointer" onClick="fnAddRowDt1()" >
                        </td>								
                    </tr>
                </table>
            </td>
        </tr>
	<tr><td height=4></td></tr>
</table>
        
        
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>

            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>
                        <td align="left" class="text" width="90">프로젝트</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                             <input type="text" name='pro_text' id="pro_text" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnReSearch();" value="">                               
                        </td>                         
                        <td align=left class="text">상태</td>
						<td align="left" bgcolor="#ffffff" WIDTH="300">&nbsp;
							<select name="v_stat" id="v_stat" onChange="fnReSearch();">
								<option value="A">전체</option>
								<option value="S">작성중</option>								
								<option value="R">승인요청</option>
								<option value="Y">승인완료</option>
							</select>		
                        </td>	
					</tr>

           		</table>
            </td>	
	</tr>
	

  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>
        

        <tr>
            <td valign="top">
                <object id="gr_default" classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="ColSizing"         	value="true">
                    <param name="Editable"          	value="true">
                    <param name="ComboDataID"      		value="ds_gc_ccstat">
                    <param name="SuppressOption"    	value="1">
                    <param name="BorderStyle"       	value="0">
                    <param name=ColSelect    			value="True">
                    <param name="Format"            value="
	                     <C> name='NO' 				ID='{CurRow}'	   	width=30 		align=CENTER		show=TRUE	 		EditStyle = OnDblClick({CurRow}) </C><!--EditStyle = OnDblClick({CurRow})  -->
                      <G>name='PROJECT'
                         <C> name='코드' 			ID='COST_CD'    	width=50 		align=CENTER 		edit=none	 		show=true</C>
                         <C> name='프로젝트' 		ID='PLJ_NM'   		width=150 		align=LEFT			EditStyle=Popup 	readonly=true  suppress=1</C> 
                      </G>
                         <C> name='실행\\차수' 		ID='NO_BUDGET'    	width=50 		align=CENTER 		edit=none</C>
                         <C> name='구분' 			ID='TY_BUDGET'    	width=80 		align=CENTER  		EditStyle=Combo		Data='A:가예산,B:입찰예산,C:실행예산'	   bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='Content' 		ID='DS_BUDGET'   	width=130 		align=LEFT			</C><!-- EditStyle=Popup -->
                         <C> name='도급금액' 		ID='ORDER_AMT'   	width=70 		align=right	 		edit=none decao=0</C>
                         <C> name='실행금액' 		ID='EXE_AMT'   		width=70 		align=right	 		edit=none decao=0</C>
                         <C> name='작성일'    		ID='DT_REQUEST'    	width=70 		align=CENTER	  	edit=none mask='XXXX-XX-XX' </C>
                         <C> name='작성자'   		ID='NM_REQUEST'   	width=70 		align=CENTER	 	show=true edit=none	</C>
                         <C> name='승인일' 			ID='DT_CONFIRM'    	width=70 		align=CENTER		edit=none mask='XXXX-XX-XX'</C>
                         <C> name='승인자' 			ID='NM_CONFIRM'    	width=70 		align=CENTER	 	edit=none</C>
                         <C> name='진행상태' 		ID='DS_APPROVAL'    width=70 		align=CENTER	 	edit=none</C>
                         <C> name='진행상태' 		ID='TY_APPROVAL'    width=70 		align=CENTER	 	edit=none show=false</C>                         
                 ">                             
                </object>   
 		    </td>
        </tr>

    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		