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

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	//÷������ 
		String virtual_name	= "";
		String real_name		= "";
		String fullFilename	= "";
		String fileNameList = "";	//���� ����Ʈ ������ (������)
		Tbrd_attach_file_de_bean[] fileRecord = null;	//���� ÷�ο� ��~!
		
		 SmartRequest sr3 = new SmartRequest(request);
		 My710Manager manager3 = new My710Manager();
	     My710DTO dto = manager3.select(sr3);
		
		//���ϸ���Ʈ html �����
	    StringBuffer sb = new StringBuffer();
		String real_fileList = dto.getReal_file();	//���� �ҷ��ͼ� 
		String sys_fileList = dto.getSys_file();
		fileNameList = real_fileList;				// �ý����� ����Ʈ�� ����.

		String real_file[] = real_fileList.split(":");	//�迭�� ����
		String sys_file[] = sys_fileList.split(":");	//�迭�� ����
		
			for(int j=0; j<sys_file.length; j++){

				sb.append("<option value='"+sys_file[j]+ "'>" + real_file[j] +"</option>"); 
			};

		//÷�ζ��� ���� html�ڵ� �����                     
	 	fullFilename = sb.toString();   
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <script type="text/javascript">
    	
    	//fnOnLoad();


		var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
		
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
	    
    
	    <%//���� ��ȸ  %>
	    function fnSelect() {

			    v_job="S";


 				var v_project =  document.getElementById("v_project").value;


			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project							//project �ڵ�			
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
				          "JSP(O:DS_TAB1=ds_tab1)", 							
				          v_param);

			    tr_post(tr1);	
		        
	    }    
   
	    
	    
	    
	    
	    
	    <%//�����ο� ���߰�%>
	    function fnAddRow_person(){

	    	ds_tab3.addrow();

	    	ds_tab3.NameValue(ds_tab3.rowposition,"SEQ") = ds_tab3.countrow;
	    	ds_tab3.NameValue(ds_tab3.rowposition,"COST_CD") = document.getElementById("v_project").value;
	    	
	    	alert("���� ���� �Է� ��\n\n���� ��ư�� �����ñ� �ٶ��ϴ�.");
	    
	    }  
	    
	    
	    
	    <%//�����ο� �����%>
	    function fnDeleteRow_person(){
	    	
	        if(confirm("������Ͻø� �ٷ� �����˴ϴ�.\n\n�����Ͻðڽ��ϱ�?")==false){
	        	
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
	    
   
	    <%//���� �����ο� �˻�%>
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
	    
	    <%//�����ο� ����%>
	    function fnApply_person(){

	    	v_job="A";
	    	
	    	
			for(i=1; i<=ds_tab3.countrow; i++){
				
				ENO_NO = ds_tab3.NameValue(i,"ENO_NO");
				FR_DT = ds_tab3.NameValue(i,"FR_DT");
				TO_DT = ds_tab3.NameValue(i,"TO_DT");
				
				if(ENO_NO == ""){
					alert("�����ο��� �Է��� �ֽñ� �ٶ��ϴ�." );
					return false;
				}else if(FR_DT == ""){
					alert("���Խ������ڸ� �Է��� �ֽñ� �ٶ��ϴ�." );
					return false;
				}else if(TO_DT == ""){
					alert("�����������ڸ� �Է��� �ֽñ� �ٶ��ϴ�." );
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
			
		    
			if(f.file1.value.length == 0 || f.file1.value == "÷���������ִ�10M���������մϴ�.")
			{
				alert('���ε��� ������ �����Ͽ� �ֽʽÿ�');
				
				return;
			}
		
			
			var realFileName = f.file1.value;
			
			var idx = realFileName.lastIndexOf("\\");
			
			realFileName = realFileName.substring(idx+1);
			
			//alert(realFileName);
			
			if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
				
				alert("���۱� ������ ������ �ִ� mp3, wma, asf ������ �������� ÷�δ� ���� �ʽ��ϴ�.");
				
				return;
				
			}
			
			strArray = realFileName.split("."); 
			strArray2 = realFileName.split("|"); 
			strArray3 = realFileName.split("_");
			strArray4 = realFileName.split("?");
			strArray5 = realFileName.split("%");
			
		  
			//�����̸��� [.] �� ������ �ȵȴ�.(Ȯ���� ����)
			if(strArray.length > 2){
			  alert("�����̸��� '.' �� ������ �����Ͽ� �ֽʽÿ� ");
			  return;
			}
			
			if(strArray.length < 1){
			  alert("Ȯ���ڸ��� �ݵ�� �־�� �մϴ�.  ");
			  return;
			}
			//�����̸��� [|] �� ������ �ȵȴ�.
			if(strArray2.length > 1){
			  alert("�����̸��� '|' �� ������ ��� �����Ͽ� �ֽʽÿ� ");
			  return;
			}
			//�����̸��� [_] �� ������ �ȵȴ�.
			if(strArray3.length > 1){
			  alert("�����̸��� '_' �� ������ ��� �����Ͽ� �ֽʽÿ� ");
			  return;
			}
			//�����̸��� [?] �� ������ �ȵȴ�.
			if(strArray4.length > 1){
			  alert("�����̸��� '?' �� ������ ��� �����Ͽ� �ֽʽÿ� ");
			  return;
			}
			//�����̸��� [%] �� ������ �ȵȴ�.
			if(strArray5.length > 1){
			  alert("�����̸��� '%' �� ������ ��� �����Ͽ� �ֽʽÿ� ");
			  return;
			}
			
			
			f.target="tempUpload";	//���ε� ���� Ÿ���� iFrame !
			f.realFileName.value=realFileName;
			f.mode.value="insert";
			 

			f.action = "../../Sales/my/my710_upload.jsp";
			f.submit();
		}   	
    </script>
    
    
    
    <!--Tab ȭ�� Display  -->
    <script language=JavaScript for=mxTab event=OnSelChanged(index)>

    	v_job="S";
    	
  		var v_project = document.getElementById("v_project").value;    	

		//tree ��ȸ
		if(index == '1'){
			
				document.getElementById("mxTab_Grid").style.display = "";
				document.getElementById("mxTab_Grid1").style.display = "none";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";

			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project							//project �ڵ�			
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
				          "JSP(O:DS_TAB1=ds_tab1)", 							
				          v_param);

			    tr_post(tr1);	

		//������� ��ȸ
        }else if(index == '2'){
        	
				document.getElementById("mxTab_Grid").style.display = "none";	        	
				document.getElementById("mxTab_Grid1").style.display = "";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";

			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project							//project �ڵ�				
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
				          "JSP(O:DS_TAB2=ds_tab2)", 						
				          v_param);

			   // tr_post(tr1);	


				
		//������ ��ȸ				
        }else if(index == '3'){

			document.getElementById("mxTab_Grid").style.display = "none";	        	
			document.getElementById("mxTab_Grid1").style.display = "none";
			document.getElementById("mxTab_Grid2").style.display = "";
			document.getElementById("mxTab_Grid3").style.display = "none";

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project							//project �ڵ�					
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
		    
		    
			
		    
		//���ͺм� ��ȸ			
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
		
		alert("���������� ����Ǿ����ϴ�.");
		
	    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						+ ",v_project="    + v_project							//project �ڵ�			
						;

		ln_TRSetting(tr1, 
						"<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
						"JSP(O:DS_TAB3=ds_tab3)", 							
						v_param);
		
		tr_post(tr1);	
		
		
	}

</script>
    

    
<%//�����ο� %>	
<script language=JavaScript for=gr_suOne event=OnPopup(row,colid,data)>

		if(colid=="ENO_NM") {

			fnEmpNoPopup('<%=dirPath%>', row);
		}
		
</script>	 
    
    
</head>



<%
/*=============================================================================
			DataSet Components(DS) ����
			
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






<title> ������Ʈ �Ѱ�ǥ </title>
</head>

<jsp:include page="/Common/sys/body_s11.jsp"  flush="true"/> 


<br>
		<div>
			<object id=mxTab classid=<%=HDConstant.MxTab_CLSID%> width="1000" height="20" style="position:relative; left:10px; top:5;" border=0> 
					<param name="BackColor"						value="#FEFEC0">
					<param name="DisableBackColor"				value="#BDBDBD">
					<param name="Format"						value='
								<T>divid="mxTab_Grid"	title=" ����Ϲ� "</T>
								<T>divid="mxTab_Grid1"	title=" ����/���� "</T>
								<T>divid="mxTab_Grid2"	title=" ������ "</T>
								<T>divid="mxTab_Grid3"	title=" ���ͺм� "</T>						
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
			// 1��° TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->		
		
			<div id="mxTab_Grid" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:1;" >
				<h4><font color="#1266FF" face=HY�߰��>��  �⺻����</font></h4>

					<table border="1" cellpadding="0" cellspacing="0" width="900" >
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;������Ʈ �ڵ�</td>
							<td width="250px">
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="project_cd"  style= "position:relative;width:90%;;text-align:left;border: 1" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;������Ʈ �� </td>
							<td width="250px">
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="project_nm"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;���ͼ��� </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="prop1"  style= "position:relative;width:90%;;text-align:left;border: 1" readonly="readonly"> 
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;������ </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="gubun"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;���� </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="prop2"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly"> 
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;����ó </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="order_comp"  style= "position:relative;width:90%;;text-align:left;border: 0;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;������  </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="win_dt"  style= "position:relative;width:90%;;text-align:center;border: 0" readonly="readonly"> 
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;���Ⱓ </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="con_frdt"  style= "position:relative;width:40%;;text-align:center;border: 0" readonly="readonly">
								~ 
							   <input type="text" class="txtbox"  id="con_todt"  style= "position:relative;width:40%;;text-align: center;border: 0" readonly="readonly">  
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;������ǥ </td>
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

					<h4><font color="#1266FF" face=HY�߰��>��  �������� </font></h4>					
					<table border="1" cellpadding="0" cellspacing="0" width="900" >
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;PM</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="pm"  style= "position:relative;width:90%;text-align:left;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;����Ⱓ(��ǥ����)</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="exe_frdt"  style= "position:relative;width:40%;text-align: center;border: 0" readonly="readonly">
								~ 
							    <input type="text" class="txtbox"  id="exe_todt"  style= "position:relative;width:40%;text-align: center;border: 0" readonly="readonly">  
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;���־�</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="win_fee"  style= "position:relative;width:90%;text-align: center;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;����</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="cost_fee"  style= "position:relative;width:90%;text-align: center;border: 0" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;��������(��)</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="margin_amt"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
								&nbsp;
								<input type="text" class="txtbox"  id="margin_per"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;������Ʈ����(��)</td>
							<td width="250px" >
								&nbsp;&nbsp;
								<input type="text" class="txtbox"  id="benefit_amt"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
								&nbsp;
								<input type="text" class="txtbox"  id="benefit_per"  style= "position:relative;width:43%;text-align:center;border: 0" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;�������</td>
							<td width="250px"  colspan="3">
								&nbsp;&nbsp;
								<textarea type="text" class="txtbox"  id="contents" cols="110"   readonly="readonly" style="padding-left: 5px;padding-bottom: 5px; border: 1">
								
								</textarea>
							</td>
						</tr>
					</table>
					&nbsp;
					<h4><font color="#1266FF" face=HY�߰��>��  ÷������ </font></h4>						

					<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="left" width="900">
	

										<!-- ���� ÷�ο� ��-->
										<form name="fileForm" 	method="post" encType="multipart/form-data">
										<input type="hidden" 	name="realFileName">
										<input type="hidden" 	name="virtualFileName">
										<input type="hidden" 	name="mode"> 
										
										<tr>
											<td  width="100px" 	bgcolor='#FFFOFO' align=center>÷������</td>
											<td  width="600px"	bgcolor='#FFFOFO'><input type="text" name="file1" id="file1" style="width:600px;height:25px;" value="÷���������ִ�10M���������մϴ�." readonly  class=textbox> </td>
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
										<!-- ���� ������ ��-->
										<FORM METHOD=POST NAME="file_del">
										<input type="hidden" name="realFileName">
										<input type="hidden" name="virtualFileName">
										<input type="hidden" name="saveDir">
										<input type="hidden" name="mode">
										</FORM> 
										<!-- ���� �ӽ� ���ε�� iFrame -->
										<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>	


								</table>
			</div>
			
			
			
			
			
			
			
			
			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 2��° TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->
			
			
			<div id="mxTab_Grid1" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:3;" >

				<h4><font color="#1266FF" face=HY�߰��>��  ���ְ�೻�� </font></h4>					
				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;����ó</td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="order_comp"   style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;���ݾ� </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="con_amt"  style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly"> 
							</td>
						</tr>
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;��ݰ�������</td>
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
				
				<h4><font color="#1266FF" face=HY�߰��>��  �����ȹ </font></h4>						

				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;����ó����</td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="sales_comp"   style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;�������� </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="no_sales"  style= "position:relative;width:90%;;text-align: center;border: 0" readonly="readonly"> �� 
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
				                         <C> name='����' 					ID='no_sales'   	width=50 		align=right	 		edit=none </C>
				                         <C> name='����ó'    				ID='sales_comp'    	width=180 		align=CENTER	  	edit=none </C>
				                         <C> name='����ݾ�'   				ID='sales_amt'   	width=150 		align=CENTER	 	edit=none </C>
				                         <C> name='ȯ��' 					ID='current'    	width=80 		align=CENTER		edit=none </C>
				                         <C> name='���ݰ�꼭 ���࿹����' 	ID='attx_dt'    	width=150 		align=CENTER	 	edit=none </C>
				                         <C> name='���' 					ID='remark'    		width=250 		align=CENTER	 	edit=none </C>
				                 ">                             
	              			  </object>   
							</td>
						</tr>
				</table>
				<br><br><br><br>
				<br><br><br><br>
				<br><br>
				
				<h4><font color="#1266FF" face=HY�߰��>��  ������ȹ </font></h4>		
				
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
			                         <C> name='ǰ���' 			ID='DS_KSITEM'   		width=120 		align=right	 		edit=none </C>
			                         <C> name='ǰ���ڵ�'    	ID='CD_ITEM'    		width=80 		align=CENTER	  	edit=none </C>
			                         <C> name='����'   			ID='SALES_QN_ITEM'   	width=70 		align=CENTER	 	edit=none </C>
			                         <C> name='����ܰ�' 		ID='SALES_UP_ITEM'    	width=100 		align=CENTER		edit=none </C>
			                         <C> name='����ݾ�' 		ID='SALES_UP_ITEM'    	width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='����ó' 			ID='ORDER_NM'    		width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='���Դܰ�' 		ID='PUR_UP_ITEM'    	width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='���Աݾ�' 		ID='PUR_AM_ITEM'    	width=100 		align=CENTER	 	edit=none </C>
			                         <C> name='ȯ��' 			ID='CURRENT'    		width=70 		align=CENTER	 	edit=none show=false</C>
			                         <C> name='��õ��ü' 		ID='VENDOR_NM'    		width=80 		align=CENTER	 	edit=none </C>
			                         <C> name='������Ʈ' 		ID='PROJECT_NM'    		width=80 		align=CENTER	 	edit=none </C>                         
			                 ">                             
              			  </object>   
						</td>
					</tr>
				</table>
			</div>
			
			
			
			
			
			
			
			
			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 3��° TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->			
			
			<div id="mxTab_Grid2" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:0;" >
			
				<h4><font color="#1266FF" face=HY�߰��>��  �����ο����� </font></h4>				

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
				                         <C> name='������Ʈ'   		ID='COST_CD'   	width=100 		align=CENTER	 	show=false</C>
				                         <C> name='���'   			ID='ENO_NO'   	width=100 		align=CENTER	 	edit=none</C>	                    
				                         <C> name='����'   			ID='ENO_NM'   	width=100 		align=CENTER	 	EditStyle=popup</C>
				                         <C> name='�����ڵ�' 		ID='JOB_CD'    	width=100 		align=CENTER		show=false</C>
				                         <C> name='����' 			ID='JOB_NM'    	width=100 		align=CENTER		edit=none</C>
				                         <C> name='���Խ�������' 	ID='FR_DT'    	width=150 		align=CENTER	 	mask='XXXX-XX-XX'</C>
				                         <C> name='������������' 	ID='TO_DT'    	width=150 		align=CENTER	 	mask='XXXX-XX-XX'</C>
				                         <C> name='�����ϼ�' 		ID='WK_DAY'    	width=100 		align=CENTER	 	edit=none</C>
				                         <C> name='���' 			ID='REMARLC'    width=100 		align=CENTER	 	</C>
				                 	">                             
	              			  	</object>   
                            	<%=HDConstant.COMMENT_END%>	              			  
							</td>
						</tr>
					</table>
					
				<br><br><br><br>
				<br><br><br><br>				
				<br><br><br>

				<h4><font color="#1266FF" face=HY�߰��>��  �����񳻿� </font></h4>		
				
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
				                         <C> name='�����ڵ�'    	ID='ATCODE'    		width=80 		align=CENTER	  	edit=none show=false</C>
				                         <C> name='��������'   		ID='ATKORNAM'   	width=200 		align=CENTER	 	edit=none suppress=1</C>
				                         <C> name='�ݾ�' 			ID='DETOT'    		width=150 		align=CENTER	 	edit=none DECAO=0 sumtext=@sum</C>
				                         <C> name='�ŷ�ó��' 		ID='VEND_NM'    	width=220 		align=CENTER	 	edit=none</C>				                         
				                         <C> name='����' 			ID='REMARK'    		width=250 		align=CENTER	 	edit=none</C>		                         

				                 ">                             
	              			  </object>   
							</td>
						</tr>
					</table>
			</div>
			
			
			
			
			
			
			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 4��° TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->			
			
			<div id="mxTab_Grid3" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:3;" >
			
				<h4><font color="#1266FF" face=HY�߰��>��  ���� �м� </font></h4>		
							
				<table border="1" cellpadding="0" cellspacing="1" bgcolor="" align="left" width="900">
						<tr >
							<td width="560px" height="30px" colspan="3" rowspan="2" align="center" style="background-color: #eeeeee"><b>����</b></td>
							<td width="220px" height="30px" colspan="2" style="background-color: #eeeeee">&nbsp;</td>
							<td width="210px" height="30px" rowspan="2" align="center" style="background-color: #eeeeee"><b>���</b></td>
						</tr>
						<tr >
							<td width="20%"  height="30px" align="center" style="padding-top: 3px;background-color: #eeeeee" ><b>�ݾ�</b></td>
							<td width="20%"  height="30px" align="center" style="padding-top: 3px;background-color: #eeeeee"><b>������</b></td>
						</tr>
						<tr >
							<td height="30px" colspan="3" style="padding-top: 3px;background-color: #eeeeee;"  >&nbsp;1. ����� (A)</td>
							<td height="30px" colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SALES_TOT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">							
							</td>
							<td height="30px" style="padding-top: 3px;">&nbsp;</td>
							<td height="30px" style="padding-top: 3px;">&nbsp;</td>
						</tr>
						<tr >
							<td width="10%"  height="30px"  rowspan="2" style="background-color: #eeeeee;" >&nbsp;</td>
							<td height="30px"  colspan="2"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;�뿪����</td>
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
							<td height="30px"  colspan="2"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;��Ÿ���� (����, ���, ���ֺ�)</td>
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
							<td height="30px"  colspan="3"  style="padding-top: 3px; background-color: #eeeeee;">&nbsp;2. ������� (B)</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="COST_OUT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="COST_OUT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>
						
						<tr >
							<td height="30px"  colspan="3"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;3. ���������� (A-B)</td>
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
							<td height="30px"  colspan="3"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;4. �ǸŰ����� (C)</td>
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
							<td width="10%" height="30px"  rowspan="3" colspan="1" style="background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;���������</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SAUP_DIRECT_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SAUP_DIRECT_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%															
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>
						<tr >
							<td height="30px"  colspan="1"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;���ΰ����</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="HEAD_COMMON_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="HEAD_COMMON_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>
						
						<tr >
							<td height="30px"  colspan="1"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;�������</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="TEAM_COMMON_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="TEAM_COMMON_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%															
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>						
						
						<tr >
							<td height="30px"  colspan="2"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="INDIRECT_AMT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">								
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="INDIRECT_AMT_PERCENT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">%	
							</td>
							<td height="30px"  colspan="1"  style="padding-top: 3px;">&nbsp;</td>
						</tr>	
						
						<tr >
							<td height="30px"  colspan="3"  style="padding-top: 3px;background-color: #eeeeee;">&nbsp;5. �������� (A-B-C)</td>
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
			Bind ���� - tab1
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
			Bind ���� - tab4
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

