<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/******************************************************************************
 * �ý��۸� 	 : ���� / ��ü��Ͽ�û �� (�����) - ��ī/���ó�� 
 * ���α׷�ID 	 : Pms/help/cc110h_02.jsp
 * J  S  P		 : cc110h_02.jsp
 * �� �� ��		 : help/Cc110H02
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-09-02
 * �������		 : ���»� ��� ��û
 * [ �������� ][������] ����
 * [2015-09-02][�ɵ���] �ű� gauce 3.x
 * �� �� �� ��	: a010050_s1, a010050_t1
 *****************************************************************************/
%>


<%@ page import="pms.common.HDConstant"%>


<%
    // ContextPath
    String dirPath = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
    
    <title>�ŷ�ó ��� ��û - ����ī�� ���ó��������������������������������������������������������������������������</title>
    
        <jsp:include page="/Pms/common/include/head.jsp"/>
        
        
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>


        <script language="javascript">

        
        var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
        
        var gs_userid = gusrid;
        
        var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
        
        
        
        /******************************************************************************
        	Description : ������ �ε�
        ******************************************************************************/
        function fnOnLoad(){
        		
            gclx_cocomyn.index=0;
            gclx_status.bindcolval ="N";
            txt_empno.value =gusrid;
        	txt_empnmk.value = gusrnm;

        	

        	strParam=window.dialogArguments;
       		
       		if(strParam[5]=="R"||strParam[5]=="N"||strParam[5]=="Y"||strParam[5]=="B"){			//�ŷ�ó ��Ͽ�û�� ���°� ������
       			
       			ln_Query(strParam[5]);
				
       			alert("�������� �ŷ�ó ��Ͽ�û�� �ֽ��ϴ�.\n\n[ȸ�����>������������>�ŷ�ó��Ͽ�û] ���� Ȯ�����ּ���.");
       			
       			fnClose();
       			
       		}else{
       			
               	ln_Add(); //�·ε�� ���ÿ� ���߰�
               	
   	        	//�׸��� �⺻ �� ����
   	        	gcem_vend_id.text	= strParam[0];  //����ڹ�ȣ: JOIN �� ������ �� ���� ���̹Ƿ� �ߺ�üũ �ʿ� ����
   	        	txt_vend_nm.value 	= strParam[1];  //�ŷ�ó��
   	        	txt_vd_direct.value = strParam[2];  //��ǥ��
   	        	txt_vd_telno.value 	= strParam[3].replace(")","");  //��ȭ��ȣ
   	        	txt_address2.value 	= strParam[4];  //�ּ�(�˻� �����)
   	        	txt_bsns_cnd.value 	= "-";			//����
   	        	txt_bsns_knd.value 	= "-";			//����
   	        	txt_remark.value	= "����ī�� ���ó������ ��� ��û";	//���
    	        txt_address1.focus();
   	        	
       		}
       		
        }
        
        
        
        
		<%//javascript�� replaceAll �Լ�- ���۸�%>
        function replaceAll(str, searchStr, replaceStr) {
        	
            return str.split(searchStr).join(replaceStr);
            
        }
        
        
        
        <%//��ȸ-��ư ����. ����/���ο�û �� �ڵ���ȸ�� ����%>
        function ln_Query(p1){
        	
        	
        	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="					//�ŷ�ó�ڵ�
                                                                                +"&v_str2="					//�ŷ�ó��
                                                                                +"&v_str3="+p1				//�̰� ����
                                                                                +"&v_str4="+strParam[0]		//�̰� ���� ����ڹ�ȣ    
                                                                                +"&v_str5="+txt_empno.value	//�̰� �ۼ���   	
                                                                                +"&v_str6=1";				//�̰� ������ ����ڹ�ȣ     	
            //prompt('',gcds_data.DataID);
                                                                                
        	gcds_data.Reset();
        	
        	
        }

        
        
        
        <%//���߰� - �ڵ� ��� ��� ����  N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�%>
        function ln_Add(){
        	
        	ln_SetDataHeader();
        	
        	gcds_data.addrow();	
        	
            gclx_cocomyn.index=0;
            
            gclx_status.bindcolval ="N";
            
            gcds_data.namevalue(gcds_data.rowposition,"USE_TAG")="Y";
            
        }

        
        
        <%//����- ������ ���� && �ŷ�ó�ڵ� ����%>
        function ln_Save(){
        	
        	if(!ln_Chk_Save())return;
        	
        	else if (gcds_data.IsUpdated) {
        		
        	    if(!ln_Chk_Save_Status())return;
        	
        		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
        			
	        		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t1";
	        		gctr_pyo.Parameters = "v_str1="+gs_userid;
	
	        		gctr_pyo.post();
	        		
	        		ln_Query("N");	//����ȸ-���
        		
        		}	
        		
        		
        		
        		if (confirm("���ο�û �Ͻðڽ��ϱ�?")){
        		
        			gcds_data.namevalue(gcds_data.rowposition,"CHK") = "T";
        			
        			ln_AppReq();
        			
        		}
        		
        	}
        	
        	fnClose();
        	
        }

        
        
        
        <%//�� üũ%>
        
        function ln_Chk_Save() {
        	
          //���°��� ��� �ϰ�츸 ���� 
           for(i=1;i<=gcds_data.countrow;i++){
        	   
           		if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
           			
           			if(gcds_data.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
        				alert("��Ϲ�ȣ�� �Է��ϼ���.");
        				return false;
        			}
           			
        			if(fn_trim(gcds_data.namevalue(i,"VEND_NM")) == ""){//�ŷ�ó��
        				alert("�ŷ�ó����  �Է��ϼ���.");
        				return false;
        			}
        			
        			if(fn_trim(gcds_data.namevalue(i,"VD_DIRECT")) == ""){//��ǥ�ڸ�
        				alert("��ǥ�ڸ���  �Է��ϼ���.");
        				return false;
        			}
        			
        			if(fn_trim(gcds_data.namevalue(i,"BSNS_CND")) == "" ){ //����				
        				alert("���¸� �Է��ϼ��� .");
        				return false;
        			}		
        			
        			if(fn_trim(gcds_data.namevalue(i,"BSNS_KND")) == "" ){ //����				
        				alert("������  �Է��ϼ��� .");
        				return false;
        			}		
        			
        			if(gcds_data.namevalue(i,"COCOMYN") == "" ){ //��ü����				
        				alert("��ü������  �Է��ϼ��� .");
        				return false;
        			}	
        			
        			
        			/* 2018.10.29 �ż��� ���� ��û���� �ʼ����� �������� BY �̵��� */
        			/*
        			if(fn_trim(gcds_data.namevalue(i,"POST_NO1")) == "" && fn_trim(gcds_data.namevalue(i,"POST_NO2")) ){ //�����ȣ				
        				alert("�����ȣ��  �Է��ϼ��� .");
        				return false;
        			}	
        			if(fn_trim(gcds_data.namevalue(i,"ADDRESS1")) == "" ){ //�ּ�				
        				alert("�����ȣ �˻��� �̿��� �ּҸ� �Է����ּ���.");
        				return false;
        			}	
        			*/
        			if(fn_trim(gcds_data.namevalue(i,"ADDRESS2")) == "" ){ //��Ÿ�ּ�				
        				alert("��Ÿ�ּҸ�  �Է��ϼ��� .");
        				return false;
        			}	
        			
        			
        		}
           		
           }
          
        	return true;
        	
        }

        
        
        
        <%//��� : undo�ϰ� â �ݱ�%>
        function ln_Cancel(){
        	
        	gcds_data.undo(gcds_data.rowposition);
        	
        	fnClose();        	
        	
        }

        
        
        
        <%//���ο�û: ��� ���� �� ��û%>
        function ln_AppReq(){
        	
            //���°� üũ : ��� �ݼ� ���¸� ��û ������ 
            if(!ln_Chk_Status()) return false;
        
        
        	//if (confirm(" �ش� �ŷ�ó ��� ���� ��û �Ͻðڽ��ϱ�?")){	
        		
       		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t2";
       		gctr_pyo.Parameters = "v_str1="+gs_userid;
       		gctr_pyo.post();
       		ln_Query("R");	//����ȸ-�ۼ���+(���ο�û)����
        		
        	//}	
        	
        }

        
        
        <%//����� ���°� üũ : ������ ������ ��%>
        function ln_Chk_Save_Status(){
        	
        	for(var i =1; i<=gcds_data.countrow;i++){
        		
        		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
        		if(gcds_data.SysStatus(i)==3){
        			
        			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
        				
        				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ���� ���ɰ��� �ƴմϴ�.");
        				
        				return false;
        			}
        			
        		}
        		
        	}
        	return true;
        }

        
        
        
        
        <%//��û�� ���°� üũ %>
        function ln_Chk_Status(){
        	
            var vcnt=0;
            
        	for(var i =1; i<=gcds_data.countrow;i++){
        		
        		if(gcds_data.namevalue(i,"CHK")=="T"){
        			
        			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
        				
        				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ��û ���ɰ��� �ƴմϴ�.");
        				
        				return false;
        				
        			}else{
        				
        				gcds_data.namevalue(i,"STATUS")="R"; 
        				
        			}
        			
        			vcnt+=1;
        		}
        		
        	}
        	
        	if (vcnt==0){
        		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
        		return false;
        	}
        	
        	return true;
        	
        }
        
        
        
        
        
        

        <%//����ڹ�ȣ �ߺ�üũ ��-����Ʈ �����ֱ�~%>
        function ln_Find2(){
        	
        	var arrResult	= new Array();
        	var arrParam	= new Array();
        	var strURL;	
        	var strPos;

        	
        	if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
        	    alert("�ű� ��Ͻÿ��� �ߺ� üũ �����մϴ�.");
        		return false;
        	}
        	
        	
        	strURL = "<%=dirPath%>/Pms/help/cc110h_02_1.jsp";
        	strPos = "dialogWidth:494px;dialogHeight:120px;status:no;scroll:no;resizable:no";
        	arrResult = showModalDialog(strURL,'',strPos);

        	
         	if (arrResult != null) {
         		
        		arrParam = arrResult.split(";");
        		ln_usegb_format(arrParam[1]);
        		gcem_vend_id.text = arrParam[0];
        		
        	} else {
        		
        		gcem_vend_id.text ="";
        		
        	}
         	
         	
        }


        <%//��Ϲ�ȣ ������%>
        function ln_usegb_format(strusegb){
        	
        	if(strusegb=="1"){ //
        		
        		gcem_vend_id.Format = "000-00-00000";        //����
        		
        	}else if(strusegb=="2"){
        		
        		gcem_vend_id.Format = "000000-0000000";  //���� 
        		
        	}
        }

        
        
        
        
        <%//Dataset Head ���� -%>
        function ln_SetDataHeader(){
        	
        	if(gcds_data.countrow<1){
        		
        		var THeader = "CHK:STRING, VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
        							+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
        							+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
        							+ "USE_TAG:STRING,"
        							+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
        							+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
        							+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
        							+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING";
        		gcds_data.SetDataHeader(THeader);		
        		
        	}
        	
        }
        
        
        

        <%//�����ȣ //parameter   : p==> 01 - �ŷ�ó, 02 - ����, 03 - �����	%>
        function ln_Popup(e){
        	
        	
        	var arrParam	= new Array();
        	var arrResult	= new Array();
        	var strURL;	
        	var strPos;

        	
        	//strURL = "<%=dirPath%>/Common/jsp/com_zipcd.jsp";
        	
        	strPos = "dialogWidth:640px;dialogHeight:425px;status:no;scroll:no;resizable:no";
        	
        	arrResult = showModalDialog(strURL,arrParam,strPos);


        	if (arrResult != null) {
        		
        		arrParam = arrResult.split(";");
        		var post_no1 = arrParam[0];
        		txt_post_no1.value= post_no1.substring(0,3);
        		txt_post_no2.value= post_no1.substring(3,6);
        		txt_address1.value = arrParam[1] + arrParam[2]; 
        		txt_address2.value= arrParam[3] + arrParam[4];
        		
        	}else {
        		
        		txt_post_no1.value= "";
        		txt_post_no2.value= "";
        		txt_address1.value=""; 
        		txt_address2.value="";
        		
        	}
        	
        }

        
        
        
        function fnClose() {
        	
            window.close();
            
        }
        
        </script>




		<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
		
		
		
		<script>
		function openDaumPostcode() {
		    	
		    var width =500;
		    var height =600; 	
		    	
		    new daum.Postcode({
		    	
		    	 width:width,
		         height:height,
		    	
		    	
		        oncomplete: function(data) {
		            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ��Դϴ�.
		            // ������ �����Ͽ� �پ��� Ȱ����� Ȯ���� ������.
		            
		        	 var strpostcode="";  //���� �����ȣ ( 6�ڸ� )
		             var strzonecode="";  //�ű� �����ȣ ( 5�ڸ� )
		             strzonecode = data.zonecode;   
		             
		             document.getElementById('txt_post_no1').value = strzonecode.substring(0,3);
		             document.getElementById('txt_post_no2').value = strzonecode.substring(3,6);		             
		             document.getElementById('txt_address1').value = data.address;
		             document.getElementById('txt_address2').focus();
		        }
		    }).open({
		    	    left:(window.screen.width/2)-(width/2),
				    top:(window.screen.height/2)-(height/2)
		    	
		    		});
		 }
		
		
		
		</script> 



       
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>



<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>  



<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";  //���� 
	}
	
</script>




<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>
    var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }

	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");
</script>



<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");

</script>
 
 
 
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>


<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�

	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	
</script>



<script language="javascript" for="gctr_pyo" event="onfail()">

	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
	
</script>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

<script language=JavaScript event="OnLoadError()" for=gcds_data>

	alert("������ �߻� �߽��ϴ�.");
	
</script>

 
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>


<object  id=ds_gc_gubn classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>


<comment id="__NSID__"><object id=gcds_data classid=<%=HDConstant.CT_DATASET_CLSID%> VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>



<!-- �α��� ��� üũ  -->
<comment id="__NSID__"><object  id=gcds_userid2 classid=<%=HDConstant.CT_DATASET_CLSID%> VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script> 



<object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
</object>






    </head> 
    
    
    
<!--  BODY START -->
	<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
	
        <table>
		  <tr> 
			<td>
			
			<table border="0" cellpadding="0" cellspacing="0" width=100%>
			  <tr>
				<td class="l">
					&nbsp;<img src="../../Common/img/btn/com_b_appreq.gif"	style="cursor:hand" onclick="ln_AppReq()" >
				</td>
				<td class="r">
					<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">&nbsp;
					<img src="../../Common/img/btn/com_b_cancle.gif"    style="cursor:hand" onclick="ln_Cancel()">&nbsp;
				</td>
			  </tr>
			</table>
			
			</td>
		  </tr>
		  
		  
		  <tr> 			
			<td ALIGN=LEFT VALIGN=TOP>
				<object classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_pyo style="WIDTH:331px;HEIGHT:42px;border:1 solid #777777;display:block;" viewastext>
					 <PARAM NAME="DataID"			VALUE="gcds_data">
					 <PARAM NAME="BorderStyle"  VALUE="0">
					 <PARAM NAME="Indwidth"		VALUE="0">
					 <PARAM NAME="Fillarea"		    VALUE="true">
					 <PARAM NAME="ColSizing"		VALUE="true">
					 <param name="Editable"     	value='true'>
					 <param name=UsingOneClick  value="1">
				     <PARAM NAME="Format"			VALUE="  
				        <FC>ID=CHK 	         Name='����'            Width=28      HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 Editstyle=CheckBox   </C>  
						<FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,		width=85,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
						<FC>ID=VEND_NM,	     Name=�ŷ�ó��,			width=120,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,        edit=none  sort = true</FC>
						<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		width=110,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort=true</FC>
						<C> ID=VD_DIRECT,	 Name=��ǥ��,			    width=60,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
						<C> ID=BSNS_CND,	 Name=����,	            width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
						<C> ID=BSNS_KND,	 Name=����,	            width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
						<C> ID=COCOMYN,	     Name=��ü����,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true Editstyle=Combo, Data='N:�Ϲݾ�ü,T:���̰�����ü,M:�鼼��ü', show = true </C>
						<C> ID=STATUS		 Name=����,			    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,        edit=none,	sort = true, Editstyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�', show = true </C>
					    <C> ID=SB_REASON,    Name=�ݼۻ���,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
					">
				 </object> 
			</td>
		  </tr>
		  
		  
		  <tr>
			<td>
			<table border="0" cellpadding="0" cellspacing="0">
			  <tr>
				<td class="text" width="110px" height="30" style="border:1 solid #708090">�ۼ���</td>
				<td width="220px" style="border:1 solid #708090;border-left-width:0px">
					<input type="text" class="txt11" id="txt_empno"  style="width:60px;background-color:#d7d7d7" readOnly> &nbsp;
				    <input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="width:90px;"> 
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;��Ϲ�ȣ</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="m l">&nbsp;&nbsp;
					<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;top:2px;">		
						<param name=Text			value="">
						<param name=Alignment     	value=0>
						<param name=Border          value=true>
						<param name=Numeric       	value=false>
						<param name=Format          value="###-##-#####">
						<param name=PromptChar  	value="">
						<param name=BackColor     	value="#CCCCCC">  
						<param name=InheritColor   	value=false>
						<param name=readOnly       	value=true>
						<param name=ReadOnlyBackColor   value="#d7d7d7">
				   </object>&nbsp;
				   <span style="color:#ff0000;position:relative;top:-4px;font-weight:bold;">üũ �Ϸ�</span>					
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó�ڵ�</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
				<input id="txt_vend_cd" class="txtbox" type="text" style="width:100px;top:0px;background-color:#d7d7d7"    ReadOnly>
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó��</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_vend_nm" class="txtbox" type="text" style="width:190px;top:0px"   >
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;��ǥ�ڸ�</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_vd_direct"   type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;">
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;����</td>
		  		<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_bsns_cnd"    type="text"   class="txtbox"  style= "position:relative;width:190px;height:20px;">
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_bsns_knd"    type="text"   class="txtbox"  style= "position:relative;width:190px;height:20px;">
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;��ü����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_cocomyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			        value="N^�Ϲݾ�ü,T^���̰�����ü,M^�鼼��ü">
						<param name=CBDataColumns	     	value="CODE,NAME">
						<param name=SearchColumn	     	value=NAME>
						<param name=Sort			     	value=false>
						<param name=ListExprFormat       	value="NAME">								
						<param name=BindColumn		     	value="CODE">
					</object> &nbsp;&nbsp;
	    			<!--  2019.10.31 ��ũ ������ �̵���
	    			<a href="http://www.hometax.go.kr" target="_blank" style="color:#0000ff;position:relative;top:-4px;font-weight:bold;">����������ȸ</a> 
	    			-->
	    			<a href="https://teht.hometax.go.kr/websquare/websquare.html?w2xPath=/ui/ab/a/a/UTEABAAA13.xml" target="_blank" style="color:#0000ff;position:relative;top:-4px;font-weight:bold;">����������ȸ</a>
	    			
		 		</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;�����ȣ</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_post_no1"    type="text"   class="txtbox"  style= "position:relative;width:30px;height:20px;top:2px;background-color:#d7d7d7"" readOnly="true";>&nbsp;~
					<input id="txt_post_no2"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:30px;height:20px;top:2px;background-color:#d7d7d7"" readOnly="true";>
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ȣ�� �˻��մϴ�" style="cursor:hand;position:relative;left:1px;top:0px" align=center onclick="openDaumPostcode()">&nbsp;			 
							 ��)000-000 </td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;�ּ�</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_address1"    type="text"   class="txtbox"  style= "position:relative;width:190px;height:20px;" onkeypress="if(event.keyCode==13) ln_Popup('c');">
		 		</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;��Ÿ�ּ�</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_address2"    type="text"   class="txtbox"  style= "position:relative;width:190px;height:20px;">
		 		</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;��ȭ��ȣ</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_vd_telno"    type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;">
		 			��)000-0000-0000 </td> 
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;�ѽ���ȣ</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_vd_faxno"    type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;">
					��)000-0000-0000
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;���</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;width:180px;height:20px;" ; >
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;�����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true";>
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;����Ͻ�</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;<font color="#ff0000">*</font>&nbsp;����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			    value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
						<param name=CBDataColumns		value="CODE,NAME">
						<param name=SearchColumn	    value=NAME>
						<param name=Sort			    value=false>
						<param name=ListExprFormat      value="NAME">								
						<param name=BindColumn		    value="CODE">
						<param name=Enable              value="false">
					</object> 
				</td>
			  </tr>
			</table>
			</td>
		  </tr>
        </table>




		<object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
			<param name=DataID    value=gcds_data>
			<param name=BindInfo  value='
				<C>Col=VEND_ID,         Ctrl=gcem_vend_id   	Param=text		    </C>
				<C>Col=VEND_CD,        	Ctrl=txt_vend_cd       	Param=value			</C>
				<C>Col=VEND_NM,       	Ctrl=txt_vend_nm  		Param=value			</C>
				<C>Col=VD_DIRECT,     	Ctrl=txt_vd_direct     	Param=value		    </C>
				<C>Col=BSNS_CND,     	Ctrl=txt_bsns_cnd   	Param=value		    </C>
				<C>Col=BSNS_KND,  		Ctrl=txt_bsns_knd    	Param=value			</C>
				<C>Col=VD_TELNO,  		Ctrl=txt_vd_telno       Param=value			</C>
				<C>Col=VD_FAXNO,  		Ctrl=txt_vd_faxno      	Param=value			</C>
				<C>Col=POST_NO1,  		Ctrl=txt_post_no1      	Param=value			</C>
				<C>Col=POST_NO2,  		Ctrl=txt_post_no2 	    Param=value			</C>
				<C>Col=ADDRESS1,  		Ctrl=txt_address1 		Param=value			</C>
				<C>Col=ADDRESS2,  		Ctrl=txt_address2     	Param=value  	    </C>
				<C>Col=COCOMYN,   		Ctrl=gclx_cocomyn  		Param=bindcolval 	</C>
				<C>Col=REMARK,    	    Ctrl=txt_remark         Param=value			</C>
				<C>Col=WRID,      	    Ctrl=txt_wrid     	   	Param=value			</C>
				<C>Col=WRDT,      	    Ctrl=txt_wrdt     	   	Param=value			</C>
				<C>Col=STATUS,   	    Ctrl=gclx_status 	   	Param=bindcolval	</C>
				<C>Col=SB_REASON,   	Ctrl=txt_sb_reason  	Param=value     	</C>
			'>
		</object>
    </body>
    <!-- BODY END -->
</html>


