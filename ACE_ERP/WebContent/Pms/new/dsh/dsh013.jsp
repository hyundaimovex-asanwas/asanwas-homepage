<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Dash Board Detail</title>
<jsp:include page="/Pms/common/include/head.jsp"/>
<script type="text/javascript">
	
	
	<%//�������ε� %> 
 	function fnOnLoad(){

 		fnInit();
 		
 	}
	
 	
    <%//�ʱ� �۾�  %>
	function fnInit(){
		
		fnSelect();
         
	}
	
	
    <%//���� ��ȸ  %>
    function fnSelect() {

		    v_job="S";
		    
			var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
			
	 		strParam = window.dialogArguments;

			var v_project =  strParam[0]; 
	     
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project=" + v_project
										;
		
	        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh013",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);
	           
	        tr_post(tr1);
	        

    }    
	
    
    <%//����Ÿ �缳��  %>
    function fnData_Reset(p) {

    	//�׸��忡 ���
      	var strno="";
      	var dblDEMMSum=0;//��������
    	var dblCRMMSum=0;//�뺯����
    	var dblDEATSum=0; //���������� ����
    	var dblCRATSum=0; //�뺯������ ����
    	var dblDECTSum=0; //���������ڵ庰 ��
    	var dblCRCTSum=0; //�뺯�����ڵ庰 ��
    	var dblJanSum=0;  //�뺯�����ڵ庰 ��

    	var dblDEATSum_TOT=0; //���������� �����հ�
    	var dblCRATSum_TOT=0; //�뺯������ �����հ�
    	var dblJanSum_TOT=0;  //���հ� �ܾ��հ�
    	

    	var aa=0;
    	
    	//���� ����
      	for(i=1;i<=ds_default.countrow;i++){
      		
    		dblDEMMSum = dblDEMMSum + ds_default.namevalue(i,"DETOT");
    		dblCRMMSum = dblCRMMSum + ds_default.namevalue(i,"CRTOT");
    		
    		dblDEATSum_TOT = dblDEATSum_TOT + ds_default.namevalue(i,"DETOT");
    		dblCRATSum_TOT = dblCRATSum_TOT + ds_default.namevalue(i,"CRTOT");
    		
    		if(ds_default.namevalue(i,"GUBUN")=="M"){       //����
    			
    		     ds_default.namevalue(i,"SSDAT") = "�� ��"
                 ds_default.namevalue(i,"DETOT") = dblDEMMSum;
    			 ds_default.namevalue(i,"CRTOT") = dblCRMMSum;
    			 ds_default.namevalue(i,"JANAMT") = dblJanSum;
    			 
                 dblDEATSum = dblDEATSum +dblDEMMSum;
                 dblCRATSum = dblCRATSum +dblCRMMSum;
                 dblDEMMSum=0;
                 dblCRMMSum=0;
                 
    		}else if(ds_default.namevalue(i,"GUBUN")=="T"){ //����
    			
    		     ds_default.namevalue(i,"SSDAT") = "�� ��"
    		     ds_default.namevalue(i,"DETOT") = dblDEATSum;
    			 ds_default.namevalue(i,"CRTOT") = dblCRATSum;
    			 ds_default.namevalue(i,"JANAMT")= dblJanSum;
    		     
    			 dblDECTSum=dblDECTSum + dblDEATSum; //���������ڵ庰 ��
    	         dblCRCTSum=dblCRCTSum + dblCRATSum; //�뺯�����ڵ庰 ��
    	         
                 dblDEATSum =0;
                 dblCRATSum =0;

    		}else if(ds_default.namevalue(i,"GUBUN")=="C"){  //������
    			
    		     ds_default.namevalue(i,"SSDAT") = "������"
           		 ds_default.namevalue(i,"DETOT") = dblDECTSum;
    			 ds_default.namevalue(i,"CRTOT") = dblCRCTSum;
    			 ds_default.namevalue(i,"JANAMT") = dblJanSum;
    			 dblJanSum_TOT = dblJanSum;
    			 dblDECTSum=0;
    			 dblCRCTSum=0;
    			 dblJanSum =0;
    			 
    		}else{ 
    			
    			 dblJanSum = dblJanSum + ds_default.namevalue(i,"DETOT");
    			 ds_default.namevalue(i,"JANAMT") = dblJanSum;
    			 
    		}
    		
    	}


         //alert("dblDEATSum_TOT::"+dblDEATSum_TOT);
         //2007.05.19 ������ ������ ���հ� �߰�
       	 gcgd_disp.DataID = "ds_default";
         
    	 ds_default.Addrow();
    	 
    	 ds_default.namevalue(ds_default.rowposition,"GUBUN") = "A"    	 
    	 ds_default.namevalue(ds_default.rowposition,"SSDAT") = "���հ�"
    	 
    	 ds_default.namevalue(ds_default.rowposition,"DETOT") = dblDEATSum_TOT;
    	 ds_default.namevalue(ds_default.rowposition,"CRTOT") = dblCRATSum_TOT;
    	 ds_default.namevalue(ds_default.rowposition,"JANAMT") = dblJanSum_TOT;
	        

    }      
    
    
    
    
    
    
  	<%//�׼� �ٿ��ϱ�%>
    function fnExcel() {


    		gcgd_disp.GridToExcel("������Ʈ��","",2);
    	
    		/*
	        getObjectFirst("gcgd_disp").SetExcelTitle(0, "");
	        getObjectFirst("gcgd_disp").SetExcelTitle(1, "value:��ü����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gcgd_disp").GridToExcel("������Ʈ��", "������Ʈ��.xls", 8);        
			*/

    }	          
    
</script>


  <script language="javascript"  for=gcgd_disp event=OnDblClick(Row,Colid)>

			var row = ds_default.rowposition;

			if(ds_default.namevalue(row,"FDCODE") != ''){			
			
				var p_fcod = ds_default.namevalue(row,"FDCODE");
				var p_fsdt = ds_default.namevalue(row,"FSDAT");
				var p_fnbr = ds_default.namevalue(row,"FSNBR");
	
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
	
				arrParam[0] = p_fcod;
				arrParam[1] = p_fsdt;
				arrParam[2] = p_fnbr;
	
				strURL = "../../../Account/jsp/slipno_popup.jsp";
				
				strPos = "dialogWidth:890px;dialogHeight:610px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
				
				arrResult = showModalDialog(strURL,arrParam,strPos);

			}
			
	</script>
			
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="S"){
		
		fnData_Reset("00"); //����Ÿ �缳��	
		
	}


</script>





<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>



</HEAD>

<jsp:include page="/Common/sys/body_s11.jsp"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:980px;border:0 solid #708090">
		<tr>
				<td >
					<h4>���� Detail</h4>
				</td>
		        <td align=right >
	        		<img src="<%=dirPath%>/Sales/images/excel.gif"					style="cursor:pointer" onclick="fnExcel()">
				</td>
		</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<OBJECT classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_disp style="width:980;height:500px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"				VALUE="ds_default">
			  <PARAM NAME="BorderStyle" 		VALUE="0">
			  <PARAM NAME="Indwidth"			VALUE="0">
			  <PARAM NAME="Fillarea"			VALUE="true">
			  <param name="sortview"     		value=left>
			  <param name="ColSizing"         	value="true">
              <param name="Editable"          	value="false">
              <param name="SuppressOption"    	value="1">
              <param name="ViewSummary"       	value="1">
			  <PARAM NAME="Format"				VALUE="  
				<C> Name='������Ʈ��'	ID=COSTNM   	HeadBgColor=#B9D4DC Width=130 	align=left 		suppress=2 </C>
				<C> Name='��������'		ID=ATKORNAM 	HeadBgColor=#B9D4DC Width=130 	align=left 		suppress=1 </C>
				<C> Name='��ǥ����'		ID=SSDAT    	HeadBgColor=#B9D4DC Width=70  	align=center 	BgColor={decode(GUBUN,'M','#CEFBC9','T','#B7F0B1','C','#74D36D','A','#74D36D','')}</C>
				<C> Name='��ȣ'	    	ID=SSNBR    	HeadBgColor=#B9D4DC Width=50  	align=center	BgColor={decode(GUBUN,'M','#CEFBC9','T','#B7F0B1','C','#74D36D','A','#74D36D','')}</C>
				<C> Name='����'	    	ID=DETOT    	HeadBgColor=#B9D4DC Width=80 	align=right color =#0000FF BgColor={decode(GUBUN,'M','#CEFBC9','T','#B7F0B1','C','#74D36D','A','#74D36D','')}</C>
				<C> Name='�뺯'	    	ID=CRTOT    	HeadBgColor=#B9D4DC Width=80 	align=right color =#FF0000 BgColor={decode(GUBUN,'M','#CEFBC9','T','#B7F0B1','C','#74D36D','A','#74D36D','')}</C>
            	<C> Name='��'	    	ID=JANAMT   	HeadBgColor=#B9D4DC Width=80 	align=right 	BgColor={decode(GUBUN,'M','#CEFBC9','T','#B7F0B1','C','#74D36D','A','#74D36D','')}</C>
				<C> Name='����'	    	ID=REMARK   	HeadBgColor=#B9D4DC Width=150 	align=left  </C>
				<C> Name='�ŷ�ó�ڵ�'	ID=VEND_CD   	HeadBgColor=#B9D4DC Width=70 	align=left 	</C>
				<C> Name='�ŷ�ó��'	  	ID=VEND_NM   	HeadBgColor=#B9D4DC Width=120 	align=left 	</C>
				">
	    </OBJECT>
		</td>  
	</tr>

</table>

</body>

</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



