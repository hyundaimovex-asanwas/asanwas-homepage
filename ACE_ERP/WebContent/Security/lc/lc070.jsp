<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>��������>��������
* ���α׷� ID	: lc070.jsp
* �� �� �� ��	: ��������
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2017.7.4
-----------------------------------------------------------------------------
*	S1, S2 ��Ÿ����     - 2020.03.24 ��Ȱ��ȭ
*	A1, A2 �ڳ�_0989
*	A3, A4 �ڳ�CS_3260  - 2020.03.24 �߰���
*   T1, T2 ��Ÿ��_0796
*   C1, C2 ī�Ϲ�1_0623
*   C3, C4 ī�Ϲ�2_0887
*   C5, C6 ī�Ϲ�3_0702
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>��������</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
	gcem_yyyymmdd.text = gcurdate.substring(0,7) + "01";
	gcem_yyyymmdd2.text = gcurdate;
	
    fnInit();

    txt_empno.value =gusrid;
	txt_empnmk.value = gusrnm;		    
    
	fnSelect();
    
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){

		
	//�����ڸ� �̻�� ó�� ����
	if(gusrid == '1990105' || gusrid == '2030007' || gusrid == '6060002'){

	}else{		
		document.getElementById("Image1").style.display = "none";
	}


}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function fnSelect() {

	 	var STATUS_SHR = document.getElementById("cmbSTATUS").value;
	 	var CAR_MODEL = document.getElementById("cmbCAR_MODEL").value;
	 	
	 	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_staxdate="+gcem_yyyymmdd.text
																				     + ",v_etaxdate="+gcem_yyyymmdd2.text
																				     + ",v_enono=" + txt_empno.value 
																					 + ",v_status=" + STATUS_SHR	 
		 																			 + ",v_carmodel=" + CAR_MODEL;	
	 	
    	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc070",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    
    	tr_post(tr1);

}

/******************************************************************************
Description : ����
******************************************************************************/
function fnSave() {

	var eno_no = ds_default.namevalue(ds_default.rowPosition,"ENO_NO");
	var eno_nm = ds_default.namevalue(ds_default.rowPosition,"ENO_NM");

	if (ds_default2.CountColumn == 0) {
		ds_default2.setDataHeader("ENO_NO:STRING");
	}
	
	// �� �߰�
	ds_default2.AddRow();		
	
	ds_default2.namevalue(1,"ENO_NO") = eno_no;	 		
	
	if(confirm(eno_nm+"�� ���� ���ú��� 1�ް� �̻�� ó���� �Ͻðڽ��ϱ�?")){		
	
	    ln_TRSetting(tr2, "<%=dirPath%><%=HDConstant.PATH_LI%>Lc095",  "JSP(I:DS_DEFAULT2=ds_default2)",  "proType=A, dsType=1");

	    //prompt(this, ds_default2.text);
	       
	    tr_post(tr2);
	    
	}

}


/******************************************************************************
Description : ����
******************************************************************************/

function fnExcel() {
	
	if(ds_default.RowCount==0){
        alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
        return;
    } 
	

    getObjectFirst("gcgd_disp02").SetExcelTitle(0, "");
    getObjectFirst("gcgd_disp02").SetExcelTitle(1, "value:������Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
    getObjectFirst("gcgd_disp02").GridToExcel("������Ȳ","��������.xls", 32);
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>



 </script>



<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>


		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var carno;
		var time = ds_default.NameValue(row, "FROM_TM");
		var status = ds_default.NameValue(row, "STATUS");
		
		var strURL;	
		var strPos;

		sendParam[0] = ds_default.NameValue(row, "DRIVE_DT"); 
		sendParam[1] = ds_default.NameValue(row, "CAR_NO"); 
		sendParam[2] = time; 	
		sendParam[3] = status;	
		
		//alert(sendParam);
		
		strURL = "../../Security/lc/lc075.jsp";
		strPos = "dialogWidth:400px;dialogHeight:500px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);
		
		ds_default.ClearAll();

		fnSelect();			
		
 </script>


<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<!--  <img src="<%=dirPath%>/Sales/images/save.gif"	name="Image1"	style="cursor:hand" onclick="fnSave()"> -->		
			<img src="<%=dirPath%>/Sales/images/excel.gif"						style="cursor:hand" onclick="fnExcel()">			
			<img src="<%=dirPath%>/Sales/images/refer.gif"						style="cursor:hand" onclick="fnSelect()">
		</td>
	</tr>
</table>

<br>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>�Ⱓ</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_yyyymmdd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					
					&nbsp;~
					
					<comment id="__NSID__">
					<object  id=gcem_yyyymmdd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>	
	
	
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>����</td>  
	    <td width="150px" class="tab24">&nbsp;
                     <select id=cmbCAR_MODEL style="WIDTH:100" onChange='fnSelect();'>
                        <option value="O">��ü</option>                                 
                        <option value="A">�ڳ�_0989</option>  
                        <option value="T">��Ÿ��_0796</option>           
                        <option value="C">ī�Ϲ�1_0623</option>  
                        <option value="CS">ī�Ϲ�2_0887</option>                         
                        <option value="K">ī�Ϲ�3_0702</option>  
                        <option value="A2">�ڳ�CS_3260</option>  
                    </select>
		</td>	
	
		<td width="80px"   class="tab24" bgcolor="#eeeeee" align=center>ó����</td>
		<td width="200px" class="tab24"  >&nbsp;
				<input id="txt_empno" name="txt_empno" size="7" maxlength= "7"">
                <input id="txt_empnmk" name="txt_empnmk" size="10" maxlength= "14">
                <img src="../../Ehr/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
		</td> 

		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>�ۼ�</td>  
	    <td width="120px" class="tab24">&nbsp;
                     <select id=cmbSTATUS style="WIDTH:100" onChange='fnSelect();'>
                        <option value="A">��ü</option>                
                        <option value="N">���ۼ�</option>                    
                        <option value="Y">�ۼ�</option>
                    </select>
		</td>
	</tr>
</table>

<br>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  style="position:relative;left:0px;width:1000px; height:510px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_default">
					<param name="IndWidth"		 		value='0'>
					<param name="BorderStyle"  			value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 			value="true">
					<param name="Editable"		 		value="true"> 
					<param name=TitleHeight      		value="30">
                    <param name="SuppressOption"   		value="1">						
					<param name="Format"	 	 		value=" 
					<C> name='NO'					id={currow}			HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=center</C>
					<C> Name='����'		  			ID=CAR_NO 	  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center	 show=false</C>
					<C> Name='����'		  			ID=CAR_NO 	  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 		align=center sort=true	 value={Decode(CAR_NO,'A1','�ڳ�_0989','A2','�ڳ�_0989','A3','�ڳ�CS_3260','A4','�ڳ�CS_3260','T1','��Ÿ��_0796','T2','��Ÿ��_0796','C1','ī�Ϲ�1_0623','C2','ī�Ϲ�1_0623','C3','ī�Ϲ�2_0887','C4','ī�Ϲ�2_0887','C5','ī�Ϲ�3_0702','C6','ī�Ϲ�3_0702')}</C>
 					<C> Name='����'		  			ID=DRIVE_DT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 		align=center	 mask ='XXXX-XX-XX' </C>
                    <C> Name='����'        			ID=FROM_TM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center </C> 					
                    <C> Name='����'        			ID=TO_TM  			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center </C>
                    <C> Name='������'        		ID=DESTINATION 		HeadAlign=Center HeadBgColor=#B9D4DC Width=150 		align=center </C>                     
                    <C> Name='����'        			ID=REMARK 			HeadAlign=Center HeadBgColor=#B9D4DC Width=260 		align=center align = left</C>
					<C> Name='�����'      			ID=ENO_NO			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center show=false</C>                                         
					<C> Name='�����'      			ID=ENO_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center </C> 
                    <C> Name='���'        			ID=DRIVE_BEFORE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center </C> 					
                    <C> Name='����'        			ID=DRIVE_AFTER  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center </C>                     
					<C> Name='�ۼ�����'      		ID=STATUS			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center </C>
					<C> Name='P'      				ID=PENALTY			HeadAlign=Center HeadBgColor=#B9D4DC Width=30 		align=center EditStyle=CheckBox show=false</C> 					                    
					">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>

</table> 

</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



