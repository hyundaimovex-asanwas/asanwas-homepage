<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Dash Board Detail</title>
<jsp:include page="/Pms/common/include/head.jsp"/>
<script type="text/javascript">
	
	
	<%//페이지로딩 %> 
 	function fnOnLoad(){

 		fnInit();
 		
 	}
	
 	
    <%//초기 작업  %>
	function fnInit(){
		
		fnSelect();
         
	}
	
	
    <%//메인 조회  %>
    function fnSelect() {

		    v_job="S";
		    
			var strParam = new Array();	//팝업시 받아오는 파라미터들
			
	 		strParam = window.dialogArguments;

			var v_project =  strParam[0]; 
	     
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project=" + v_project
										;
		
	        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh012",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);
	           
	        tr_post(tr1);
	        

    }    
	
    
    <%//데이타 재설정  %>
    function fnData_Reset(p) {

    	//그리드에 출력
      	var strno="";
      	var dblDEMMSum=0;//차변월계
    	var dblCRMMSum=0;//대변월계
    	var dblDEATSum=0; //차변계정별 누계
    	var dblCRATSum=0; //대변계정별 누계
    	var dblDECTSum=0; //차변원가코드별 계
    	var dblCRCTSum=0; //대변원가코드별 계
    	var dblJanSum=0;  //대변원가코드별 계

    	var dblDEATSum_TOT=0; //차변계정별 누계합계
    	var dblCRATSum_TOT=0; //대변계정별 누계합계
    	var dblJanSum_TOT=0;  //총합계 잔액합계
    	

    	var aa=0;
    	
    	//순번 설정
      	for(i=1;i<=ds_default.countrow;i++){
      		
    		dblDEMMSum = dblDEMMSum + ds_default.namevalue(i,"DETOT");
    		dblCRMMSum = dblCRMMSum + ds_default.namevalue(i,"CRTOT");
    		
    		dblDEATSum_TOT = dblDEATSum_TOT + ds_default.namevalue(i,"DETOT");
    		dblCRATSum_TOT = dblCRATSum_TOT + ds_default.namevalue(i,"CRTOT");
    		
    		if(ds_default.namevalue(i,"GUBUN")=="M"){       //월계
    			
    		     ds_default.namevalue(i,"SSDAT") = "월 계"
                 ds_default.namevalue(i,"DETOT") = dblDEMMSum;
    			 ds_default.namevalue(i,"CRTOT") = dblCRMMSum;
    			 ds_default.namevalue(i,"JANAMT") = dblJanSum;
    			 
                 dblDEATSum = dblDEATSum +dblDEMMSum;
                 dblCRATSum = dblCRATSum +dblCRMMSum;
                 dblDEMMSum=0;
                 dblCRMMSum=0;
                 
    		}else if(ds_default.namevalue(i,"GUBUN")=="T"){ //누계
    			
    		     ds_default.namevalue(i,"SSDAT") = "누 계"
    		     ds_default.namevalue(i,"DETOT") = dblDEATSum;
    			 ds_default.namevalue(i,"CRTOT") = dblCRATSum;
    			 ds_default.namevalue(i,"JANAMT")= dblJanSum;
    		     
    			 dblDECTSum=dblDECTSum + dblDEATSum; //차변원가코드별 계
    	         dblCRCTSum=dblCRCTSum + dblCRATSum; //대변원가코드별 계
    	         
                 dblDEATSum =0;
                 dblCRATSum =0;

    		}else if(ds_default.namevalue(i,"GUBUN")=="C"){  //원가계
    			
    		     ds_default.namevalue(i,"SSDAT") = "원가계"
           		 ds_default.namevalue(i,"DETOT") = dblDECTSum;
    			 ds_default.namevalue(i,"CRTOT") = dblCRCTSum;
    			 ds_default.namevalue(i,"JANAMT") = dblJanSum;
    			 dblJanSum_TOT = dblJanSum;
    			 dblDECTSum=0;
    			 dblCRCTSum=0;
    			 dblJanSum =0;
    			 
    		}else{ 
    			
    			 dblJanSum = dblJanSum + ds_default.namevalue(i,"DETOT");
    			 ds_default.namevalue(i,"JANAMT") = dblJanSum;
    			 
    		}
    		
    	}


         //alert("dblDEATSum_TOT::"+dblDEATSum_TOT);
         //2007.05.19 정영식 누계의 총합계 추가
       	 gcgd_disp.DataID = "ds_default";
         
    	 ds_default.Addrow();
    	 
    	 ds_default.namevalue(ds_default.rowposition,"GUBUN") = "A"    	 
    	 ds_default.namevalue(ds_default.rowposition,"SSDAT") = "총합계"
    	 
    	 ds_default.namevalue(ds_default.rowposition,"DETOT") = dblDEATSum_TOT;
    	 ds_default.namevalue(ds_default.rowposition,"CRTOT") = dblCRATSum_TOT;
    	 ds_default.namevalue(ds_default.rowposition,"JANAMT") = dblJanSum_TOT;
	        

    }      
    
    
    
    
    
    
  	<%//액셀 다운하기%>
    function fnExcel() {


    		gcgd_disp.GridToExcel("프로젝트별","",2);
    	
    		/*
	        getObjectFirst("gcgd_disp").SetExcelTitle(0, "");
	        getObjectFirst("gcgd_disp").SetExcelTitle(1, "value:전체예산; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gcgd_disp").GridToExcel("프로젝트별", "프로젝트별.xls", 8);        
			*/

    }	          
    
</script>


<script language="javascript"  for=gcgd_disp event=OnDblClick(Row,Colid)>

		
			
</script>
			
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="S"){
		
		//fnData_Reset("00"); //데이타 재설정	
		
	}


</script>





<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
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
<%=HDConstant.COMMENT_END%>



</HEAD>

<jsp:include page="/Common/sys/body_s11.jsp"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:980px;border:0 solid #708090">
		<tr>
				<td >
					<h4>매출 Detail</h4>
				</td>
		        <td align=right >
	        		<img src="<%=dirPath%>/Sales/images/excel.gif"					style="cursor:pointer" onclick="fnExcel()">
				</td>
		</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<OBJECT classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_disp style="width:980;height:500px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"				VALUE="ds_default">
			  <PARAM NAME="BorderStyle" 		VALUE="0">
			  <PARAM NAME="Indwidth"			VALUE="0">
			  <PARAM NAME="Fillarea"			VALUE="true">
			  <param name="sortview"     		value=left>
			  <param name="ColSizing"         	value="true">
              <param name="Editable"          	value="false">
              <param name="SuppressOption"    	value="1">
              <param name="ViewSummary"       	value="1">
			  <PARAM NAME="Format"				VALUE="  
				<C> Name='프로젝트명'	ID=FSREFNM   	HeadBgColor=#B9D4DC Width=300 	align=left 	</C>
				
				<C> Name='계정코드'		ID=ATCODE 		HeadBgColor=#B9D4DC Width=130 	align=center show=false</C>				
				<C> Name='계정과목'		ID=PRTNAM 		HeadBgColor=#B9D4DC Width=200 	align=left 	BgColor={decode(ATCODE,'0000001','#0054FF','0000002','#FF5A5A','9999999','#FAED7D','')}</C>
				
				<C> Name='금액'	    	ID=AMT02  		HeadBgColor=#B9D4DC Width=200 	align=right  BgColor={decode(ATCODE,'0000001','#0054FF','0000002','#FF5A5A','9999999','#FAED7D','')}</C>
				<C> Name='금액'	    	ID=AMT01   		HeadBgColor=#B9D4DC Width=200 	align=right  BgColor={decode(ATCODE,'0000001','#0054FF','0000002','#FF5A5A','9999999','#FAED7D','')}</C>

				">
	    </OBJECT>
		</td>  
	</tr>

</table>

</body>

</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



