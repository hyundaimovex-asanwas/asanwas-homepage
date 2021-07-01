<!-- /******************************************************************************
 * �ý��۸� 	 : �����Ƿڼ� ���� - �󼼺���
 * ���α׷�ID 	 : PMS/RQ041
 * J  S  P	     : rq041.jsp
 * �� �� ��		 : 
 * �� �� ��		 : �赵��
 * �� �� ��		 : 2018-06-22
 * �������		 : �����Ƿڼ� ���� - �󼼺���
 * [ �������� ][������] ����
 * [ 2018-06-22 ][�赵��] �ű԰���

 *****************************************************************************/ -->

<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>

<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>



<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	//���� tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //�޾ƿ� ���� �޴� ��! fnOnLoad() �Լ��� �Ķ���ͷ� �����Ͽ� �޴�����!

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

   
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>


<script language="javascript">

	var v_default_row = 1;	 			//����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; 					//Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var v_status = "";					//S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����  v_status
	
	var menuWin;						//��â �����.
	
	var arrParam	= new Array();
	
  	arrParam=window.dialogArguments;

    var no_ma_request = arrParam[0];	//�����Ƿڼ� ��ȣ
    
    var cost_cd = arrParam[1];			//Project Code
    
    var plj_nm = arrParam[2];			//Project Nmae


		
	function fnOnLoad(tree_idx){
    	
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    	
			document.getElementById("v_project_no").value = no_ma_request;		//�����Ƿڼ� ��ȣ
			
			document.getElementById("v_project").value = plj_nm;				//Project Nmae
			
			document.getElementById("v_project_code").value = cost_cd;			//Project Code

			
			fnSelect();

			
			cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list
			
			cfStyleGrid(getObjectFirst("gr_culd"), "comn");	//card usage list detail
			

	}


    <%//�ʱ��۾� %>
    function fnInit() {
    	
    	
	    v_job ="I"; //�ʱ�

        
    }
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	
    	v_job="S";

        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_project=" + v_project_code.value	//Project Code
							+ ",v_po=" + v_project_no.value			//���� ��ȣ
							;

        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq040",
	            "JSP(O:DS_CULS=ds_culs)", 
	            param);
        
        tr_post(tr1);

    }
    
    
    
	<%//���� %>
	function fnConsentOn(){
		
		v_job = "A";
		
		v_default_row = ds_culs.RowPosition;
		

	 	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,"
	 					+ "v_project_cd" 	+ document.getElementById("v_project_code").value						//������Ʈ �ڵ�
               			+ "v_no_po" 		+ document.getElementById("v_project_no").value							//���ּ� ��ȣ
			;
	 	
	 	
	 	
 		ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq040",
	                "JSP(I:DS_CULS=ds_culs)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
	                +param
	                	);

        tr_post(tr1);

        
    	fnSelect();
    	
    	
	}
    
	

    
    
    
	<%//addrow data %>
	 function fnc_addarrow() {
		 
		fnSelectDetail();

    	
   		if(ds_culs.countrow > 0 ) {
   			
			var param1;
			
			
			if(ds_culds.namevalue(ds_culds.rowposition,"REQUEST_QN")==""){
				
				param1="";
				
			}else{
				
				param1 = ds_culds.namevalue(ds_culds.rowposition,"REQUEST_QN");
				
			}

			for ( i=1;i<=ds_culs.countrow;i++){
				
				if (ds_culs.namevalue(i,"CHK") =="T"){
					
					if  (fnc_Appoint_Chk(i)){

									ds_culds.addrow();

									j = ds_culds.countrow;

									ds_culds.namevalue(j,"NO_MA_REQUEST") 	= document.getElementById("v_project_no").value ; 		//�����Ƿڼ� ��ȣ
									ds_culds.namevalue(j,"DS_KSITEM") 		= ds_culs.namevalue(i,"DS_KSITEM") ;       				//���� �Ƿ� Contents
									ds_culds.namevalue(j,"CD_COST") 		= ds_culs.namevalue(i,"CD_COST") ;  					//�󼼺з��ڵ�(�����ڵ�)
									ds_culds.namevalue(j,"ORDER_QN") 		= ds_culs.namevalue(i,"ORDER_QN") ;       				//���� ����
									ds_culds.namevalue(j,"ORDER_AMT"  ) 	= ds_culs.namevalue(i,"ORDER_AMT") ;  					//���� �ݾ�
									ds_culds.namevalue(j,"EXE_ACT_QN"  ) 	= ds_culs.namevalue(i,"EXE_ACT_QN") ;  					//���� ����
									ds_culds.namevalue(j,"EXE_ACT_AMT"  ) 	= ds_culs.namevalue(i,"EXE_ACT_AMT") ; 					//���� �ݾ�
									ds_culds.namevalue(j,"ALREADY_AMT"  ) 	= ds_culs.namevalue(i,"ALREADY_AMT") ; 					//��û�� �ݾ�
									ds_culds.namevalue(j,"ORDER_UP") 		= ds_culs.namevalue(i,"ORDER_UP") ;     				//���� �ܰ�
									ds_culds.namevalue(j,"EXE_ACT_UP"  ) 	= ds_culs.namevalue(i,"EXE_ACT_UP") ;  					//���� �ܰ�
									ds_culds.namevalue(j,"ALREADY_QN"  ) 	= ds_culs.namevalue(i,"ALREADY_QN") ; 					//��û�� ����
									
									//�Է� �޴� ��
									ds_culds.namevalue(j,"REQUEST_QN"  ) = param1; 												//û��
	

					}else{
						
						break;
						
					}
				} 
				
			}

		}else{
			
			alert("�����Ͱ� �������� �ʽ��ϴ�");
			
		}
		

	}
    


		<%//addrow data check %>
		function fnc_Appoint_Chk(i){

			if(ds_culs.namevalue(i,"EXE_ACT_QN") == "0"){
				alert("'���� ����'�� Ȯ���Ͻñ� �ٶ��ϴ�.");
				return ;
			}
			return true;

		}
	 
	 
	 
	     
	 	<%//deleterow data %>
		 function fnc_deleterow() {
			 
		    	
		   		if(ds_culs.countrow > 0 ) {
		   			

					var i;
					
					for ( i=1;i<=ds_culds.countrow;i++){

						if (ds_culds.namevalue(i,"CHKD") =="T"){
							
							if  (fnc_Appoint_Chkd(i)){
								

								ds_culds.DeleteRow(i);
								
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
     


	 	<%//deleterow data check  %>
		function fnc_Appoint_Chkd(i){

				return true;

		}
	


    <%// ������ �������� %>
    function fnSelectDetail(row) {

    	
        v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��
        
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
					        + ",v_project=" + v_project_code.value	//Project Code
							+ ",v_po=" + v_project_no.value	//���� ��ȣ
        					;

        
		ln_TRSetting(tr2, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq040",
		            "JSP(O:DS_CULDS=ds_culds)",
		            v_param);
        

		tr_post(tr2);
		
		
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

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

    <script language=JavaScript  for=ds_culs event="OnLoadCompleted(row)">
    
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        
		if(v_job=="S"){
			
			if(row==0){
				
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
		        
			}else{
				
				fnSelectDetail(v_default_row);
				
			}
			
		}
		
	</script>
    	

    	
    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<!-- classid �����. -->
<object id=ds_culs classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_culds classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
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



</head>

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s11.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	
<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="95%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="10%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>


<!-- ��ȸ ���� ���̺� �� -->
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="c">
                <table border='0' cellpadding='0' cellspacing='0' width='990px'>
                    <tr>
			     		<td align=left >
						</td>
                        <td height='25px' align='right'>
                        	<img src="<%=dirPath%>/Sales/images/btn_ConsentOn.gif"		style="cursor:pointer" 	onClick="fnConsentOn();">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
        
        <tr>
            <td class="c">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="98%">
           			<tr>
           			
           				<td align="center" class="text" width="90">Project</td>
                  		<td bgcolor="#FFFFFF" >&nbsp;<input type="text" id="v_project" name='v_project'  style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" readonly value="">
                  		<input type="hidden" id="v_project_code" name='v_project_code'  style="width:200px;" class='textbox'  value="">
                  		
                  		<td align="center" class="text" width="90">���ּ� ��ȣ</td>
                  		<td bgcolor="#FFFFFF" >&nbsp;<input type="text" id="v_project_no" name='v_project_no'  style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" readonly value="">                          
					</tr>
           		</table>
            </td>
        </tr> 
        
        
        <tr height='10px'>
            <td></td>
        </tr>
        
        
        <tr>
            <td valign="top" style="padding-top:4px"><b>[���� �⺻ ����]</b>
                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='200px' border='1'>
                    <param name="DataID"            	value="ds_culs">
                    <param name="Editable"          	value="true">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name=ColSelect    			value="True">
					<param name="ColSizing"         	value="true">																								                                        
					<param name=SelectionColor    		value="
						<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
					">
					<param name="Format"            value="
						<C> name='�ŷ�ó'				ID='VEND_NM'			width=100 	align=center	show=true		edit=none		</C>
						<C> name='���ּ� ����'    		ID='DS_PO' 				Width=100  	align=center	show=true		EditStyle=Combo		 Data=' :����,A:�Ϲݱ���,H:������õ'	</C>
		                <C> name='û�� ����'    		ID='DS_MA_REQUEST'  	Width=200  	align=left  	show=true 		edit=none	</C>
		                <C> name='û�� ����'			ID='DT_MA_REQUEST'	    Width=100  	align=center 	show=true		mask='XXXX-XX-XX'	edit=none</C>
		                <C> name='��ǰ �Ⱓ'	  		ID='DT_DELIVERY'   		Width=100  	align=center  	show=true		mask='XXXX-XX-XX'	edit=none</C>
		                <C> name='��ǰ ���'    		ID='AT_LOCATION'    	Width=80  	align=center 	show=true 	 	edit=none</C>
		                <C> name='�ε� ����'   			ID='CD_DELIVERY' 		Width=100  	align=center 	show=true		DEC=0 	edit=none</C>
		                <C> name='������� ����' 		ID='CD_PAYMENT'   		Width=100	align=center 	show=true		DEC=0 	edit=none</C>
		                <C> name='���'  				ID='REMARK'  			Width=90  	align=center 	show=true		DEC=0 	edit=none</C>
		                <C> name='��û���ܷ�'   		ID='NOTYET_QN'   		Width=90	align=center	show=false		DEC=0 edit=none</C>
		                <C> name='��û���ݾ�'   		ID='NOTYET_AMT'   		Width=90	align=right		show=false		DEC=0 edit=none</C>
		                <C> name='���� ��ȣ'   			ID='NO_PO'   			Width=90	align=RIGHT 	show=false		DEC=0 edit=none</C>
		                <C> name='û��' 	 			ID='REQUEST_QN'  		Width=90  	align=RIGHT 	show=false		edit=none	DEC=0	</C>
		                <C> name='Projcet Code'   		ID='COST_CD'   			Width=90	align=RIGHT 	show=false		DEC=0</C>
		                <C> name='Projcet Name'   		ID='PLJ_NM'   			Width=90	align=RIGHT 	show=false		DEC=0</C>
			        ">                         
                </object>                        

            </td>
        </tr>
        
         <tr height='30px'>
            <td></td>
        </tr>
        
        <tr id="printme">
            <td valign="top" style="padding-top:4px"><b>[���� ǰ�� List]</b>
            	
                <object id=gr_culd classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='350px' border='1'>
                    <param name="DataID"            		value="ds_culds">
                    <param name="Editable"          		value="true">
                    <param name="BorderStyle"       		value="0">                 
                    <param name="SuppressOption"    		value="1">
                    <Param Name="AllShowEdit" 			 	value=True>
					<param name=ColSelect    				value="True">
					<param name="ColSizing"         		value="true">	
                    <param name="Format"            		value="
						<C> name='���� �Ƿ� Contents'		ID='DS_ITEM'		width=180 	align=left		edit=none	</C>
					<G> name='����'
						<C> name='����'    					ID='ORDER_QN'		Width=50  	align=center	edit=none	</C>
		                <C> name='�ܰ�'    					ID='ORDER_UP'  		Width=80  	align=center 	show=false		edit=none	</C>
		                <C> name='�ݾ�'						ID='ORDER_AMT'	    Width=80  	align=right 	edit=none	decao=0</C>
					</G>
					<G> name='����'
		                <C> name='����'	  					ID='EXE_ACT_QN'   	Width=50  	align=center	show=true		edit=none	</C>
		                <C> name='�ܰ�'    					ID='EXE_ACT_UP'    	Width=80  	align=left  	show=false 		edit=none	</C>
		                <C> name='�ݾ�'   					ID='EXE_ACT_AMT' 	Width=80  	align=right 	show=true		edit=none	decao=0</C>
					</G>
					<G> name='û��'
		                <C> name='��û��' 					ID='ALREADY_QN'   	Width=80	align=center 	show=true		edit=none	decao=0</C>
		                <C> name='û��' 	 				ID='REQUEST_QN'  	Width=80  	align=center 	show=true		edit=none	decao=0</C>
					</G>
					<G> name='����'
		                <C> name='����' 	 				ID='QN_ITEM'  		Width=50  	align=center 	show=true		edit=none	</C>
		                <C> name='�ܰ�' 	 				ID='UP_ITEM'  		Width=80  	align=RIGHT 	show=true		edit=none	decao=0</C>
		                <C> name='�ݾ�' 	 				ID='AM_ITEM'  		Width=80  	align=RIGHT 	show=true		edit=none	decao=0</C>
					</G>
		                <C> name='Projcet\\Code'   			ID='COST_CD'   		Width=80	align=center 	</C>
		                <C> name='���ּ� ��ȣ'   			ID='NO_PO'   		Width=100	align=center	mask='XXXXXXXX-XXXX'</C>
			        ">
                </object>
            </td>
        </tr>
    </table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>




