<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <script type="text/javascript">
    	


        <%// fnOnLoad  %>
	    function fnOnLoad(){

			cfStyleGrid(getObjectFirst("gr_suOne"), "comn");

	        var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
	        
	    	strParam=window.dialogArguments;
	        
			document.getElementById("v_bid_cd").value = strParam[0];				//v_bid
			document.getElementById("v_bid_nm").value = strParam[1];				//v_bid
			document.getElementById("v_order_amt").value = strParam[2];				//v_bid
			document.getElementById("v_order_nm").value = strParam[3];				//v_bid
		
	        var v_bid_cd = strParam[0];   
	        var v_bid_nm = strParam[1];   
	        var v_order_amt = strParam[2]; 
	        var v_order_nm = strParam[3];
	        
	        //alert(bid_cd);
	        //alert(bid_nm);
	        //alert(order_amt);        

			fnSelect();
			
	    }
	    
    
	    <%//���� ��ȸ  %>
	    function fnSelect() {

			    v_job="S";

				//�⺻ ���� ��ȸ
 				var v_bid_cd = document.getElementById("v_bid_cd").value;

			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_bid_cd="    + v_bid_cd							//v_bid_cd �ڵ�			
											;

				//���� �ο� ���� ��ȸ
				ln_TRSetting(tr1, 
						"<%=dirPath%><%=HDConstant.PATH_BID%>Bid018",
						"JSP(O:DS_TAB1=ds_tab1)",  						
						v_param);
			
				//alert(v_param);
				
				tr_post(tr1);	
			    
		        
	    }    
   

	    
	    <%//�����ο� ���߰�%>
	    function fnAddRow_person(){

	    	ds_tab1.addrow();

	    	ds_tab1.NameValue(ds_tab1.rowposition,"SEQ") = ds_tab1.countrow;
	    	ds_tab1.NameValue(ds_tab1.rowposition,"BID_CD") = document.getElementById("v_bid_cd").value;
	    	
	    	alert("���� ���� �Է� ��\n\n���� ��ư�� �����ñ� �ٶ��ϴ�.");
	    
	    }  
	    
	    
	    
	    <%//�����ο� �����%>
	    function fnDeleteRow_person(){
	    	
	        if(confirm("������Ͻø� �ٷ� �����˴ϴ�.\n\n�����Ͻðڽ��ϱ�?")==false){
	        	
	            return;
			}	    	
	        
	    	ds_tab1.DeleteRow(ds_tab1.RowPosition);

			var v_bid_cd = document.getElementById("v_bid_cd").value;
		    
			var param   = "v_bid_cd"	+ v_bid_cd				//project code     
						;
			
			
			ln_TRSetting(tr1, 
			            "<%=dirPath%><%=HDConstant.PATH_BID%>Bid018",
			            "JSP(I:DS_TAB1=ds_tab1)",
			            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
			            param
			        	);
			
			prompt(this, ds_tab1.text);
			
			tr_post(tr1);
			
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
	    	   	
	    		ds_tab1.namevalue(row, "ENO_NO") = arrParam[0]; 
	    		ds_tab1.namevalue(row, "ENO_NM") = arrParam[1];
	    		ds_tab1.namevalue(row, "JOB_NM") = arrParam[3];	 	    		
	    		ds_tab1.namevalue(row, "JOB_CD") = arrParam[4];	    		


	        }    
	    	
	    }	    
	    
	    <%//�����ο� ����%>
	    function fnApply_person(){

	    	v_job="A";
	    	
	    	
			for(i=1; i<=ds_tab1.countrow; i++){
				
				ENO_NO = ds_tab1.NameValue(i,"ENO_NO");
				FR_DT = ds_tab1.NameValue(i,"FR_DT");
				TO_DT = ds_tab1.NameValue(i,"TO_DT");
				
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
			
	    	
			var v_bid_cd = document.getElementById("v_bid_cd").value;

			var param   = "v_bid_cd"	+ v_bid_cd				//v_bid_cd code     
						;
			
			
			ln_TRSetting(tr1, 
			            "<%=dirPath%><%=HDConstant.PATH_BID%>Bid018",
			            "JSP(I:DS_TAB1=ds_tab1)",
			            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
			            param
			        	);
			
			//prompt(this, ds_tab1.text);
			
			tr_post(tr1);
			
	    }  

    </script>
    
    
    
    
    
    <!--Tab ȭ�� Display  -->
    <script language=JavaScript for=mxTab event=OnSelChanged(index)>

    	v_job="S";
    	
  		var v_bid_cd = document.getElementById("v_bid_cd").value;    	

		//�����ο� ��ȸ
		if(index == '1'){
			
				document.getElementById("mxTab_Grid").style.display = "";
				document.getElementById("mxTab_Grid2").style.display = "none";


			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_bid_cd="    + v_bid_cd							//v_bid_cd �ڵ�			
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_BID%>Bid018",
				          "JSP(O:DS_TAB1=ds_tab1)", 							
				          v_param);

			    tr_post(tr1);	


		//���ͺм� ��ȸ	
        }else if(index == '2'){
        	
				document.getElementById("mxTab_Grid").style.display = "none";	        	
				document.getElementById("mxTab_Grid2").style.display = "";


			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_bid_cd="    + v_bid_cd							//v_bid_cd �ڵ�					
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_BID%>Bid018",
				          "JSP(O:DS_TAB2=ds_tab2)", 						
				          v_param);

			    //alert(v_param);
			    
			    tr_post(tr1);	

        }

</script>
    
    

<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"){
		
		v_job = "S";
		
		alert("���������� ����Ǿ����ϴ�.");
		
	    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								+ ",v_bid_cd="    + v_bid_cd							//v_bid_cd �ڵ�				
						;

		ln_TRSetting(tr1, 
						"<%=dirPath%><%=HDConstant.PATH_BID%>Bid018",
						"JSP(O:DS_TAB1=ds_tab1)", 							
						v_param);
		
		tr_post(tr1);	
		
		fnSelect();
		
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


<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

<%=HDConstant.COMMENT_END%>


<title> �м�ǥ </title>
</head>

<jsp:include page="/Common/sys/body_s11.jsp"  flush="true"/> 


<br>
		<div>
			<object id=mxTab classid=<%=HDConstant.MxTab_CLSID%> width="1000" height="20" style="position:relative; left:10px; top:5;" border=0> 
					<param name="BackColor"						value="#FEFEC0">
					<param name="DisableBackColor"				value="#BDBDBD">
					<param name="Format"						value='
								<T>divid="mxTab_Grid"	title=" ����Ϲ� "</T>
								<T>divid="mxTab_Grid2"	title=" ���ͺм� "</T>						
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
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;�����ڵ�</td>
							<td width="250px">
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="v_bid_cd"  style= "position:relative;width:90%;;text-align:left;border: 1" readonly="readonly">
							</td>
							<td height="25px" width="120px"  class="text l" >&nbsp;&nbsp;������ </td>
							<td width="250px">
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="v_bid_nm"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly"> 
							</td>
						</tr>

						<tr>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;������ </td>
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="v_order_amt"  style= "position:relative;width:90%;;text-align:left;border: 0" readonly="readonly">
							</td>
							<td height="25px" width="120px" class="text l" >&nbsp;&nbsp;����ó</td>							
							<td width="250px" >
								&nbsp;&nbsp;<input type="text" class="txtbox"  id="v_order_nm"  style= "position:relative;width:90%;;text-align:left;border: 0;border: 0" readonly="readonly"> 
							</td>						
						</tr>
					</table>
					&nbsp;

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
				                    <param name="DataID"            	value="ds_tab1">
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
			</div>
			

			<!--
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 2��° TAB
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			-->			
			
			<div id="mxTab_Grid2" style="position:relative; left:10; top:1; width:900; height:450; z-index:1;border:3;" >
			
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
							<td height="30px" colspan="3" style="padding-top: 3px;background-color: #eeeeee;"  >&nbsp;1. ���� ����� (A)</td>
							<td height="30px" colspan="1"  style="padding-top: 3px;">
								<input type="text" class="txtbox"  id="SALES_TOT"  style= "position:relative;width:90%;text-align:center;border: 1" readonly="readonly">							
							</td>
							<td height="30px" style="padding-top: 3px;">&nbsp;</td>
							<td height="30px" style="padding-top: 3px;">&nbsp;</td>
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
			Bind ���� - tab4
=============================================================================*/
%>	

<%=HDConstant.COMMENT_START%>
<object  id=bn1 classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<param name=DataID    		value=ds_tab2>
	<param name=BindInfo  		value='  


	<C>Col=SALES_TOT				Ctrl=SALES_TOT					Param=value</C>	

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

