<!-- /******************************************************************************
 * �ý��۸� 	 : �����Ƿڼ� - �󼼺���
 * ���α׷�ID 	 : PMS/RQ010
 * J  S  P	 	 : rq011.jsp
 * �� �� ��		 : 
 * �� �� ��		 : �赵��
 * �� �� ��		 : 2018-05-30
 * �������		 : �����Ƿڼ� - �󼼺���
 * [ �������� ][������] ����
 * [ 2018-06-05 ][�赵��] �ű԰���

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

	<jsp:include page="/Pms/common/include/head.jsp"/>

   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>


<script language="javascript">


	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var v_status = ""; //S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����  v_status
	
	var menuWin;	//��â �����.
	
	var arrParam	= new Array();
	
  	arrParam=window.dialogArguments;

    var no_ma_request = arrParam[0];	//�����Ƿڼ� ��ȣ
    
    var cost_cd = arrParam[1];			//Project Code
    
    var plj_nm = arrParam[2];			//Project Nmae

    
    
	/*
	 * �������ε�
	 */
		
	function fnOnLoad(tree_idx){
			
			document.getElementById("v_request_no").value = no_ma_request;		//�����Ƿڼ� ��ȣ
			document.getElementById("v_project").value = plj_nm;				//Project Nmae
			document.getElementById("v_project_code").value = cost_cd;			//Project Code

			cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list
			cfStyleGrid(getObjectFirst("gr_culd"), "comn");	//card usage list detail
			
			fnSelect();
			
	}
		
    
    
	    <%//�ʱ��۾� %>
	    function fnInit() {
	    	

	
	    }
	    
    
	    
    
    
	    <%//���� ��ȸ %>
	    function fnSelect() {
	    	
	    	v_job = "S";
	
	    	//alert(v_job);
	    	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
									+ ",v_project_code=" + v_project_code.value	//Project Code
									+ ",v_request_no=" + v_request_no.value		//Project Code
									;
	
	        
	        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		            "JSP(O:DS_MASTER=ds_master)", //ȭ�� ���. o ->output
		            param);
	        
	        tr_post(tr1);
	        
	        
	        
	        
	        ln_TRSetting(tr2, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		            "JSP(O:DS_DETAIL=ds_detail)", //ȭ�� ���. o ->output
		            param);
	        
	        tr_post(tr2);	        
	        
	        //fnSelectDetail('1');
	
	    }
	    
	        
    
    
	    
    
		<%//���� %>
		function fnApply(){
			
			v_job = "A";
			
			//v_default_row = ds_detail.RowPosition;

			var s_temp = "NO_MA_REQUEST:STRING, SN_NO:DECIMAL, CD_COST:STRING, DS_ITEM:STRING, QN_ITEM:STRING, UP_ITEM:STRING, AM_ITEM:STRING";
			
			ds_detail2.SetDataHeader(s_temp);

	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		                "JSP(I:DS_DETAIL2=ds_detail2)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);
		 	
		 	
		 	
		 			//alert("assa");
	        		//prompt(this, param);
	        		
	        		//������ �� ...�ФФФФФФ�
					//var	pppp =  parseInt(ds_detail.namevalue(1,"REQUEST_QN")) * parseInt(ds_detail.namevalue(1,"EXE_ACT_AMT"));
					
					//alert(pppp);
					
					//ds_detail.namevalue(ds_detail.rowposition,"AM_ITEM") = pppp  ; //û�� �ݾ� - û������ * ����ݾ�
					//ds_detail.namevalue(j,"NO_MA_REQUEST") = document.getElementById("v_request_no").value ; //�����Ƿڼ� ��ȣ
					//ds_detail.namevalue(j,"ORDER_UP") = ds_master.namevalue(i,"ORDER_UP") ;     				//���� �ܰ�
					//ds_detail.namevalue(j,"EXE_ACT_UP"  ) = ds_master.namevalue(i,"EXE_ACT_UP") ;  			//���� �ܰ�
					//ds_detail.namevalue(j,"ALREADY_QN"  ) = ds_master.namevalue(i,"ALREADY_QN") ; 				//��û�� ����
	        		
	        		
					//  �̵��� 
		            for(i=1;i<=ds_detail.countrow;i++){

		            	if(ds_detail.SysStatus(i)==1){
			            	
			            	ds_detail2.addrow();
			            	
			                ds_detail2.namevalue(ds_detail2.rowposition,"NO_MA_REQUEST") = ds_detail.namevalue(i,"NO_MA_REQUEST");
			                ds_detail2.namevalue(ds_detail2.rowposition,"SN_NO") 		 = ds_detail.namevalue(i,"SN_NO");
			                
			                ds_detail2.namevalue(ds_detail2.rowposition,"CD_COST") 		 = ds_detail.namevalue(i,"CD_COST");
			                ds_detail2.namevalue(ds_detail2.rowposition,"DS_ITEM") 		 = fn_trim(ds_detail.namevalue(i,"DS_ITEM"));
			                ds_detail2.namevalue(ds_detail2.rowposition,"QN_ITEM") 		 = ds_detail.namevalue(i,"REQUEST_QN")
			                ds_detail2.namevalue(ds_detail2.rowposition,"UP_ITEM") 		 = ds_detail.namevalue(i,"EXE_ACT_UP");
			                ds_detail2.namevalue(ds_detail2.rowposition,"AM_ITEM") 		 = parseInt(ds_detail.namevalue(i,"REQUEST_QN")) * parseInt(ds_detail.namevalue(i,"EXE_ACT_UP"));

		            	}else if(ds_detail.SysStatus(i)==3){
		            		
		            		alert("���� ������Ʈ");

		            	}
		            	
		            	
		            	
		                //SysStatus  1 = insert , 3 = update
		                //if(ds_detail.SysStatus(i)==1||ds_detail.SysStatus(i)==3){
		                	
		                  	//ds_detail.namevalue(i,"AM_ITEM") = parseInt(ds_detail.namevalue(i,"REQUEST_QN")) * parseInt(ds_detail.namevalue(i,"EXE_ACT_AMT"));
			                //ds_detail.namevalue(i,"NO_MA_REQUEST") = document.getElementById("v_request_no").value ;    //�����Ƿڼ� ��ȣ
			                //ds_detail.namevalue(i,"SN_NO")           = ds_master.namevalue(i,"ORDER_UP") ;                 //���� �ܰ�
			                //ds_detail.namevalue(i,"CD_COST"  )     = ds_master.namevalue(i,"CD_COST") ;              //���� �ܰ�
			                //ds_detail.namevalue(i,"ALREADY_QN"  )  = ds_master.namevalue(i,"ALREADY_QN") ;             //��û�� ����                       
			               
		              	//}
		             
		        	}
					
					
					
		       		//û�� > �������
				 	if(ds_detail.namevalue(ds_detail.rowposition,"REQUEST_QN") > ds_detail.namevalue(ds_detail.rowposition,"EXE_ACT_QN")){
				 		
				 		alert("������� ���� û�������� �����ϴ�");
				 		
				 		return ;
				 		
				 	} 
					
		       		
	        		
	                //prompt(this, ds_detail2.text);
	                
	                //alert("�� === "+v_cost_cd+v_nm_request + v_ds_ma_request +v_ty_buytype +v_remark);
	                
	        		tr_post(tr1);
	        		

	    			fnSelect();
	    			

		}
	    
	


     <%//addrow data %>
	 function fnc_addarrow() {
    	
		//fnSelectDetail();
		fnSelectDetail('1');
    	//alert("ds_master.countrow ==="+ds_master.CountRow );
    	
    	var j = 0;
    	
   		if(ds_master.countrow > 0 ) {
   			
			var param1;

			
			if(ds_detail.namevalue(ds_detail.rowposition,"REQUEST_QN")==""){

				param1 = "";
				
			}else{

				param1 = ds_detail.namevalue(ds_detail.rowposition,"REQUEST_QN");
				
			}

			
			for ( i=1;i<=ds_master.countrow;i++){
				
				if (ds_master.namevalue(i,"CHK") =="T"){
					
					if  (fnc_Appoint_Chk(i)){

									//fnSelectDetail(i);
									
									ds_detail.addrow();

									//j = j + 1;

									j = ds_detail.countrow;

									
									ds_detail.namevalue(j,"NO_MA_REQUEST") = document.getElementById("v_request_no").value ; 	//�����Ƿڼ� ��ȣ
									ds_detail.namevalue(j,"DS_ITEM") = fn_trim(ds_master.namevalue(i,"DS_KSITEM")) ;       		//���� �Ƿ� Contents
									ds_detail.namevalue(j,"CD_COST") = ds_master.namevalue(i,"CD_COST") ;  						//�󼼺з��ڵ�(�����ڵ�)
									ds_detail.namevalue(j,"ORDER_QN") = ds_master.namevalue(i,"ORDER_QN") ;       				//���� ����
									ds_detail.namevalue(j,"ORDER_AMT"  ) = ds_master.namevalue(i,"ORDER_AMT") ;  				//���� �ݾ�
									ds_detail.namevalue(j,"EXE_ACT_QN"  ) = ds_master.namevalue(i,"EXE_ACT_QN") ;  				//���� ����
									ds_detail.namevalue(j,"EXE_ACT_AMT"  ) = ds_master.namevalue(i,"EXE_ACT_AMT") ; 			//���� �ݾ�
									ds_detail.namevalue(j,"ALREADY_AMT"  ) = ds_master.namevalue(i,"ALREADY_AMT") ; 			//��û�� �ݾ�
									ds_detail.namevalue(j,"ORDER_UP") = ds_master.namevalue(i,"ORDER_UP") ;     				//���� �ܰ�
									ds_detail.namevalue(j,"EXE_ACT_UP"  ) = ds_master.namevalue(i,"EXE_ACT_UP") ;  				//���� �ܰ�
									ds_detail.namevalue(j,"ALREADY_QN"  ) = ds_master.namevalue(i,"ALREADY_QN") ; 				//��û�� ���� */
									ds_detail.namevalue(j,"REQUEST_QN"  ) = param1; 											//û��

					}else{
						
						break;
						
					}
					
				} //for
				
			}

			
		}else{
			
			alert("�����Ͱ� �������� �ʽ��ϴ�");
			
		}
		

	}
    

	 
  	<%//addrow data check %>	 
	function fnc_Appoint_Chk(i){

		if(ds_master.namevalue(i,"COST_YN") != "Y"){
			
			alert("���� �����ۿ� ���� û���� �����մϴ�.");
			
			return ;
			
		}		
		
		if(ds_master.namevalue(i,"EXE_ACT_QN") == "0"){
			
			alert("���� ������ Ȯ���Ͻñ� �ٶ��ϴ�.");
			
			return ;
			
		}

		if(ds_master.namevalue(i,"NOTYET_QN") == "0"){
			
			alert("û�� ������ ������ �����ϴ�.");
			
			return ;
			
		}
		
		
		for (i=1; i<=ds_detail.countrow; i++){
			

			if(ds_detail.namevalue(i,"CD_COST") == ds_master.namevalue(ds_master.rowposition,"CD_COST")){
				
				alert("���õ� ǰ���� �ߺ��˴ϴ�.\n\n�ش� ǰ�� ���� ���� ������Ʈ�� �Ͻñ� �ٶ��ϴ�.");
				
				return ;
				
			}
			
		}
			
		
		return true;

	}
	 
	 
	 
	 
     <%//deleterow data %>	 
	 function fnc_deleterow() {
		 
		    	//alert("ds_detail.countrow ==="+ds_detail.CountRow );
		    	
		    	//var ppp;
		    	
		   		if(ds_master.countrow > 0 ) {
		   			
					//var param1;
					var i;
					
					for ( i=1; i<=ds_detail.countrow; i++){
						
						//alert(i+"�� ° checked : "+ds_detail.namevalue(i,"CHKD"));
						
						if (ds_detail.namevalue(i,"CHKD") =="T"){
							
							if  (fnc_Appoint_Chkd(i)){
								
								//alert("rowPosition : "+i);
								ds_detail.DeleteRow(i);
								
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
		 
		 
	    	
	   		/* if(ds_detail.countrow > 0 ) {
	   			//�� ������ row ��
	   			alert(ds_detail.countrow);
				alert("����??");
				for ( i=1;i<=ds_detail.countrow;i++){
					
					if (ds_detail.namevalue(i,"CHKD") == "T"){
	   			alert(ds_detail.namevalue(i,"DS_KSITEM")+"1111111");
						//alert(ds_detail.namevalue(i,"CHKD"));
						
						alert("i=========="+i);

						//fnc_Header_create();
					
						//alert("??");
						//alert(ds_detail.namevalue(i,"DS_KSITEM")+" ���� �Ӹ���?");
						//ds_detail.addrow();
						//ds_detail.DeleteRow(ds_detail.RowPosition);
						
						
						
						ds_detail.DeleteRow(ds_detail.RowPosition);

						prompt(this,ds_detail.text );
					}
				}

			}else{
				alert("�����Ͱ� �������� �ʽ��ϴ�");
			} */
			

		}

	 
	 

	
	
	

	
	  	<%//deleterow data check %>
		function fnc_Appoint_Chkd(i){
	
				return true;
	
		}
		
		
		
	

    <%// ������ ���� %>
	
    //ó������ - ó���� ���� �������� dstype �Ⱦ�.
    
    function fnSelectDetail(row) {
    	
    	//alert("18");
    	
        //v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							        + ",v_project_code="+ v_project_code.value	//������Ʈ �ڵ�
							        + ",v_request_no="+ v_request_no.value
							        ;	
		
        
        //ACQUIRE_SID - sql���̺� �÷� - ī��  - ���������� ������ �ִ� ��
		ln_TRSetting(tr2, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		            "JSP(O:DS_DETAIL=ds_detail)",
		            v_param);
        
		//alert(v_param);
        
		tr_post(tr2);
		
		
    }
    
    

    </script>
    
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>


	<%//������ �׸��� OnClick %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
	
	/* var zzzz1		=	ds_master.namevalue(ds_master.rowposition,"EXE_ACT_QN");
    alert(zzzz1); */
    
		v_job="SD"; //������ ��ȸ
		
	    if(Row==0) return;
		
	    if(v_default_row==Row){
	    	
			return;
		}

	</script>	
	
	
	
	<!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� ds_master |
    +----------------------------------------------------------------->
    <Script For=ds_detail Event="OnLoadCompleted(iCount)">

    </Script>
    
    
    
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=ds_master Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>



    <Script For=ds_detail Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    



	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

		/* fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		ds_master.ClearAll();
		ds_detail.ClearAll();    
		fnc_SearchList(); */
		
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

<script language=JavaScript  for=ds_master event="OnLoadCompleted(row)">
  
      	msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
      
      	/*
		if(v_job=="S"){
			
			if(row==0){
				
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
		        
			}else{
				
				fnSelectDetail(v_default_row);
				
			}
			
		}*/

</script>
    	
    

<!-- ���콺 �̺�Ʈ - ����Ŭ�� - �ο� ,���̵� -->
<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">

 	//alert(ds_cul.NameValue(Row, "DWR_SID"));
 	fnDraft(ds_master.NameValue(Row, "DWR_SID"),ds_master.NameValue(Row, "W_STS"));
 	
</script>	
	
	

    	
    
    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<!-- classid �����. -->
<object id=ds_master classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_detail classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_detail2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="99%">
           			<tr>
           				<td align="center" class="text" width="90">Project</td>
                  		<td bgcolor="#FFFFFF" >&nbsp;
	                  		<input type="text" id="v_project_code" 	name='v_project_code'  	style="width:100px;" class='textbox'  value="">                 		
	                  		<input type="text" id="v_project" 		name='v_project'  		style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" readonly value="">
                  		<td align="center" class="text" width="90">�����Ƿڼ� ��ȣ</td>
                  		<td bgcolor="#FFFFFF" >&nbsp;<input type="text" id="v_request_no" name='v_request_no'  style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" readonly value="">                             
					</tr>
           		</table>
            </td>
        </tr> 
        
        
        <tr height='10px'>
            <td></td>
        </tr>
        
        
        <tr>
            <td valign="top" style="padding-top:4px"><b>&nbsp;&nbsp;[��ü ���� List]</b></td>
        </tr>
        
		<tr>            
            <td class="r">&nbsp;&nbsp;&nbsp;
                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='300px' border='1'>
                    <param name="DataID"            	value="ds_master">
                    <param name="Editable"          	value="true">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name="ColSelect"    			value="True">
					<param name="ColSizing"         	value="true">																								                                        
					<param name="Format"            	value="
						<C> Name='����'					ID=CHK					width=40 		align=center 	EditStyle=CheckBox, cursor=hand edit={IF(chk2=F,'false','true')}</C>
            			<C> name='NO'					id='{CUROW}'			width=40		align=center	value={String(Currow)}	show=false</C>
						<C> name='Contents'				ID='DS_KSITEM'			width=300 		align=left  	edit=none </C>
						<C> name='ITEM'    				ID='COST_YN' 			Width=50  		align=center 	edit=none </C>
						<C> name='���� ����'    		ID='ORDER_QN' 			Width=100  		align=left 		edit=none show=false 	</C>
		                <C> name='���� �ܰ�'    		ID='ORDER_UP'  			Width=100  		align=center  	edit=none show=false 	</C>
		                <C> name='���� �ݾ�'			ID='ORDER_AMT'	    	Width=100  		align=center 	edit=none show=false 	</C>
		                <C> name='�������'	  			ID='EXE_ACT_QN'   		Width=60  		align=center  	edit=none value={decode(COST_YN,'',,'Y',EXE_ACT_QN, )}</C>
		                <C> name='����ܰ�'    			ID='EXE_ACT_UP'    		Width=90  		align=RIGHT  	edit=none value={decode(COST_YN,'',,'Y',EXE_ACT_UP, )}</C>
		                <C> name='����ݾ�'   			ID='EXE_ACT_AMT' 		Width=110  		align=RIGHT 	DEC=0 edit=none</C>
		                <C> name='��û������' 			ID='ALREADY_QN'   		Width=80		align=center 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',ALREADY_QN, )}</C>
		                <C> name='��û���ݾ�'  			ID='ALREADY_AMT'  		Width=80  		align=RIGHT 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',ALREADY_AMT, )}</C>
		                <C> name='��û���ܷ�'   		ID='NOTYET_QN'   		Width=80		align=center 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',NOTYET_QN, )}</C>
		                <C> name='��û���ݾ�'   		ID='NOTYET_AMT'   		Width=80		align=RIGHT 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',NOTYET_AMT, )}</C>
		                <C> name='�����Ƿڼ� ��ȣ'   	ID='NO_MA_REQUEST'  	Width=90		align=RIGHT 	show=false	DEC=0 edit=none</C>
		                <C> name='û��' 	 			ID='REQUEST_QN'  		Width=90  		align=RIGHT 	show=false	DEC=0 edit=none</C>
		                <C> name='Projcet Code'   		ID='COST_CD'   			Width=90		align=RIGHT 	show=false	DEC=0</C>
		                <C> name='Projcet Code'   		ID='CD_COST'   			Width=90		align=RIGHT 	show=false </C>		                
			        ">                       
                </object>                        
            </td>
        </tr>
        
        
        <!-- ��ư ���̺� ���� -->
		<table width="1000" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="35" width="1000" class="paddingTop5" align="center" >
		            <a href="#" ><img src="<%=dirPath%>/Sales/images/addrow_1.gif" 		name="Image1" width="40" height="20" border="0" align="absmiddle" onClick="fnc_addarrow()"></a>
		            <a href="#" ><img src="<%=dirPath%>/Sales/images/deleterow_1.gif" 	name="Image1" width="40" height="20" border="0" align="absmiddle" onClick="fnc_deleterow()"></a>
				</td>
			</tr>
		</table>
		
        <tr>
            <td valign="top" style="padding-top:4px"><b>&nbsp;&nbsp;[û�� ǰ�� List]</b></td>
            
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <td height='20px' align='right'>
            	<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" 	onClick="fnApply();">
            </td>
        </tr>
        
		<tr>            
            <td class="r">&nbsp;&nbsp;&nbsp;            
                <object id=gr_culd classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='300px' border='1'>
                    <param name="DataID"            value="ds_detail">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">                 
                    <param name="SuppressOption"    value="1">
                    <Param Name="AllShowEdit"  		value=True>
					<param name="ColSelect"    		value="True">
					<param name="ColSizing"         value="true">	
                    <param name="Format"            value="
						<C> name='NO'					id='SN_NO'			width=40	align=center	value={String(Currow)}</C>
						<C> name='�ڵ�'    				ID='CD_COST'		Width=130  	align=center	edit=none	</C>						
						<C> name='���� �Ƿ� Contents'	ID='DS_ITEM'		width=250 	align=left			</C>
						<C> name='���޼���'    			ID='ORDER_QN'		Width=60  	align=center	edit=none show=false</C>
		                <C> name='���� �ܰ�'    		ID='ORDER_UP'  		Width=100  	align=center 	edit=none show=false</C>
		                <C> name='���� �ݾ�'			ID='ORDER_AMT'	    Width=100  	align=center 	edit=none show=false</C>
		                <C> name='���� ����'	  		ID='EXE_ACT_QN'   	Width=80  	align=center	edit=none   DEC=0</C>
		                <C> name='���� �ܰ�'    		ID='EXE_ACT_UP'    	Width=80  	align=RIGHT 	edit=none   DEC=0</C>
		                <C> name='���� �ݾ�'   			ID='EXE_ACT_AMT' 	Width=100  	align=RIGHT 	edit=none	DEC=0</C>
		                <C> name='��û�� ����' 			ID='ALREADY_QN'   	Width=100	align=center 	edit=none	DEC=0</C>
		                <C> name='��û�� �ݾ�' 			ID='ALREADY_AMT'   	Width=100	align=RIGHT 	edit=none	DEC=0</C>
		                <C> name='û��' 	 			ID='REQUEST_QN'  	Width=90  	align=center 	</C>
		                <C> name='�����Ƿڼ� ��ȣ'   	ID='NO_MA_REQUEST'  Width=90	align=RIGHT 	show=false		DEC=0</C>
		                <C> name='û�� �ݾ�'   			ID='AM_ITEM'  	 	Width=90	align=RIGHT 	show=false		DEC=0</C>
			        ">                       
                </object>
            </td>
        </tr>
    </table>
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


