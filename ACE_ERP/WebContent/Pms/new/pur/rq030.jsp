<!-- /******************************************************************************
 * �ý��۸� 	 : �����Ƿڼ� - ����
 * ���α׷�ID 	 : PMS/RQ030
 * J  S  P	 	 : rq030.jsp
 * �� �� ��		 : 
 * �� �� ��		 : �赵��
 * �� �� ��		 : 2018-05-30
 * �������		 : �����Ƿڼ� - ����
 * [ �������� ][������] ����
 * [ 2018-06-20 ][�赵��] �ű԰���

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



	var v_default_row = 1; 				//����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; 					//Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var menuWin;						//��â �����.
	
	var fnSelect3_cnt;					//���� �� ����
	
	
		
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//card usage list
		
		cfStyleGrid(getObjectFirst("gr_default2"), "comn");	//card usage list
		
		cfStyleGrid(getObjectFirst("gr_default3"), "comn");	//card usage list


		
	}

	
    <%//�ʱ��۾� %>
    function fnInit() {

	    v_job ="I";

    }
    
	
	
    <%//���� ��ȸ %>
    function fnSelect() {
    	
    	
    	if(v_request_no.value==""){
    		
    		
    		alert("�����Ƿڼ��� �˻����ּ���.");
    		
    		
    	}else{
    		
    		
	    	fnSelect1();
	    	
	    	fnSelect2();
	    	
	    	fnSelect3();
	    	
    	}
    	
    	
    }
    
    
    
    <%//�⺻ ���� list %>
    function fnSelect1() {
    	
    	
    	v_job="S";
    	
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
										+ ",v_project_code=" + v_project_code.value	//project code , �˻�����
										+ ",v_request_no="   + v_request_no.value	//�����Ƿڼ� ��ȣ, �˻�����
										;


        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		            "JSP(O:DS_DEFAULT=ds_default)", 
		            param);

        
        tr_post(tr1);
        
        
    }
    
    
    
    
    <%//û�� ǰ�� list %>
    function fnSelect2() {
    	
    	v_job="S";
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
										+ ",v_project_code=" + v_project_code.value	//project code , �˻�����
										+ ",v_request_no="   + v_request_no.value	//�����Ƿڼ� ��ȣ, �˻�����
										;
        
        //alert("praram == "+param);
        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		            "JSP(O:DS_DEFAULT2=ds_default2)", 
		            param);
        
        //prompt(this, param);
        //prompt(this, ds_culds);"JSP(O:DS_CULDS=ds_culds)", //ȭ�� ���. o ->output
        
        tr_post(tr1);
        
        
    }    
    
    
    
    
    <%//���� ��ü list %>
    function fnSelect3() {
    	

    	v_job="S";
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
									+ ",v_project_code=" + v_project_code.value	//project�� , �˻�����
									+ ",v_request_no="   + v_request_no.value	//�����Ƿڼ� ��ȣ, �˻�����
									;
        
        //alert("praram == "+param);
        

        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		            "JSP(O:DS_DEFAULT3=ds_default3)", //ȭ�� ���. o ->output
		            param);
        
        //prompt(this, param);
        //prompt(this, ds_cul);
        
        tr_post(tr1);
        
        //alert("�� ���� : "+ds_default3.countrow);
        
        fnSelect3_cnt = ds_default3.countrow;
        
        
    }
    
    
    
    
    

    
    
    
    

    <%//���� %>
	function fnApply(){
		
		
			v_job = "A";
			
			
			v_default_row = ds_default.RowPosition;
			
			
			
			//alert("1");
			//alert(v_default_row+"========v_default_row");
			
			<%-- if (ds_cul.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
	                "JSP(I:DS_CUL=ds_cul,I:DS_CUL=ds_cul)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);
	        		tr_post(tr1);
	        	}
			}else {
	     		alert("������Ʈ�� ���� �����ϴ�.");
		 	} --%>
		 	<%-- if (ds_cul.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
	                "JSP(I:DS_CUL=ds_cul,I:DS_CUL=ds_cul)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);
	        		tr_post(tr1);
	        		alert("2");
	        	}
			}else {
	     		alert("������Ʈ�� ���� �����ϴ�.");
		 	} --%>
		 	//var v_project_code.value
		 	
		 	
		 	
		 	
		 	var v_no_estimate		=	ds_default3.namevalue(ds_default3.rowposition,"NO_ESTIMATE"); 			//������ ��ȣ
		 	var v_cost_cd			=	ds_default3.namevalue(ds_default3.rowposition,"COST_CD"); 					//project code
		 	var v_no_ma_request		=	ds_default3.namevalue(ds_default3.rowposition,"NO_MA_REQUEST"); 				//�����Ƿڼ� ��ȣ
		 	var v_vend_nm			=	ds_default3.namevalue(ds_default3.rowposition,"VEND_NM"); 				//��ü��
		 	var v_cd_vendor			=	ds_default3.namevalue(ds_default3.rowposition,"CD_VENDOR"); 			//����� ��Ϲ�ȣ
		 	var v_vd_direct			=	ds_default3.namevalue(ds_default3.rowposition,"VD_DIRECT"); 			//��ǥ��
		 	var v_bsns_cnd			=	ds_default3.namevalue(ds_default3.rowposition,"BSNS_CND"); 				//����
		 	var v_bsns_knd			=	ds_default3.namevalue(ds_default3.rowposition,"BSNS_KND"); 				//����
		 	var v_vd_telno			=	ds_default3.namevalue(ds_default3.rowposition,"VD_TELNO"); 				//����ó
		 	var v_am_estimate		=	ds_default3.namevalue(ds_default3.rowposition,"AM_ESTIMATE"); 			//���� �ݾ�
		 	var v_choice_reason		=	ds_default3.namevalue(ds_default3.rowposition,"CHOICE_REASON"); 		//���� ����
		 	var v_yn_select			=	ds_default3.namevalue(ds_default3.rowposition,"YN_SELECT"); 			//���� ����
		 	
		 	
		 	//��ȿ�� �˻� check
		 	//alert("���� �� ���� : "+fnSelect3_cnt);
		 	//alert("�߰��� �� ���� : "+ds_default3.countrow);
		 	
		 	
		 	if(fnSelect3_cnt<ds_default3.countrow){
		 		
		 		for ( i=1;i<=fnSelect3_cnt;i++){
		 			
		 			for(j=(fnSelect3_cnt+1);j<=ds_default3.countrow;j++){
		 				
		 			 
		 			//alert("����");
			 		//alert("���� ������ : "+ds_default3.namevalue(i,"CD_VENDOR"));
			 		//alert("���ο� ������ : "+ds_default3.namevalue(j,"CD_VENDOR"));
			 		//alert("���� ������ : "+ds_default3.namevalue(i,"YN_SELECT"));
			 		//alert("���ο� ������ : "+ds_default3.namevalue(j,"YN_SELECT"));
			 		
			 		
			 	
						if (ds_default3.namevalue(i,"CD_VENDOR") ==ds_default3.namevalue(j,"CD_VENDOR")){
							
							alert(i+"��°�࿡ ����ڵ�Ϲ�ȣ�� �ߺ��Ǿ����ϴ�.");
							
							return false;
							
							//�����뼭�� -> 1170932384
							//���밳�� -> 5142280413
							//������ �ִ� ������ �߿��� ������ ������ �������� ���� �Ұ��ϰ�..
							
						}if(v_yn_select=='Y'&&ds_default3.namevalue(i,"YN_SELECT") ==ds_default3.namevalue(j,"YN_SELECT")){
						
							alert("������ �ϳ��� �����մϴ�.");
							
							return false;
							
						}
		 		 	}
		 		
				} 
		 	}
		 	
		 	
		 	
		 	
		 	
		 	if(fnSelect3_cnt==ds_default3.countrow){
		 		
		 		if(ds_default3.namevalue(ds_default3.rowposition,"CD_VENDOR")){
		 			
		 			alert("���� �����Ϳ��� ����ڵ�Ϲ�ȣ�� �ߺ��Ǿ����ϴ�.");
		 			
					return false;
		 			
		 		}if(v_yn_select=='Y'){
		 			
		 			alert("���� �����Ϳ��� ������ �ϳ��� �����մϴ�.");
		 			
					return false;
		 			
		 		}
		 		
		 	}
		 	
		 	

			var param = "v_no_estimate"			+ ds_default3.namevalue(ds_default3.rowposition,"NO_ESTIMATE") 			//������ ��ȣ
				        + "v_cost_cd"			+ ds_default3.namevalue(ds_default3.rowposition,"COST_CD")				//project code
				        + "v_no_ma_request"		+ ds_default3.namevalue(ds_default3.rowposition,"NO_MA_REQUEST") 		//�����Ƿڼ� ��ȣ
				        + "v_vend_nm"			+ ds_default3.namevalue(ds_default3.rowposition,"VEND_NM") 				//��ü��, �ŷ�ó ��
				        + "v_cd_vendor"			+ ds_default3.namevalue(ds_default3.rowposition,"CD_VENDOR") 			//����� ��Ϲ�ȣ 
				        + "v_vd_direct"			+ ds_default3.namevalue(ds_default3.rowposition,"VD_DIRECT") 			//��ǥ��      
				        + "v_bsns_cnd"			+ ds_default3.namevalue(ds_default3.rowposition,"BSNS_CND") 			//����       
				        + "v_bsns_knd"			+ ds_default3.namevalue(ds_default3.rowposition,"BSNS_KND") 			//����       
				        + "v_vd_telno"			+ ds_default3.namevalue(ds_default3.rowposition,"VD_TELNO") 			//����ó      
				        + "v_am_estimate"		+ ds_default3.namevalue(ds_default3.rowposition,"AM_ESTIMATE") 			//���� �ݾ�    
				        + "v_choice_reason"		+ ds_default3.namevalue(ds_default3.rowposition,"CHOICE_REASON") 		//���� ����    
				        + "v_yn_select"			+ ds_default3.namevalue(ds_default3.rowposition,"YN_SELECT") 			//��û ����
				        ;
	
	
	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		                "JSP(I:DS_DEFAULT3=ds_default3)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
		                +param    
		                );
 
	                
	        tr_post(tr1);
	        		

        		
		}
    

    
    
    
    
	<%// �˾� ��ȸ %>
    function fnPopup() {
    	
	    	var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			strURL = "<%=dirPath%>/Pms/new/pur/rq031.jsp";
			strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,'',strPos);
			
			if (arrResult != null) {
				
	    		arrParam = arrResult.split(";");

	    		v_request_no.value 		= arrParam[0];
	    		v_project_code.value 	= arrParam[1];
	    		v_project.value    		= arrParam[2];
	    		
	    		fnSelect();
	    		
	        }else{
	        	
	        	v_project.value    = "";
	        	v_project_code.value = "";
	    		v_request_no.value = "";
	    		
	        }
			

    }
    
		
			
			
			
			
			
		
    <%// addrow data %>
    function fnc_addRow(){

    	
    	
    	//�⺻ ���� list�� �����Ͱ� ���ٸ� �˻��� ���� �����Ͱ� ����.
    	//��, �⺻ ���� list�� �����Ͱ� ���ٸ� �˻�x
    
    		
    	ds_default3.Addrow();
    	
    	
    	//���߰��� �� �޾��ֱ�
    	ds_default3.namevalue(ds_default3.RowPosition, "COST_CD")= v_project_code.value;
    	
    	ds_default3.namevalue(ds_default3.RowPosition, "NO_MA_REQUEST")= v_request_no.value;
    	
    	//ds_default3.namevalue(ds_default3.RowPosition, "NO_ESTIMATE")= "�ڵ�ä��";
    	
    	
    	if(ds_default3.countrow == 0 ||ds_default3.countrow == null ||ds_default3.countrow == "" ){

    		ds_default3.namevalue(ds_default3.RowPosition, "NO_ESTIMATE")= "�ڵ�ä��";
    		
    	}else{

    		ds_default3.namevalue(ds_default3.RowPosition, "NO_ESTIMATE") = ds_default3.namevalue(1, "NO_ESTIMATE"); 
    		
    	}
    	
		msgTxt.innerHTML=" ���� ���ԵǾ����ϴ�.";		

    }
    
    
    
    
    
    

     <%// deleterow data %>
	 function fnc_deleterow() {

	    	//alert("ds_default3.countrow ==="+ds_default3.CountRow );
	    	
	    	//var ppp;
	    	
	    		
		   		if(ds_default3.countrow > 0 ) {
		   			
					//var param1;
					var i;
					
					for ( i=1;i<=ds_default3.countrow;i++){
						//alert(i+"�� ° checked : "+ds_culds.namevalue(i,"CHKD"));
						if (ds_default3.namevalue(i,"CHK") =="T"){

							if  (fnc_Appoint_Chkd(i)){

								//alert("rowPosition : "+i);
								ds_default3.DeleteRow(i);
								
								i--;
								
							}else{
								
								alert("���� ����?");
								
								break;
								
							}
							
						} //for
						
					}
					
	
				}else{

					alert("�����Ͱ� �������� �ʽ��ϴ�");
					
				}
		   		
		   		

    	
   		/* if(ds_culds.countrow > 0 ) {
   			//�� ������ row ��
   			alert(ds_culds.countrow);
			alert("����??");
			for ( i=1;i<=ds_culds.countrow;i++){
				
				if (ds_culds.namevalue(i,"CHKD") == "T"){
   			alert(ds_culds.namevalue(i,"DS_KSITEM")+"1111111");
					//alert(ds_culds.namevalue(i,"CHKD"));
					
					alert("i=========="+i);

					//fnc_Header_create();
				
					//alert("??");
					//alert(ds_culds.namevalue(i,"DS_KSITEM")+" ���� �Ӹ���?");
					//ds_culds.addrow();
					//ds_culds.DeleteRow(ds_culds.RowPosition);
					
					
					
					ds_culds.DeleteRow(ds_culds.RowPosition);

					prompt(this,ds_culds.text );
				}
			}

		}else{
			alert("�����Ͱ� �������� �ʽ��ϴ�");
		} */
		

	}
    
    
    
    
    
    
		function fnc_Appoint_Chkd(i){


			return true;



		}

		
		
		
    <%// ������ �������� %>
    //ó������ - ó���� ���� �������� dstype �Ⱦ�.
   <%--  function fnSelectDetail(row) {
        v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_acquire_sid="+ ds_cul.namevalue(row,"ACQUIRE_SID");
        //ACQUIRE_SID - sql���̺� �÷� - ī��  - ���������� ������ �ִ� ��
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CULD=ds_culd)",
            v_param);
		tr_post(tr2);
    } --%>
    
    
    
    

    
    

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
			DataSet Components(DS) ����
=============================================================================*/
%>


<!-- classid �����. -->
<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_default2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_default3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
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
        <tr height='20px'>
            <td></td>
        </tr>
        <tr>
            <td>
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="1002px">
           			<tr>
                        <td align="center" class="text" width="150">�����Ƿڼ� ��ȣ</td>
                        <td align="left" bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_request_no' id="v_request_no" style="width:100px;background-color:whitesmoke;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="" readonly>
                        <img align="right"  src="<%=dirPath%>/Sales/images/help.gif"		style="cursor:pointer" 	onClick="fnPopup();">
                        <td align="center" class="text" width="150">Project</td>
                        <td align="left" bgcolor="#FFFFFF" ><input type="hidden" name='v_project_code' id="v_project_code" class='textbox'  value="">
                        <td align="left" bgcolor="#FFFFFF" ><input type="text" name='v_project' id="v_project" style="width:300px; background-color:whitesmoke;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="" readonly > 
					</tr>
           		</table>
            </td>
        </tr> 
        
        <tr height='20px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top" style="padding-top:4px"><b>[�⺻ ���� List]</b>
                <object id=gr_default classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='100px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="Editable"          	value="true">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name=ColSelect    			value="True">
					<param name="ColSizing"         	value="true">																								                                        
                    <param name="Format"            	value="
                    	<C> name='�����Ƿڼ� ��ȣ'		ID='NO_MA_REQUEST'			width=90 	align=CENTER  	edit=none			readonly=true 	show=false		</C>
                    	<C> name='������Ʈ �ڵ�'		ID='COST_CD'				width=90 	align=CENTER  	edit=none			readonly=true 	show=false		</C>
                    	<C> name='û�� ����'			ID='DS_MA_REQUEST'			width=300 	align=CENTER  	edit=none			readonly=true 					</C>
                    	<C> name='û�� ����'			ID='DT_MA_REQUEST'			width=100 	align=CENTER 	edit=none 			mask='XXXX-XX-XX'	readonly=true	</C>                 	
                        <C> name='��ǰ �Ⱓ'			ID='DT_DELIVERY'			width=100 	align=CENTER 	edit=none 			mask='XXXX-XX-XX'	readonly=true	</C>
                        <C> name='�ε� ����'			ID='DELIVERY_CONDITION' 	width=140 	align=CENTER	edit=none			readonly=true		</C>
                        <C> name='��� ���� ����'		ID='PAY_CONDITION'			width=150 	align=CENTER 	edit=none			readonly=true		</C>
                        <C> name='��Ÿ ����' 			ID='REMARK'					width=200 	align=CENTER	edit=none			readonly=true		</C>
                    	
                 ">                             
                </object>                   
            </td>
        </tr>
        
        

        <tr height='20px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top" style="padding-top:4px"><b>[û�� ǰ�� List]</b>
                <object id=gr_default2 classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='250px' border='1'>
                    <param name="DataID"            	value="ds_default2">
                    <param name="Editable"          	value="false">
                    <param name="BorderStyle"       	value="0">  
                    <param name="ViewSummary"    		value="1">        
					<param name="ColSelect"    			value="True">
					<param name="ColSizing"         	value="true">	
                    <param name="Format"           		value="
		                <C> name='�����Ƿڼ� ��ȣ'   		ID='NO_MA_REQUEST'  Width=90	align=RIGHT 	show=false	DEC=0</C>
		                <C> name='�ڵ�'   					ID='CD_COST'  		Width=120	align=center	</C>                    
						<C> name='���� �Ƿ� Contents'		ID='DS_KSITEM'		width=320 	align=left		edit=none	</C>
						<C> name='���޼���'    				ID='ORDER_QN'		Width=100  	align=center	show=false	edit=none	</C>
		                <C> name='���� �ܰ�'    			ID='ORDER_UP'  		Width=100  	align=center 	show=false	edit=none	</C>
		                <C> name='���� �ݾ�'				ID='ORDER_AMT'	    Width=100  	align=center 	show=false	edit=none	</C>
		                <C> name='���� ����'	  			ID='EXE_ACT_QN'   	Width=100  	align=center	edit=none	DEC=0</C>
		                <C> name='���� �ܰ�'    			ID='EXE_ACT_UP'    	Width=100  	align=center 	edit=none	DEC=0</C>
		                <C> name='���� �ݾ�'   				ID='EXE_ACT_AMT' 	Width=100  	align=right 	edit=none	DEC=0 sumtext=@sum</C>
		                <C> name='û�� ����' 				ID='QN_ITEM'   		Width=120	align=center 	edit=none	DEC=0</C>		                
		                <C> name='û�� �ݾ�'   				ID='AM_ITEM'  	 	Width=120	align=RIGHT 	edit=none	DEC=0 sumtext=@sum</C>
			        ">
                </object>
            </td>
        </tr>        

        
        <tr height='20px'>
            <td></td>
        </tr>
        

        <tr>
            <td valign="top" style="padding-top:4px"><b>[���� ��ü List]</b>
            
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        		<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" 	onClick="fnApply();">
        		<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer"  onClick="fnc_addRow()" >
        		<img src="<%=dirPath%>/Sales/images/minus.gif"	style="cursor:pointer"  onClick="fnc_deleterow()" >
            </td>
        </tr>
            
            
		<tr>            
            <td>   
                <object id=gr_default3 classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='150px' border='1'>
                    <param name="DataID"            	value="ds_default3">
                    <param name="Editable"          	value="true">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name=ColSelect    			value="True">
					<param name="ColSizing"         	value="true">
                    <param name="Format"            	value="
                    	<C> name='����'					ID=CHK					width=40 	align=center 	bgcolor=#f5f5f5, EditStyle=CheckBox, cursor=hand, sort=false</C>
		                <C> name='������ ��ȣ'			ID='NO_ESTIMATE'		Width=170  	align=center	edit=none mask='XXXXXXXX-XXXX'</C>
                    	<C> name='��ü��'    			ID='VEND_NM'			Width=250  	align=center	</C>
						<C> name='����� ��Ϲ�ȣ'		ID='CD_VENDOR'			width=140 	align=center	mask='XXX-XX-XXXXX'</C>
						<C> name='��ǥ��'    			ID='VD_DIRECT'			Width=100  	align=center	show=false</C>
						<C> name='����'    				ID='BSNS_CND'			Width=170  	align=center	show=false</C>
		                <C> name='����'    				ID='BSNS_KND'  			Width=70  	align=center 	show=false</C>
		                <C> name='����ó'				ID='VD_TELNO'	 	    Width=170  	align=center 	show=false</C>
		                <C> name='���� �ݾ�'	  		ID='AM_ESTIMATE'   		Width=120  	align=right		show=true	</C>
		                <C> name='���� ����'    		ID='CHOICE_REASON'    	Width=150  	align=left  	show=true	</C>
		                <C> name='���� ����' 			ID='YN_SELECT' 			Width=110  	align=center 	show=true	DEC=0	EditStyle=Combo		 Data=' :����,Y:����,N:Ż��'</C>
		                <C> name='Project Code' 		ID='COST_CD' 			Width=110  	align=center 	show=false	DEC=0</C>
		                <C> name='�����Ƿڼ� ��ȣ' 		ID='NO_MA_REQUEST' 		Width=110  	align=center 	show=false	DEC=0</C>
			        ">
                </object>
            </td>
        </tr>



        
    </table>
    
</body>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>




