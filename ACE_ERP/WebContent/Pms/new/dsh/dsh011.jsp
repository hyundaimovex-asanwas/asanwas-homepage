<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
	//첨부파일 
		String virtual_name	= "";
		String real_name		= "";
		String fullFilename	= "";
		String fileNameList = "";	//파일 리스트 보관용 (수정시)
		Tbrd_attach_file_de_bean[] fileRecord = null;	//파일 첨부용 빈~!
		
		 SmartRequest sr3 = new SmartRequest(request);
		 My710Manager manager3 = new My710Manager();
	     My710DTO dto = manager3.select(sr3);
		
		//파일리스트 html 만들기
	    StringBuffer sb = new StringBuffer();
		String real_fileList = dto.getReal_file();	//값을 불러와서 
		String sys_fileList = dto.getSys_file();
		fileNameList = real_fileList;				// 시스파일 리스트를 담음.

		String real_file[] = real_fileList.split(":");	//배열로 정리
		String sys_file[] = sys_fileList.split(":");	//배열로 정리
		
			for(int j=0; j<sys_file.length; j++){

				sb.append("<option value='"+sys_file[j]+ "'>" + real_file[j] +"</option>"); 
			};

		//첨부란에 넣을 html코드 만들기                     
	 	fullFilename = sb.toString();   
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <script type="text/javascript">
    	
    	//fnOnLoad();


		var strParam = new Array();	//팝업시 받아오는 파라미터들
		
 		strParam = window.dialogArguments;

 		var v_project =  strParam[0]; 
    	

        <%// fnOnLoad  %>
	    function fnOnLoad(){
	    	
            document.getElementById("v_project").value = v_project;

			
	    	cfStyleGrid(getObjectFirst("gr_sales"), "comn");	//project list
	    	cfStyleGrid(getObjectFirst("gr_ksitem"), "comn");	//project list
			cfStyleGrid(getObjectFirst("gr_suOne"), "comn");
			cfStyleGrid(getObjectFirst("gr_suTwo"), "comn");
			
			fnSelect();
			
	    }
	    
    
	    <%//메인 조회  %>
	    function fnSelect() {

			    v_job="S";


 				var v_project =  document.getElementById("v_project").value;


			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project							//project 코드			
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
				          "JSP(O:DS_TAB1=ds_tab1)", 							
				          v_param);

			    tr_post(tr1);	
		        
	    }    
   
	    
	    
	    
	    
	    
	    <%//수행인원 행추가%>
	    function fnAddRow_person(){

	    	ds_tab3.addrow();

	    	ds_tab3.NameValue(ds_tab3.rowposition,"SEQ") = ds_tab3.countrow;
	    	ds_tab3.NameValue(ds_tab3.rowposition,"COST_CD") = document.getElementById("v_project").value;
	    	
	    	alert("수행 직원 입력 후\n\n저장 버튼을 누르시기 바랍니다.");
	    
	    }  
	    
	    
	    
	    <%//수행인원 행삭제%>
	    function fnDeleteRow_person(){
	    	
	        if(confirm("행삭제하시면 바로 삭제됩니다.\n\n삭제하시겠습니까?")==false){
	        	
	            return;
			}	    	
	        
	    	ds_tab3.DeleteRow(ds_tab3.RowPosition);

			var v_project = document.getElementById("v_project").value;
		    
			var param   = "v_project"	+ v_project				//project code     
						;
			
			
			ln_TRSetting(tr3, 
			            "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
			            "JSP(I:DS_TAB3=ds_tab3)",
			            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
			            param
			        	);
			
			//prompt(this, ds_tab3.text);
			
			tr_post(tr3);
			
	    }  
	    
   
	    <%//직원 수행인원 검색%>
	    function fnEmpNoPopup(dirPath, row){
	    	
	    	var arrParam	= new Array();
	    	var arrResult	= new Array();
	    	var strURL;	
	    	var strPos;
			
	    	strURL = dirPath+"/Pms/new/pro/empno_popup.jsp";
	    	
	    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    	
	    	arrResult = showModalDialog(strURL,'',strPos);
	    	
	    	if (arrResult != null) {
	    		
	    	   	//alert(arrResult);//EMPNO", "EMPNMK", "DEPTNM", "PAYGNM", "JOB_CD"
	    	   	
	    		arrParam = arrResult.split(";");
	    	   	
	    		ds_tab3.namevalue(row, "ENO_NO") = arrParam[0]; 
	    		ds_tab3.namevalue(row, "ENO_NM") = arrParam[1];
	    		ds_tab3.namevalue(row, "JOB_NM") = arrParam[3];	 	    		
	    		ds_tab3.namevalue(row, "JOB_CD") = arrParam[4];	    		


	        }    
	    	
	    }	    
	    
	    <%//수행인원 저장%>
	    function fnApply_person(){

	    	v_job="A";
	    	
	    	
			for(i=1; i<=ds_tab3.countrow; i++){
				
				ENO_NO = ds_tab3.NameValue(i,"ENO_NO");
				FR_DT = ds_tab3.NameValue(i,"FR_DT");
				TO_DT = ds_tab3.NameValue(i,"TO_DT");
				
				if(ENO_NO == ""){
					alert("수행인원을 입력해 주시길 바랍니다." );
					return false;
				}else if(FR_DT == ""){
					alert("투입시작일자를 입력해 주시길 바랍니다." );
					return false;
				}else if(TO_DT == ""){
					alert("투입종료일자를 입력해 주시길 바랍니다." );
					return false;
				}

			}
			
	    	
			var v_project = document.getElementById("v_project").value;
			    
			var param   = "v_project"	+ v_project				//project code     
						;
			
			
			ln_TRSetting(tr3, 
			            "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
			            "JSP(I:DS_TAB3=ds_tab3)",
			            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
			            param
			        	);
			
			//prompt(this, ds_tab3.text);
			
			tr_post(tr3);
			
			
	    }  
	    
	    
	    
    <%// File UPload %>
	function fnUpload() {	

			f = document.fileForm;
			
		    
			if(f.file1.value.length == 0 || f.file1.value == "첨부파일은최대10M까지가능합니다.")
			{
				alert('업로드할 파일을 선택하여 주십시요');
				
				return;
			}
		
			
			var realFileName = f.file1.value;
			
			var idx = realFileName.lastIndexOf("\\");
			
			realFileName = realFileName.substring(idx+1);
			
			//alert(realFileName);
			
			if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
				
				alert("저작권 문제의 소지가 있는 mp3, wma, asf 형식의 음악파일 첨부는 되지 않습니다.");
				
				return;
				
			}
			
			strArray = realFileName.split("."); 
			strArray2 = realFileName.split("|"); 
			strArray3 = realFileName.split("_");
			strArray4 = realFileName.split("?");
			strArray5 = realFileName.split("%");
			
		  
			//파일이름에 [.] 이 있으면 안된다.(확장자 제외)
			if(strArray.length > 2){
			  alert("파일이름중 '.' 이 있으면 삭제하여 주십시요 ");
			  return;
			}
			
			if(strArray.length < 1){
			  alert("확장자명은 반드시 있어야 합니다.  ");
			  return;
			}
			//파일이름에 [|] 이 있으면 안된다.
			if(strArray2.length > 1){
			  alert("파일이름중 '|' 이 있으면 모두 삭제하여 주십시요 ");
			  return;
			}
			//파일이름에 [_] 이 있으면 안된다.
			if(strArray3.length > 1){
			  alert("파일이름중 '_' 이 있으면 모두 삭제하여 주십시요 ");
			  return;
			}
			//파일이름에 [?] 이 있으면 안된다.
			if(strArray4.length > 1){
			  alert("파일이름중 '?' 이 있으면 모두 삭제하여 주십시요 ");
			  return;
			}
			//파일이름에 [%] 이 있으면 안된다.
			if(strArray5.length > 1){
			  alert("파일이름중 '%' 이 있으면 모두 삭제하여 주십시요 ");
			  return;
			}
			
			
			f.target="tempUpload";	//업로드 폼의 타겟은 iFrame !
			f.realFileName.value=realFileName;
			f.mode.value="insert";
			 

			f.action = "../../Sales/my/my710_upload.jsp";
			f.submit();
		}   	
    </script>
    
    
    
    <!--Tab 화면 Display  -->
    <script language=JavaScript for=mxTab event=OnSelChanged(index)>

    	v_job="S";
    	
  		var v_project = document.getElementById("v_project").value;    	

		//tree 조회
		if(index == '1'){
			
				document.getElementById("mxTab_Grid").style.display = "";
				document.getElementById("mxTab_Grid1").style.display = "none";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";

			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project							//project 코드			
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
				          "JSP(O:DS_TAB1=ds_tab1)", 							
				          v_param);

			    tr_post(tr1);	

		//매출원가 조회
        }else if(index == '2'){
        	
				document.getElementById("mxTab_Grid").style.display = "none";	        	
				document.getElementById("mxTab_Grid1").style.display = "";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";

			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project							//project 코드				
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
				          "JSP(O:DS_TAB2=ds_tab2)", 						
				          v_param);

			   // tr_post(tr1);	


				
		//수행경비 조회				
        }else if(index == '3'){

			document.getElementById("mxTab_Grid").style.display = "none";	        	
			document.getElementById("mxTab_Grid1").style.display = "none";
			document.getElementById("mxTab_Grid2").style.display = "";
			document.getElementById("mxTab_Grid3").style.display = "none";

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project							//project 코드					
										;
		    
		    ln_TRSetting(tr1, 
			          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
			          "JSP(O:DS_TAB3=ds_tab3)",  						
			          v_param);

		    //alert(v_param);
		    
		    tr_post(tr1);	

			
		    
		    
			ln_TRSetting(tr2, 
						"<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
						"JSP(O:DS_TAB32=ds_tab32)",  						
						v_param);
			
			//alert(v_param);
			
			tr_post(tr2);	
		    
		    
			
		    
		//손익분석 조회			
        }else if(index == '4'){
        	
			document.getElementById("mxTab_Grid").style.display = "none";	        	
			document.getElementById("mxTab_Grid1").style.display = "none";
			document.getElementById("mxTab_Grid2").style.display = "none";
			document.getElementById("mxTab_Grid3").style.display = "";

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project							//project
										;
		    
		    ln_TRSetting(tr1, 
			          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
			          "JSP(O:DS_TAB4=ds_tab4)", 						
			          v_param);

		    tr_post(tr1);	

        }
		
		
</script>
    
    
    
    
    
<script language="javascript" for="tr3" event="OnSuccess()">


	if(v_job=="A"){
		
		alert("성공적으로 저장되었습니다.");
		
	    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						+ ",v_project="    + v_project							//project 코드			
						;

		ln_TRSetting(tr1, 
						"<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
						"JSP(O:DS_TAB3=ds_tab3)", 							
						v_param);
		
		tr_post(tr1);	
		
		
	}

</script>
    

    
<%//수행인원 %>	
<script language=JavaScript for=gr_suOne event=OnPopup(row,colid,data)>

		if(colid=="ENO_NM") {

			fnEmpNoPopup('<%=dirPath%>', row);
		}
		
</script>	 
    
    
</head>



<%
/*=============================================================================
			DataSet Components(DS) 선언
			
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>

<object id=ds_tab1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_tab2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_tab3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_tab32 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  	value="false"/>
    <param name=SubSumExpr      value="total ,    1:ATKORNAM">    
</object>

<object id=ds_tab4 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>




			


<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

<object  id="tr3" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

<%=HDConstant.COMMENT_END%>






<title> 프로젝트 총괄표 </title>
</head>

<jsp:include page="/Common/sys/body_s11.jsp"  flush="true"/> 


<br>
		<div>
			<object id=mxTab classid=<%=HDConstant.MxTab_CLSID%> width="1000" height="20" style="position:relative; left:10px; top:5;" border=0> 
					<param name="BackColor"						value="#FEFEC0">
					<param name="DisableBackColor"				value="#BDBDBD">
					<param name="Format"						value='
								<T>divid="mxTab_Grid"	title=" 사업일반 "</T>
								<T>divid="mxTab_Grid1"	title=" 매출/원가 "</T>
								<T>divid="mxTab_Grid2"	title=" 수행경비 "</T>
								<T>divid="mxTab_Grid3"	title=" 손익분석 "</T>						
				'>
			</object>				
				
			<table border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td height="25px" width="0px">		  
						<input id="v_project"    type="text"   class="txtbox"  style= "position:relative;width:0px;height:20px;" readonly="readonly" >				
					</td>
				  </tr>
			</table>
			  

		</div>
		&nbsp;	

		
			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 1번째 TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->		
		
			<div id="mxTab_Grid" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:1;" >
				<h4><font color="#1266FF" face=HY중고딕>▣  기본정보</font></h4>

					<table border="1" cellpadding="0" cellspacing="0" width="900" >
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;프로젝트 코드</td>
							<td width="250px">
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="project_cd"  style= "position:relative;width:90%;;text-align:left;border: 1" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;프로젝트 명 </td>
							<td width="250px">
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="project_nm"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;손익센터 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="prop1"  style= "position:relative;width:90%;;text-align:left;border: 1" readonly="readonly"> 
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;고객구분 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="gubun"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;유형 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="prop2"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly"> 
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;발주처 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="order_comp"  style= "position:relative;width:90%;;text-align:left;border: 0;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;수주일  </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="win_dt"  style= "position:relative;width:90%;;text-align:center;border: 0" readonly="readonly"> 
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;계약기간 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="con_frdt"  style= "position:relative;width:40%;;text-align:center;border: 0" readonly="readonly">
								~ 
							   <input type="text" class="txtbox"  id="con_todt"  style= "position:relative;width:40%;;text-align: center;border: 0" readonly="readonly">  
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;영업대표 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="sales_pm"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;</td>							
							<td width="250px" >
								&nbsp;
							</td>							
						</tr>
					</table>
					&nbsp;

					<h4><font color="#1266FF" face=HY중고딕>▣  수행정보 </font></h4>					
					<table border="1" cellpadding="0" cellspacing="0" width="900" >
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;PM</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="pm"  style= "position:relative;width:90%;text-align:left;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;수행기간(전표전기)</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="exe_frdt"  style= "position:relative;width:40%;text-align: center;border: 0" readonly="readonly">
								~ 
							    <input type="text" class="txtbox"  id="exe_todt"  style= "position:relative;width:40%;text-align: center;border: 0" readonly="readonly">  
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;수주액</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="win_fee"  style= "position:relative;width:90%;text-align: center;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;원가</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="cost_fee"  style= "position:relative;width:90%;text-align: center;border: 0" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;공헌이익(률)</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="margin_amt"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
								&nbsp;
								<input type="text" class="txtbox"  id="margin_per"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;프로젝트이익(률)</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="benefit_amt"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
								&nbsp;
								<input type="text" class="txtbox"  id="benefit_per"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;사업내용</td>
							<td width="250px"  colspan="3">
								&nbsp;&nbsp;
								<textarea type="text" class="txtbox"  id="contents" cols="110"   readonly="readonly" style="padding-left: 5px;padding-bottom: 5px; border: 1">
								
								</textarea>
							</td>
						</tr>
					</table>
					&nbsp;
					<h4><font color="#1266FF" face=HY중고딕>▣  첨부파일 </font></h4>						

					<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="left" width="900">
	

										<!-- 파일 첨부용 폼-->
										<form name="fileForm" 	method="post" encType="multipart/form-data">
										<input type="hidden" 	name="realFileName">
										<input type="hidden" 	name="virtualFileName">
										<input type="hidden" 	name="mode"> 
										
										<tr>
											<td  width="100px" 	bgcolor='#FFFOFO' align=center>첨부파일</td>
											<td  width="600px"	bgcolor='#FFFOFO'><input type="text" name="file1" id="file1" style="width:600px;height:25px;" value="첨부파일은최대10M까지가능합니다." readonly  class=textbox> </td>
											<td  width="200px" 	bgcolor='#FFFOFO' style="padding-left:8px">
		                                      <div style="position:relative;left:0px;top:0px;height:0;width:20;background-image:url(http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;">
		                                      <input type='file' name='file_nm' id='file_nm' onChange="this.form.file1.value=this.value" style="width:40;height:20;filter:alpha(opacity=0);"></div>
										   </td>
										</tr>
										
										<tr>
											<td width="100px" 	bgcolor='#FFFOFO' border=0 valign=middle>  </td>
											<td width="600px"	bgcolor='#FFFOFO' style="padding-left:6px">
												<select multiple name="fileList" id="fileList" style="width:600px;height:70px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
			                                         <%=fullFilename%>
												</select>
											  </td>
											  <td style="padding-left:8px" valign=middle bgcolor='#FFFOFO'>
												<a href="javascript:fnUpload()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_upload.gif" border=0></a><br>
												<a href="javascript:fileDelete()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_del.gif" border=0></a>
											  </td>
										</tr>
										</form>
										<!-- 파일 삭제용 폼-->
										<FORM METHOD=POST NAME="file_del">
										<input type="hidden" name="realFileName">
										<input type="hidden" name="virtualFileName">
										<input type="hidden" name="saveDir">
										<input type="hidden" name="mode">
										</FORM> 
										<!-- 파일 임시 업로드용 iFrame -->
										<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>	


								</table>
			</div>
			
			
			
			
			
			
			
			
			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 2번째 TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->
			
			
			<div id="mxTab_Grid1" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:3;" >

				<h4><font color="#1266FF" face=HY중고딕>▣  수주계약내용 </font></h4>					
				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;발주처</td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="order_comp"   style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;계약금액 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="con_amt"  style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;대금결제조건</td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="cd_payment" style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;</td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="cd_appraval"  style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly"> 
							</td>
						</tr>
				</table>
				&nbsp;<br><br><br><br>
				
				<h4><font color="#1266FF" face=HY중고딕>▣  매출계획 </font></h4>						

				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;매출처구분</td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="sales_comp"   style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;매출차수 </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="no_sales"  style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly"> 차 
							</td>
						</tr>
				</table>
				
				<br><br>
				
				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr>
							<td>
								<object id="gr_sales" classid=<%=HDConstant.CT_GRID_CLSID%> width='900' height='150' border='0'>
				                    <param name="DataID"            	value="ds_default">
				                    <param name="ColSizing"         	value="true">
				                    <param name="Editable"          	value="true">
				                    <param name="ComboDataID"      		value="ds_gc_ccstat">
				                    <param name="SuppressOption"    	value="1">
				                    <param name="BorderStyle"       	value="0">
				                    <param name=ColSelect    			value="True">
				                    <param name="Format"            	value="
				                         <C> name='차수' 					ID='no_sales'   	width=50 		align=right	 		edit=none </C>
				                         <C> name='매출처'    				ID='sales_comp'    	width=180 		align=CENTER	  	edit=none </C>
				                         <C> name='매출금액'   				ID='sales_amt'   	width=150 		align=CENTER	 	edit=none </C>
				                         <C> name='환종' 					ID='current'    	width=80 		align=CENTER		edit=none </C>
				                         <C> name='세금계산서 발행예정일' 	ID='attx_dt'    	width=150 		align=CENTER	 	edit=none </C>
				                         <C> name='비고' 					ID='remark'    		width=250 		align=CENTER	 	edit=none </C>
				                 ">                             
	              			  </object>   
							</td>
						</tr>
				</table>
				<br><br><br><br>
				<br><br><br><br>
				<br><br>
				
				<h4><font color="#1266FF" face=HY중고딕>▣  원가계획 </font></h4>		
				
				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
					<tr>
						<td>
							<object id="gr_ksitem" classid=<%=HDConstant.CT_GRID_CLSID%> width='900px' height='150' border='0'>
			                    <param name="DataID"            	value="ds_defaultl">
			                    <param name="ColSizing"         	value="true">
			                    <param name="Editable"          	value="true">
			                    <param name="ComboDataID"      		value="ds_gc_ccstat">
			                    <param name="SuppressOption"    	value="1">
			                    <param name="BorderStyle"       	value="0">
			                    <param name=ColSelect    			value="True">
			                    <param name="Format"            	value="
			                         <C> name='품목명' 			ID='DS_KSITEM'   		width=120 		align=right	 		edit=none </C>
			                         <C> name='품목코드'    	ID='CD_ITEM'    		width=80 		align=CENTER	  	edit=none </C>
			                         <C> name='수량'   			ID='SALES_QN_ITEM'   	width=70 		align=CENTER	 	edit=none </C>
			                         <C> name='매출단가' 		ID='SALES_UP_ITEM'    	width=100 		align=CENTER		edit=none </C>
			                         <C> name='매출금액' 		ID='SALES_UP_ITEM'    	width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='매출처' 			ID='ORDER_NM'    		width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='매입단가' 		ID='PUR_UP_ITEM'    	width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='매입금액' 		ID='PUR_AM_ITEM'    	width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='환종' 			ID='CURRENT'    		width=70 		align=CENTER	 	edit=none show=false</C>
			                         <C> name='추천업체' 		ID='VENDOR_NM'    		width=80 		align=CENTER	 	edit=none </C>
			                         <C> name='프로젝트' 		ID='PROJECT_NM'    		width=80 		align=CENTER	 	edit=none </C>                         
			                 ">                             
              			  </object>   
						</td>
					</tr>
				</table>
			</div>
			
			
			
			
			
			
			
			
			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 3번째 TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->			
			
			<div id="mxTab_Grid2" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:0;" >
			
				<h4><font color="#1266FF" face=HY중고딕>▣  수행인원내역 </font></h4>				

	                <table border='0' cellpadding='0' cellspacing='0' width='900px'>
	                    <tr>
				     		<td align=right>
			   					<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:pointer" onClick="fnAddRow_person()">
			   					<img src="<%=dirPath%>/Sales/images/minus.gif"		style="cursor:pointer" onClick="fnDeleteRow_person()">     
			   					&nbsp;&nbsp;
			   					<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply_person()">  			   					
	                        </td>								
	                    </tr>
	                </table>
   					
				 	<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr>
							<td>
                            	<%=HDConstant.COMMENT_START%>							
								<object id="gr_suOne" classid=<%=HDConstant.MxGrid_CLSID_S%> width='900px' height='150px' border='0'>
				                    <param name="DataID"            	value="ds_tab3">
				                    <param name="ColSizing"         	value="true">
				                    <param name="Editable"          	value="true">
				                    <param name="BorderStyle"       	value="0">
				                    <param name="Format"            	value="
									 	 <C> name='No'				ID='{CurRow}'	width=50 		align=CENTER 		</C>				                    
				                         <C> name='NO'   			ID='SEQ'   		width=50 		align=CENTER	 	show=false/C>
				                         <C> name='프로젝트'   		ID='COST_CD'   	width=100 		align=CENTER	 	show=false</C>
				                         <C> name='사번'   			ID='ENO_NO'   	width=100 		align=CENTER	 	edit=none</C>	                    
				                         <C> name='성명'   			ID='ENO_NM'   	width=100 		align=CENTER	 	EditStyle=popup</C>
				                         <C> name='직위코드' 		ID='JOB_CD'    	width=100 		align=CENTER		show=false</C>
				                         <C> name='직위' 			ID='JOB_NM'    	width=100 		align=CENTER		edit=none</C>
				                         <C> name='투입시작일자' 	ID='FR_DT'    	width=150 		align=CENTER	 	mask='XXXX-XX-XX'</C>
				                         <C> name='투입종료일자' 	ID='TO_DT'    	width=150 		align=CENTER	 	mask='XXXX-XX-XX'</C>
				                         <C> name='투입일수' 		ID='WK_DAY'    	width=100 		align=CENTER	 	edit=none</C>
				                         <C> name='비고' 			ID='REMARLC'    width=100 		align=CENTER	 	</C>
				                 	">                             
	              			  	</object>   
                            	<%=HDConstant.COMMENT_END%>	              			  
							</td>
						</tr>
					</table>
					
				<br><br><br><br>
				<br><br><br><br>				
				<br><br><br>

				<h4><font color="#1266FF" face=HY중고딕>▣  수행경비내역 </font></h4>		
				
					<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr>
							<td>
								<object id="gr_suTwo" classid=<%=HDConstant.MxGrid_CLSID_S%> width='900px' height='300px' border='0'>
				                    <param name="DataID"            	value="ds_tab32">
				                    <param name="ColSizing"         	value="true">
				                    <param name="Editable"          	value="false">
                                	<param name="SuppressOption"    	value="1">				                    
				                    <param name="BorderStyle"       	value="0">
				                    <param name=ColSelect    			value="True">
				                    <param name="Format"            	value="
									 	 <C> name='No'				ID='{CurRow}'		width=40 		align=CENTER 		</C>			                    
				                         <C> name='계정코드'    	ID='ATCODE'    		width=80 		align=CENTER	  	edit=none show=false</C>
				                         <C> name='계정과목'   		ID='ATKORNAM'   	width=200 		align=CENTER	 	edit=none suppress=1</C>
				                         <C> name='금액' 			ID='DETOT'    		width=150 		align=CENTER	 	edit=none DECAO=0 sumtext=@sum</C>
				                         <C> name='거래처명' 		ID='VEND_NM'    	width=220 		align=CENTER	 	edit=none</C>				                         
				                         <C> name='적요' 			ID='REMARK'    		width=250 		align=CENTER	 	edit=none</C>		                         

				                 ">                             
	              			  </object>   
							</td>
						</tr>
					</table>
			</div>
			
			
			
			
			
			
			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 4번째 TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->			
			
			<div id="mxTab_Grid3" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:3;" >
			
				<h4><font color="#1266FF" face=HY중고딕>▣  손익 분석 </font></h4>		
							
				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr >
							<td width="560px" height="30px" colspan="3" rowspan="2" align="center" style="background-color: #eeeeee"><b>구분</b></td>
							<td width="220px" height="30px" colspan="2" style="background-color: #eeeeee">&nbsp;</td>
							<td width="210px" height="30px" rowspan="2" align="center" style="background-color: #eeeeee"><b>비고</b></td>
						</tr>
						<tr >
							<td width="20%"  height="30px" align="center" style="padding-top: 3px;background-color: #eeeeee" ><b>금액</b></td>
							<td width="20%"  height="30px" align="center" style="padding-top: 3px;background-color: #eeeeee"><b>매출대비</b></td>
						</tr>
						<tr >
							<td height="30px" colspan="3" style="padding-top: 3px;background-color: #eeeeee;"  >&nbsp;1. 매출액 (A)</td>
							<td height="30px" colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SALES_TOT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">							
							</td>
							<td height="30px" style="padding-top: 3px;">&nbsp;</td>
							<td height="30px" style="padding-top: 3px;">&nbsp;</td>
						</tr>
						<tr >
							<td width="10%"  height="30px"  rowspan="2" style="background-color: #eeeeee;" >&nbsp;</td>
							<td height="30px"  colspan="2"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;용역매출</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SALES_PERSON"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">							
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SALES_PERSON_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%													
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;
							</td>
						</tr>
						<tr >
							<td height="30px"  colspan="2"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;기타매출 (재료비, 경비, 외주비)</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SALES_ETC"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">							
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;" id="sales_mer_per">
								<input type="text" class="txtbox"  id="SALES_ETC_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%													
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;
							</td>
						</tr>
						<tr >
							<td height="30px"  colspan="3"  style="padding-top: 3px; background-color: #eeeeee;">&nbsp;2. 매출원가 (B)</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="COST_OUT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="COST_OUT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>
						
						<tr >
							<td height="30px"  colspan="3"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;3. 매출총이익 (A-B)</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="MARGIN"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">							
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="MARGIN_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%							
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;
							</td>
						</tr>

						<tr >
							<td height="30px"  colspan="3"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;4. 판매관리비 (C)</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="MANAGE_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="MANAGE_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>
						<tr >
							<td width="10%" height="30px"  rowspan="4" colspan="1" style="background-color: #eeeeee;">&nbsp;</td>						
							<td width="10%" height="30px"  rowspan="3" colspan="1" style="background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;직접비</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;사업직접비</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SAUP_DIRECT_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SAUP_DIRECT_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%															
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>
						<tr >
							<td height="30px"  colspan="1"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;본부공통비</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="HEAD_COMMON_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="HEAD_COMMON_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>
						
						<tr >
							<td height="30px"  colspan="1"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;팀공통비</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="TEAM_COMMON_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="TEAM_COMMON_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%															
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>						
						
						<tr >
							<td height="30px"  colspan="2"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;간접비</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="INDIRECT_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="INDIRECT_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>	
						
						<tr >
							<td height="30px"  colspan="3"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;5. 영업이익 (A-B-C)</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="OPERATE_PROFIT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="OPERATE_PROFIT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>

				</table>
			</div>
			

<%
/*=============================================================================
			Bind 선언 - tab1
=============================================================================*/
%>	

<%=HDConstant.COMMENT_START%>
<object  id=bn1 classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<param name=DataID    value=ds_tab1>
	<param name=BindInfo  value='  


	<C>Col=cost_cd			Ctrl=project_cd			Param=value</C>	
	<C>Col=plj_nm			Ctrl=project_nm			Param=value</C>	
	
	<C>Col=PROP1_NM			Ctrl=prop1				Param=value</C>	
	<C>Col=PROP2_NM			Ctrl=prop2				Param=value</C>	
	
	<C>Col=CONTENTS			Ctrl=contents			Param=value<</C>	
	
	<C>Col=PM_NM			Ctrl=sales_pm			Param=value</C>		
	<C>Col=PM_NM			Ctrl=pm					Param=value</C>		
	<C>Col=CTRT_BGNDATE		Ctrl=exe_frdt			Param=value</C>		
	<C>Col=CTRT_ENDDATE		Ctrl=exe_todt			Param=value</C>
			
	<C>Col=WIN_FEE			Ctrl=win_fee			Param=value</C>				
	<C>Col=COST_FEE			Ctrl=cost_fee			Param=value</C>	

	'>
</object>
<%=HDConstant.COMMENT_END%>  




<%
/*=============================================================================
			Bind 선언 - tab4
=============================================================================*/
%>	

<%=HDConstant.COMMENT_START%>
<object  id=bn4 classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<param name=DataID    		value=ds_tab4>
	<param name=BindInfo  		value='  


	<C>Col=SALES_TOT				Ctrl=SALES_TOT					Param=value</C>	
	<C>Col=SALES_PERSON				Ctrl=SALES_PERSON				Param=value</C>	
	<C>Col=SALES_ETC				Ctrl=SALES_ETC					Param=value</C>	
	
	<C>Col=SALES_PERSON_PERCENT		Ctrl=SALES_PERSON_PERCENT		Param=value</C>	
	<C>Col=SALES_ETC_PERCENT		Ctrl=SALES_ETC_PERCENT			Param=value</C>	
	
	<C>Col=COST_OUT					Ctrl=COST_OUT					Param=value</C>	
	<C>Col=COST_OUT_PERCENT			Ctrl=COST_OUT_PERCENT			Param=value</C>		
	
	<C>Col=MARGIN					Ctrl=MARGIN						Param=value</C>	
	<C>Col=MARGIN_PERCENT			Ctrl=MARGIN_PERCENT				Param=value</C>	

	<C>Col=MANAGE_AMT				Ctrl=MANAGE_AMT					Param=value</C>	
	<C>Col=MANAGE_AMT_PERCENT		Ctrl=MANAGE_AMT_PERCENT			Param=value</C>	
	
	<C>Col=SAUP_DIRECT_AMT			Ctrl=SAUP_DIRECT_AMT			Param=value</C>	
	<C>Col=SAUP_DIRECT_AMT_PERCENT	Ctrl=SAUP_DIRECT_AMT_PERCENT	Param=value</C>	
	
	<C>Col=HEAD_COMMON_AMT			Ctrl=HEAD_COMMON_AMT			Param=value</C>	
	<C>Col=HEAD_COMMON_AMT_PERCENT	Ctrl=HEAD_COMMON_AMT_PERCENT	Param=value</C>	
	
	<C>Col=TEAM_COMMON_AMT			Ctrl=TEAM_COMMON_AMT			Param=value</C>		
	<C>Col=TEAM_COMMON_AMT_PERCENT	Ctrl=TEAM_COMMON_AMT_PERCENT	Param=value</C>	
	
	<C>Col=INDIRECT_AMT				Ctrl=INDIRECT_AMT				Param=value</C>	
	<C>Col=INDIRECT_AMT_PERCENT		Ctrl=INDIRECT_AMT_PERCENT		Param=value</C>	
	
	<C>Col=OPERATE_PROFIT			Ctrl=OPERATE_PROFIT				Param=value</C>	
	<C>Col=OPERATE_PROFIT_PERCENT	Ctrl=OPERATE_PROFIT_PERCENT		Param=value</C>	
	'>
</object>
<%=HDConstant.COMMENT_END%>  


</body>
</html>

