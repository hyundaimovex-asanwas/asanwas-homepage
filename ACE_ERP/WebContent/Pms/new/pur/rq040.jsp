<!-- /******************************************************************************
 * �ý��۸� 	 : �����Ƿڼ� - ���� list
 * ���α׷�ID 	 : PMS/RQ040
 * J  S  P	 	 : rq040.jsp
 * �� �� ��		 : 
 * �� �� ��		 : �赵��
 * �� �� ��		 : 2018-06-21
 * �������		 : �����Ƿڼ� - ���� list
 * [ �������� ][������] ����
 * [ 2018-06-21 ][�赵��] �ű԰���

 *****************************************************************************/ -->
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>



<%	// ContextPath ���� ����.

	String dirPath = request.getContextPath(); //HDASan
	SmartRequest sr = new SmartRequest(request);	

	//�α��� üũ : 2013-12-04 �ɵ��� ���� ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//������ �̵��� ����ID üũ(�̰� ������ ���� ���� ������?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//������ �̵��� ���Ǻ���("�α�") üũ
	String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ
	
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

		var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
		
		var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
		
		var menuWin;	//��â �����.
		
	
		function fnOnLoad(tree_idx){
			
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			
			cfStyleGrid(getObjectFirst("gr_default"), "comn");	//card usage list
	
			fnInit();
			
		}
		
		
		
	    <%//�ʱ��۾� %>
	    
	    function fnInit(){
	    	
		    v_job ="I";
		    
		    fnSelect();
		    
	    }
		    
	    
	    <%//���� ��ȸ %>
	    function fnSelect(){
	    	
	    	v_job="S";
	    	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
								+ ",v_project=" + v_project.value				//�˻�����
								;
	
	
	        ln_TRSetting(tr1, 
			            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq040",
			            "JSP(O:DS_DEFAULT=ds_default)", 
			            param);
		        
	        tr_post(tr1);
	        
	        
	    }
	    
	    
	
	
	
	    <%//���� %>
		function fnApply() {
	
				v_job = "A";
				
				var v_default_row   = ds_default.RowPosition;
				
		
			  	var v_cost_cd		=	ds_default.namevalue(ds_default.rowposition,"COST_CD"); 			//������Ʈ �ڵ�
			 	var v_no_ma_request	=	ds_default.namevalue(ds_default.rowposition,"NO_MA_REQUEST"); 		//�����Ƿڼ� ��ȣ
			 	var v_ds_ma_request	=	ds_default.namevalue(ds_default.rowposition,"DS_MA_REQUEST"); 		//contents
			 	var v_ty_buytype	=	ds_default.namevalue(ds_default.rowposition,"TY_BUYTYPE"); 			//���űٰ�
			 	var v_remark		=	ds_default.namevalue(ds_default.rowposition,"REMARK"); 				//���
			 	
		 	
			 	if(v_cost_cd==""||v_cost_cd==null){
			 		
			 		alert("Project�� �Է����ּ���.");
			 		return;
			 		
			 	}
			 	
			 	if(v_ds_ma_request==""||v_ds_ma_request==null){
			 		
			 		alert("Contents�� �Է����ּ���.");
			 		return;
			 		
			 	}
			 	
			 	if(v_ty_buytype=="����"||v_ty_buytype==null){
			 		
			 		alert("���űٰŸ� �������ּ���.");
			 		return;
			 		
			 	}
			 	
			 	if(v_remark==""||v_remark==null){
			 		
			 		alert("��� �Է����ּ���.");
			 		return;
			 		
			 	}
		 		
	
				var param   = "v_cost_cd"			+ ds_default.namevalue(ds_default.rowposition,"COST_CD")				//project code
					        + "v_no_ma_request"		+ ds_default.namevalue(ds_default.rowposition,"NO_MA_REQUEST") 			//�����Ƿڼ� ��ȣ
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
	
		
		
		
		     
		    <%//���߰�%>
		    function fnAddRow(){
	
		    	
		    	ds_default.addrow();
	
		    	ds_default.namevalue(ds_default.RowPosition, "NO_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>" + '0000';
	
	
		    	//���߰��� �Ƿ����� �ڵ� ���. (���� ��¥�� ���)
		    	ds_default.namevalue(ds_default.RowPosition, "DT_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>";
		    	
		    	//���߰��� �Ƿ��� �ڵ� ���. (�������� ���)
		    	ds_default.namevalue(ds_default.RowPosition, "NM_REQUEST")="<%=gusrnm%>";
		    	
		    	//���߰��� ���űٰ� �ڵ� ���. (�������� ���)
		    	ds_default.namevalue(ds_default.RowPosition, "TY_BUYTYPE")= "����";
		    	
		    	//���߰��� ���� �ڵ� ���. (�ۼ������� ���)
		    	ds_default.namevalue(ds_default.RowPosition, "TY_APPROVAL")= "�ۼ���";
	
	
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
										
										//alert("���� ����?");
										
										break;
										
									}
								} 
							}
			
						}else{
							
							alert("�����Ͱ� �������� �ʽ��ϴ�");
							
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
		
		alert("���������� ����Ǿ����ϴ�.");
		
		fnSelect();
		
	}

</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<!-- ���콺 �̺�Ʈ - ����Ŭ�� -->
<script language=javascript for=gr_default event="OnDblClick(Row,Colid)">

			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"NO_MA_REQUEST");		//�����Ƿڼ� ��ȣ
			arrParam[1] = ds_default.NameValue(ds_default.rowposition,"COST_CD");				//Project Code
			arrParam[2] = ds_default.NameValue(ds_default.rowposition,"PLJ_NM");				//Project
			
			strURL = "<%=dirPath%>/Pms/new/pur/rq041.jsp";
			     
			strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			sApproveLine = arrResult; 

</script>	

    	
  	
    
<%
/*=============================================================================
			DataSet Components(DS) ����
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


<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
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
                    	<C> name='����'					ID=CHK						width=40 	align=center    EditStyle=CheckBox show=false</C>
						<C> name='No'					ID='{CurRow}'		 		width=40 	align=CENTER	edit=none </C>	
                    	<C> name='�����Ƿڼ� ��ȣ'		ID='NO_MA_REQUEST'			width=100 	align=CENTER  	edit=none			readonly=true 	mask='XXXXXXXX-XXXX'</C>
                    	<C> name='Code'					ID='COST_CD'				width=70 	align=CENTER 	show=true 			readonly=true	show=false</C>                 	
                        <C> name='Project'				ID='PLJ_NM'					width=180 	align=left 		readonly=true	</C>
                        <C> name='����'					ID='DS_MA_REQUEST'			width=180 	align=left 		readonly=true	</C>
                        <C> name='�Ƿ�����' 			ID='DT_MA_REQUEST'			width=80 	align=CENTER	mask='XXXX-XX-XX'	edit=none	readonly=true</C>
                        <C> name='�Ƿ���'				ID='NM_REQUEST' 			width=60 	align=CENTER	readonly=true 		</C>
                        <C> name='���űٰ�'				ID='TY_BUYTYPE' 			width=80 	align=CENTER	EditStyle=Combo		 Data=' :����,A:�Ϲݱ���,H:������õ'	</C>
                        <C> name='��û ������'			ID='DT_DELIVERY'			width=80 	align=CENTER	mask='XXXX-XX-XX'	readonly=true	</C>
                        <C> name='���� ����'			ID='TY_APPROVAL_PO' 		width=80 	align=CENTER	EditStyle=Combo		 Data=' :����,Y:���οϷ�,R:���ο�û,B:�ݷ�'		</C>
                        <C> name='���'					ID='REMARK'					width=100 	align=left	</C>
                 ">                             
                </object>
            </td>
        </tr>
        
    </table>
    
</body>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>




