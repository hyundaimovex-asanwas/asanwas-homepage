<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
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
<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >


	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var menuWin;	//��â �����.

	var Tabvalue = 1;
	
	
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		cfStyleGrid(getObjectFirst("grd_default"), "comn");	//list detail

		fnInit();
		

	}
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
        var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
        
    	strParam=window.dialogArguments;

		document.getElementById("v_bid_cd").value = strParam[0];				//v_bid
		document.getElementById("v_bid_nm").value = strParam[1];				//v_bid
		document.getElementById("v_order_amt").value = strParam[2];				//v_bid
		
	
        var bid_cd = strParam[0];   
        var bid_nm = strParam[1];   
        var order_amt = strParam[2]; 
        
        fnSelect();

    }
	
    
    <%//���� ��ȸ %>
    function fnSelect() {

    	v_job="S";

    	var v_bid_cd = document.getElementById("v_bid_cd").value;
    	
    	/* protype = select , v_site_sid ,  */
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
									+ ",v_bid_cd=" + v_bid_cd				//�˻�����
									;

        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_BID%>Bid015",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            v_param);

        //alert(v_bid_cd);
        
        tr_post(tr1);

    }    
    





	<%//����=���ο�û %>
	function fnApply(){
		
		v_job = "A";
		
		if (ds_item_d.NameValue(ds_item_d.rowposition,"COST_YN") == 'Y') {


		}

		if (ds_item_d.IsUpdated) {

			  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bud021",
				                "JSP(I:DS_ITEM_D=ds_item_d)",
				                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				                );

			  tr_post(tr1);

			  
        }else{
        	
     		alert("������ Data�� �����ϴ�.");
		
        }
		
		
	 }




	    
	  	<%//EXCEL UPLOAD �ϱ�%>
	    function fnExcelUpload() {
	    	alert("����� �Ѿ� ������?");
			var project_cd = document.getElementById("v_project").value;			//Project Code 
			var project_nm = document.getElementById("v_project_nm").value;			//Project ��			
			var no_budget =  document.getElementById("v_no_budget").value;			//��������			   			
	    	alert("����� �Ѿ� ������?");
			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
	    	alert("����� �Ѿ� ������?");	

			arrParam[0] = project_cd;
			arrParam[1] = project_nm;
			arrParam[2] = no_budget;
			alert("����� �Ѿ� ������?"+arrParam[0] +arrParam[1] );
		
			strURL = "<%=dirPath%>/Pms/new/bud/bud025.jsp";
			
			strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);

	    }		    
	    
</script>

    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)  *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                            |
    | 2. �̸� : ds_item_m,    ds_item_d            |
    +----------------------------------------------->
    
	<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>
	

		
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : tr1                  				|
    +----------------------------------------------->
    
	<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
	    <param name="KeyName"    value="toinb_dataid4"/>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>



 <!-----------------------------+
 | Transaction Successful ó��      |
 +------------------------------>
 <script for=tr1 event="OnSuccess()">
 
	if(v_job=="A"){
		
		//alert("���������� ����Ǿ����ϴ�.");
		fnInit();
	}
	

    
 </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->


</head>

    <jsp:include page="/Common/sys/body_s11.jsp"/>



<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
	<table width="950" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
	    <tr>
	    
	    <td>&nbsp;&nbsp;
	    
				<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;top:0px;width:70;height:10"  >
					<param name="Text"		value="EXCEL">
				</OBJECT>&nbsp;&nbsp;		    
	    </td>
	    
	        <td height="35" class="paddingTop5" align="right"> 
	        	<!--  <img src="<%=dirPath%>/Sales/images/excel_apply.gif"			style="cursor:pointer" onclick="fnExcelUpload()"> -->
	        	&nbsp;&nbsp;&nbsp;&nbsp;	        
	        	<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">
	        	<img src="<%=dirPath%>/Sales/images/save.gif"					style="cursor:pointer" onclick="fnApply()">	
	        </td>
	    </tr>
	</table>
<!-- ��ư ���̺� �� -->
	
	


<br>

<!-- input ��  ���� --> 
	<table width="950" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
		
			<td align="center" class="text" width="80">����</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_bid_cd'   	  	id='v_bid_cd'  		style="width:80px;"    class='input01' readOnly="readonly">
			    <input type="text"  name='v_bid_nm'   		id='v_bidt_nm'  	style="width:200px;"   class='input01' readOnly="readonly">			    
			</td>		
	
			<td align="center" class="text" width="80">�����ݾ�</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_order_amt'   id='v_order_amt'  style="width:70px;" class='input01'  readOnly="readonly">
			</td>	
						
		</tr>
	</table>
<!-- input ��  �� --> 


<br>
<!-- ���� ��ȸ Grid ���̺� ����-->

	
	<table width="950" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:5px">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- ������ ȭ�� ����-->
				<table width="900" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- ���� ��ȸ �׸��� ���̺� ����-->
							<table width="950" height = "550" border="0" cellspacing="0" cellpadding="0">
							    <tr>
									<td class="paddingTop8">
							            <table border="0" cellspacing="0" cellpadding="0">
							                <tr align="left">
							                    <td> 
							                        <object id="grd_default" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:950px;height:550px;">
							                            <param name="DataID"						value="ds_default">
							                            <param name="EdiTABLE"						value="true">
							                            <param name="DragDropEnable"				value="true">
							                            <param name="SortView"						value="Left">
							                            <param name="VIEWSUMMARY"					value=0>
							                            <param name="Format"						value="
							                                <C> id='DS_KSITEM'				name='Content'		width=250			align=left</C>									                                
							                                <C> id='CD_COST'				name='CODE'			width=100			align=left</C>
							                                <C> id='NO_BUDGET'				name='����' 		align=center	 	show=false</C> 	
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C> 								                                
							                               <G> name='����' 
							                                <C> id='ORDER_QN'				name='����'			width=80			align=right decao = 0 </C> 
							                                <C> id='ORDER_UP'				name='�ܰ�'			width=80			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT'				name='�ݾ�'			width=100			align=right decao = 0 </C>
							                               </G>		
							                               
							                               <G> name='������' 							                                
							                                <C> id='PRO_ACT_QN'				name='����'			width=80			align=right decao = 0 </C>
							                                <C> id='PRO_ACT_UP'				name='�ܰ�'			width=80			align=right decao = 0 </C> 
							                                <C> id='PRO_ACT_AMT'			name='�ݾ�'			width=100			align=right decao = 0 </C> 
							                               </G>		

							                                <C> id='ITEM_CD'				name='ǰ��\\�ڵ�'	width=80			align=center show=false</C> 					                                
							                                <C> id='ITEM_NM'				name='ǰ��\\�ڵ�'	width=100			align=center EditStyle=Popup show=false</C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- ���� ��ȸ �׸��� ���̺� ��-->
	
						</td>
					</tr>
				</table>
				<!-- ������ ȭ�� ��-->
			</td>
		</tr>
	</table>

</form>
<!-- form �� -->




</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

