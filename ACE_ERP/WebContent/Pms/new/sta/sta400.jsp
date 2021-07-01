<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���Ե�� - ��õ¡��
 * ���α׷�ID 	 : PMS/Sta
 * J  S  P		 : Sta400.jsp
 * �� �� ��		 : Sta400
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-06-21
 * �������		 : ���Ե�� - ��õ¡��
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/


	var gs_userid = gusrid;
	var gs_fdcode;
	
	var gstrempno="";
	var gstrdeptcd="";
	var gstrGubun ="";
	var gstrAuthgr="";
	var gstrRowpos="";




	var v_default_row = 1;
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		
		fnInit();
		
	}
	
	<%//�ʱ��۾� %>
	function fnInit() {
		
	    v_job ="I";
	    
	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8)%>";		
		
		
    	//�����ڵ�
    	ds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
    	ds_fdcode.Reset();


		fnSelect();
	    
	}

	
	

	
	
    <%//���� ��ȸ  %>
    function fnSelect() {
    	
		    v_job="S";

	        var fr_date = v_fr_date.Text.trim();
	        var to_date = v_to_date.Text.trim();

	        if(fr_date.length!=8) {
	            alert("����(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("����(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}

	                  
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
									                + ",v_frdt=" + fr_date						//from
									                + ",v_todt=" + to_date   					//to
	                  								+ ",v_vendor_cd="  + v_vendor_cd.value	    //�ŷ�ó�ڵ�              								
													+ ",v_eno_no="  + v_eno_no.value;			//�ۼ��ڻ��
	                  								
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_STA%>Sta400",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	           
	        tr_post(tr1);
	        

    }    	
	




	<% //�ŷ�ó�ڵ� %>
	function fnSelect_vendor(dirPath){
		
	    var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	

		strURL = dirPath+"/Account/jsp/gczm_vender_popup.jsp";
		
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrVAT,strPos);
		
		
		if (arrResult != null) {
			
			arrParam = arrResult.split(";");

    		v_vendor_cd.value = arrParam[0];
    		v_vendor_nm.value = arrParam[1];			

			
		} else {
			
    		v_vendor_cd.value = "";
    		v_vendor_nm.value = "";				

		}
		
	}





    <%//���� ��- �˻����� ó���� : �����ڸ� �����ϰ�%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		
    		v_eno_no.value = arrParam[1];
    		v_eno_nm.value = arrParam[0];

    		
        } else {
        	
			fnEmpNoCleanup();
			
        }               
    	
    }

    
    
    <%	//�ۼ��� ����	%>
    function fnEmpNoCleanup(){
    	
        v_eno_no.value = "";
        v_eno_nm.value  = "";
        
    }






	<%	//��ǥ��ȸ 		%>
	function ln_Slipno(){
		
		if(gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") != "") {	
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL="";	
			var strPos="";
	
			arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"FDCODE");
			arrParam[1] = gcds_data.namevalue(gcds_data.rowposition,"FSDAT");
			arrParam[2] = gcds_data.namevalue(gcds_data.rowposition,"FSNBR");
	
			strURL = "/Account/jsp/slipno_popup.jsp";
			
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
		}else if (gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") == "") {
			
			alert("���� �� ��ǥ�� �����ϴ�.");
			
		}
		
	
	}

	
	
	
    <%//��ǥ ���� Ŭ����%>
    function fnStateCreate(){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;

		strURL = "<%=dirPath%>/Pms/new/sta/sta310.jsp";
		
    	strPos = "dialogWidth:1050px;dialogHeight:800px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	if (arrResult != null) {
    		
        } else {

        }    
        
        
    }



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>


<object  id="ds_fdcode" classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ�[�˻�] -->
</object> 



<object id=ds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>




<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript  for=ds_default event=OnLoadCompleted(row,colid)>

		window.status = "���������� ��ȸ�Ǿ����ϴ�.";
		
		if (row<1) 
			alert("�˻��� �����Ͱ� �����ϴ�.");
</script>





<script language="javascript" for="ds_fdcode" event="onloadCompleted(row,colid)">

	ds_fdcode.InsertRow(1);
	
	ds_fdcode.NameValue(1,"FDCODE")="";
	
	ds_fdcode.NameValue(1,"FDNAME")="��ü";
	
	lc_fdcode.bindcolval=gs_fdcode;
	
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript"  for=ds_default  event="OnDblClick(Row,Colid)">

	
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</head>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>


<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">

        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
						
			     		<td align=left >&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/sta_issue.gif"				style="cursor:pointer" onClick="fnStateCreate();">
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"					style="cursor:pointer" onClick="fnApply();">							
							<img src="<%=dirPath%>/Sales/images/new.gif"					style="cursor:pointer" onClick="fnNew();">	
                        </td>					
						
                    </tr>
                </table>
            </td>
        </tr>

	<tr><td height=4></td></tr>
</table>

<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>

            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>

                        <td align=left class="text"  width="80">�Ⱓ</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>&nbsp;~&nbsp;
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>           			

                        <td align="left" class="text" width="80">�����ڵ�</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_fdcode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
								<param name=ComboDataID			value="ds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
	              				<param name=Enable              value="true">
								<param name=ListExprFormat	    value="FDNAME^0^100">
								<param name=BindColumn			value="FDCODE">
								<param name=Index               value="2">                            
                            </object>
                        </td>                         
                               
                        <td align="left" class="text" width="80">�����</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_cocode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
								<param name=CBData				value="^��ü,01^��,02^����,04^ȫ��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
                            </object>            
                        </td>     
                     
                  
					</tr>

           			<tr>
                        <td align="center" class="text" width="80">�ŷ�ó</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_vendor_cd' id="v_vendor_cd" style="width:60px;" class='input01'  readOnly="readonly" value="">                                                	
                        	<input type="text" name='v_vendor_nm' id="v_vendor_nm" style="width:150px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelect_vendor('<%=dirPath%>');" alt="�ŷ�ó ã��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>


                        <td align="center" class="text" width="80">�ۼ���</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_eno_no' id="v_eno_no" style="width:60px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrid")%>">                        
                        	<input type="text" name='v_eno_nm' id="v_eno_nm" style="width:100px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrnm")%>">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="���� ã��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>       

                        <td align="center" class="text" width="80">��ǥ����</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_fsstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
								<param name=CBData					value="^��ü,Y^����Ϸ�,C^�������,R^�����û,N^������,B^�ݼ�,X^����Ϸ��̿�">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                        
					</tr>
           		</table>
            </td>	
	</tr>
	

  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>
  
  
  <tr>
      <td valign="top">
          <table  border='0' cellpadding='0' cellspacing='0'>
              <tr>
                  <td valign='top' width="1000px">
                      <%=HDConstant.COMMENT_START%>
                      <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='580px' border='1'>
                          <param name="DataID"            value="ds_default">
                          <param name="ColSizing"         value="true">
                          <param name="Editable"          value="true">
                          <param name="SuppressOption"    value="1">
                          <param name="BorderStyle"       value="0">
                          <param name="ViewSummary"       value="1">
                          <param name="Format"            value="
							<C>ID=CHK,				Name='����'				width=30, 	align=center, EditStyle=CheckBox BgColor='#f5f5f5'</C>
							<C>ID=FDNAME, 			Name='����'				width=30, 	align=left,   Edit=none show=false</C>
							<C>ID=FSSTAT,			Name='��ǥ����'			width=75,  align=center  EditStyle=Combo, Data='Y:����Ϸ�,C:�������,R:�����û,N:������,B:�ݼ�' Edit=none sort=true show=false</C>
							
							<C>ID=PL_DEPT_NM,		Name='�ͼӱ���'			width=130, align=LEFT    Edit=none sort=true </C>							
							
							<C>ID=PLJ_NM,			Name='�����ڵ�'			width=135, align=LEFT    Edit=none sort=true </C>
							<C>ID=ATKORNAM,			Name='������'			width=135, align=LEFT    Edit=none sort=true SumText='�հ�'</C>
														
							<C>ID=SSNBR,			Name='��ǥ��ȣ'			width=115, 	align=center, Edit=none sort=true mask='XXXXXXXXX-XXXXXX' show=false</C>
							<C>ID=FSNBR,			Name='������ȣ'			width=115,  align=center  Edit=none sort=true mask='XXXXXXXXX-XXXXXX' show=false</C>
														
							<C>ID=VEND_CD,			Name='�ŷ�ó�ڵ�'		width=80,  	align=center, BgColor='#f5f5f5' 	Edit=none show=false </C>
				                       
							<C>ID=VEND_NM,			Name='�ŷ�ó��'			width=95,  	align=LEFT,   BgColor='#f5f5f5' 	Edit=none sort=true </C>
							<C>ID=VEND_ID,			Name='����ڹ�ȣ'		width=90,  	align=center, mask='XXX-XX-XXXXX'	Edit=none sort=true </C>

							<C>ID=TAXTOT,			Name='�հ�ݾ�'			width=95,  align=right   Edit=none sort=true  sumtext=@sum</C>		                             
        
							<C>ID=REMARK,			Name='����'				width=135, align=LEFT    Edit=none sort=true </C>
							<C>ID=TAXKNDNM,			Name='����'	     		width=45,  align=center  Edit=none sort=true show=false</C>

							<C>ID=DEPTNM,			Name='���μ�'			width=70,  align=left    Edit=none sort=true show=true </C>
							<C>ID=EMPNMK,			Name='�����'			width=65,  align=center  Edit=none sort=true show=true </C>

							<C>ID=DUEDATE,  		Name='�Աݿ�����'		width=90,  align=center  Edit=none sort=true show=fals mask='XXXX-XX-XX' show=false</C>
							<C>ID=TAXSTS,	 		Name='�������'	  		width=75,  align=center  EditStyle=Combo, Data='N:���,R:��û,Y:����,B:�ݼ�' Edit=none sort=true show=false</C>
									                             
                       ">
                      </object>   
                      <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
            </table>
		</td>
    </tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 