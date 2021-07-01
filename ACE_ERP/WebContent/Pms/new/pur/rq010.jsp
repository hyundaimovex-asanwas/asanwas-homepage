<!-- /******************************************************************************
 * �ý��۸� 	 	 : �����Ƿڼ� - �ۼ�
 * ���α׷�ID 	 : PMS/RQ010
 * J  S  P	 : rq010.jsp
 * �� �� ��		 : 
 * �� �� ��		 : �赵��
 * �� �� ��		 : 2018-05-30
 * �������		 : �����Ƿڼ� - �ۼ�
 * [ �������� ][������] ����
 * [ 2018-06-05 ][�赵��] �ű԰���

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


<!-- HTML ���� : doctype�� html5�� �غ���? ��;;-->

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

	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var menuWin;	//��â �����.
	
	/*
	 * �������ε�
	 */
	
	 
	 

	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list

		fnInit();
	}
	
	
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
	    fnSelect();

    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	
    	
    	v_job="S";
    	
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
											+ ",v_project=" + v_project.value	//project�� , �˻�����
											;

        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
		            "JSP(O:DS_DEFAULT=ds_default)", //ȭ�� ���
		            param);
        

        tr_post(tr1);
        
    }
    
    
        
    
    
    <%//���� %>
	function fnApply(){
		
		v_job = "A";
		
		v_default_row = ds_default.RowPosition;

		
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
	 	
	 	
	 	
	 	
	 	if(v_ty_buytype=="����"||v_ty_buytype==null||v_ty_buytype==' '){
	 		alert("���űٰŸ� �������ּ���.");
	 		return;
	 	}
	 	
	 	//if(v_remark==""||v_remark==null){
	 	//	alert("��� �Է����ּ���.");
	 	//	return; }

 		ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
	                "JSP(I:DS_DEFAULT=ds_default)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                //+ "v_cost_cd"			+ ds_default.namevalue(ds_default.rowposition,"COST_CD") 			//������Ʈ �ڵ�
	                //+ "v_no_ma_request"		+ ds_default.namevalue(ds_default.rowposition,"NO_MA_REQUEST") 		//�����Ƿڼ� ��ȣ
	                //+ "v_ds_ma_request" 	+ ds_default.namevalue(ds_default.rowposition,"DS_MA_REQUEST")		//contents
	                //+ "v_ty_buytype" 		+ ds_default.namevalue(ds_default.rowposition,"TY_BUYTYPE")			//���űٰ�
	                //+ "v_remark" 			+ ds_default.namevalue(ds_default.rowposition,"REMARK")				//���
                	);

 		
		//prompt(this, ds_default.text);
   			 		
        tr_post(tr1);



        		
        		
	}
	

	
    
    <%//���߰�%>
    function fnAddRowDt1(){
    	
    	ds_default.addrow();
    	
    	//ds_default.namevalue(ds_default.RowPosition, "NO_MA_REQUEST")= "�ڵ�ä��";
    	ds_default.namevalue(ds_default.RowPosition, "NO_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>" + '0000';
    	
    	//���߰��� �Ƿ����� �ڵ� ���. (���� ��¥�� ���)
    	ds_default.namevalue(ds_default.RowPosition, "DT_MA_REQUEST")= "<%=DateUtil.getCurrentDate(8)%>";
    	
    	//���߰��� �Ƿ��� �ڵ� ���. (�������� ���)
    	ds_default.namevalue(ds_default.RowPosition, "NM_REQUEST")="<%=gusrnm%>";
    	
    	//���߰��� ���űٰ� �ڵ� ���. (�������� ���)
    	ds_default.namevalue(ds_default.RowPosition, "TY_BUYTYPE")= " ";
    	
    	//���߰��� ���� �ڵ� ���. (�ۼ������� ���)
    	ds_default.namevalue(ds_default.RowPosition, "TY_APPROVAL")= "�ۼ���";
    	
    	
    	
    	ds_default.namevalue(ds_default.RowPosition, "ca_sid") = ds_default.namevalue(ds_default.RowPosition,"CA_SID");
    	ds_default.namevalue(ds_default.RowPosition, "canbr") = ds_default.namevalue(ds_default.RowPosition,"CANBR");

		msgTxt.innerHTML=" ���� ���ԵǾ����ϴ�.";		
		
		
		
    }
    
    
    <%//�����%>
	 function fnc_deleterow() {


		   		if(ds_default.countrow > 0 ) {

		   			
			        if(confirm("������Ͻø� �ٷ� �����˴ϴ�.\n\n�����Ͻðڽ��ϱ�?")==false){
			        	
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
					
					alert("�����Ͱ� �������� �ʽ��ϴ�");
					
				}

		   		fnSelect();
		   		
		   		
	}
   


   <%//���ο�û%>
   function fnRequest(){

		v_job = "A";
	   
        if (confirm("���ο�û�Ͻðڽ��ϱ�?")){

	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
					         + ",v_stat=R" 				//���ο�û status
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
		
		alert("���������� ó���Ǿ����ϴ�.");
		
		fnSelect();
	}
	
	
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

	<!-- ��ȸ �˾� -->
	<script language=javascript  for=gr_cul event=OnPopup(Row,Colid,data)>
	
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;
		var strPos;

		
		//�÷� ���� PLJ_NM 'Project'�̸� �����ض�.
		if(Colid == "PLJ_NM"){
			
			
			//�� �������°�
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
			
			

		//�÷� ���� �ŷ�ó�̸� �����ض�.
		}else if(Colid == "VEND_NM"){


			if (ds_default.namevalue(ds_default.rowposition,"TY_BUYTYPE") != "H"){
				
				alert("���űٰŰ� ������õ�� ��쿡�� ���ð����մϴ�");
				
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
	
    	//�÷� ���� FUNC�̸� �����Ƿ� ȭ������ �̵��϶�
		if(Colid == "FUNC"){
			
			//�� ������ �κ�

			 if (ds_default.namevalue(ds_default.rowposition,"COST_CD")!="") {
				 
				 arrParam[0] = ds_default.NameValue(ds_default.rowposition,"NO_MA_REQUEST");		//�����Ƿڼ� ��ȣ
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




<jsp:include page="/Common/sys/body_s10.jsp"/>

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
                    	<C> name='����'					ID=CHK						width=40 	align=center 	bgcolor=#f5f5f5 	EditStyle=CheckBox	 cursor=hand	 sort=false</C>
                    	<C> name='�����Ƿڼ� ��ȣ'		ID='NO_MA_REQUEST'			width=90 	align=CENTER  	edit=none			mask='XXXXXXXX-XXXX'</C>
                    	<C> name='Code'					ID='COST_CD'				width=50 	align=CENTER 	show=false 			</C>                 	
                        <C> name='Project'				ID='PLJ_NM'					width=180 	align=left	 	EditStyle=Popup 	</C>
                        <C> name='Contents'				ID='DS_MA_REQUEST'   		width=130 	align=left		</C>
                        <C> name='�Ƿ�����' 			ID='DT_MA_REQUEST'			width=70 	align=CENTER	decao=0  			mask='XXXX-XX-XX'	edit=none	readonly=true		</C>
                        <C> name='�Ƿ���'				ID='NM_REQUEST' 			width=70 	align=CENTER	readonly=true </C>
                        <C> name='���űٰ�'				ID='TY_BUYTYPE' 			width=70 	align=CENTER	EditStyle=Combo		 Data=' :����,A:�Ϲݱ���,H:������õ'</C>
                        <C> name='����'					ID='TY_APPROVAL'			width=70 	align=CENTER 	edit=none	readonly=true</C>
                        <C> name='�ŷ�ó'				ID='VEND_CD'				width=70 	align=CENTER	show=false 	   </C>                        
                        <C> name='�ŷ�ó'				ID='VEND_NM'				width=100 	align=left 		EditStyle=Popup</C>
                        <C> name='���'					ID='REMARK'					width=80 	align=left		</C>
                        <C> name='�ۼ�'					ID='FUNC'					width=80 	align=center	Color='red' value={'�����Ƿ�'}</C>
                 ">                             
                </object>                 
            </td>
        </tr>
 
    </table>
    
    <table border='0' cellpadding='0' cellspacing='0'> 
        <tr>
            <td valign="top">
		            <br>�� ó�� ���μ���<br>
		            ��			    1. <b><font color=red>���߰�</font></b>�� : �����Ƿڿ� ���� Master ���� ����ϴ�. ��ư Ŭ���� Project column�� ����Ŭ���ؼ� Project�� �����մϴ�.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;2. <b><font color=red>�����Ƿ� �ۼ�</font></b>�� : [�����Ƿ�] ��ư�� ������, �����Ƿ��ϴ� ȭ������ �̵��մϴ�.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;3. <b><font color=red>���ο�û</font></b>�� : [���ο�û] ��ư�� ������, ���ο�û ���·� �Ѿ�ϴ�.				
            </td>
        </tr>
    </table>    
    
    
</body>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


