<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : Dash Board
 * 프로그램ID 	 : PMS/dsh
 * J  S  P		 : dsh010.jsp
 * 서 블 릿		 : dsh010
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2018-06-14
 * 기능정의		 : Dash Board
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("gr_default"), "comn");

		fnInit();
		
	}
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";

		fnSelect();
        
    }
    
    
    <%//메인 조회  %>
    function fnSelect() {

		    v_job="S";
		    
			var v_code = document.getElementById("v_code").value;
			
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
													+ ",v_code=" + v_code	    	
							                  		+ ",v_project=" + v_project.value 						//project명
							    					;
	    	
	    	
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh010",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        

    }    
    




</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>




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
	

	
  <script language="javascript"  for=gr_default event=OnDblClick(Row,Colid)>
  
	  if(Colid=="COST_IN"){
		  
	     	// alert("현재 매출액에 대한 증빙을 보여줄 예정입니다.");
			
			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			
	      	strURL = "<%=dirPath%>/Pms/new/dsh/dsh012.jsp";
	      	
			strPos = "dialogWidth:1000px;dialogHeight:650px;status:yes;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			sApproveLine = arrResult; 
			
	  }else if(Colid=="COST_OUT"){
		  
		  	//alert("현재 매입액에 대한 증빙을 보여줄 예정입니다.");
		  
		 	var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			
	      	strURL = "<%=dirPath%>/Pms/new/dsh/dsh013.jsp";
	      	
			strPos = "dialogWidth:1000px;dialogHeight:650px;status:yes;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			sApproveLine = arrResult; 
			
	  }else{
		  
		  
		  	//alert("상세보기페이지로 넘어갑니다.");
		  
		  	var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			
	      	strURL = "<%=dirPath%>/Pms/new/dsh/dsh011.jsp";
	      	
			strPos = "dialogWidth:1020px;dialogHeight:800px;status:no;scroll:yes;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			//sApproveLine = arrResult; 
		  
	  }
  
   
   	
  </script>

	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  		value="false">
    <param name=SubSumExpr          value="total ,    1:GROUP_NM">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>

</head>


<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="1000px"> 
    
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='1000px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
                    			<tr>
                    				 <td align=left class="text"  width="100">구분</td>
                    				 <td align=left class="text"  width="150" bgcolor="#ffffff"> 
                    				 	<select id=v_code style="WIDTH:140" onChange="fnSelect();">
					                        <option value="00">선택</option> 
					                        <option value="01">관광</option>                
					                        <option value="02">MICE</option>                    
					                        <option value="03">건설</option>
					                        <option value="04">경협</option>
					                        <option value="05">개성</option>
					                    </select>
             				        </td>
			                        <td align=left class="text"  width="100">프로젝트</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
                                       <input type="text" name='v_project' id="v_project" style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">&nbsp;                               
                                       <button type="button" onclick="fnSelect();"> 검색</button>
			                        </td>
			                        
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="1000px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
									 <C> name='No'				ID='{CurRow}'		 	width=40 	align=CENTER    </C>
									 <C> name='GROUP'			ID='GROUP_NM'    		width=50 	align=CENTER 	suppress=1  Value={Decode(CurLevel,0,GROUP_NM,1,' 소계',9999,' 총계')}</C>
                                     <C> name='Code'			ID='COST_CD'    		width=70 	align=CENTER	show=false</C>
                                     <C> name='프로젝트' 			ID='PLJ_NM'    			width=290 	align=LEFT		</C>                                                              
                                     <C> name='시작일자'			ID='STARTDT' 			width=100 	align=CENTER	show=false</C>
                                     <C> name='종료일자'			ID='ENDDT' 				width=100 	align=CENTER	show=false</C>  
                                     <C> name='도급금액'			ID='ORDER_AMT_NOW'    	width=150 	align=right		DECAO=0 sumtext=@sum</C>                                     
                                     <C> name='실행금액'			ID='EXE_ACT_AMT_NOW'    width=150 	align=right		DECAO=0 sumtext=@sum</C>                                                                
                                     <C> name='현재매출액'			ID='COST_IN'    		width=100 	align=right		DECAO=0 sumtext=@sum </C>
                                     <C> name='현재매입액'			ID='COST_OUT'    		width=100 	align=right		DECAO=0 sumtext=@sum</C>
                                     <C> name='현재잔액'			ID='COST'    			width=100 	align=right		DECAO=0 bgColor='#D1B2FF' sumtext=@sum</C>                                     
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