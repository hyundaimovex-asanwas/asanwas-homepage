<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: �ڻ����- �Ǽ������ڻ�
+ ���α׷� ID	: A090029.html
+ �� �� �� ��	: �Ǽ������ڻ� ���ȭ��. ( �Ѱ�ǥ ��¿����� ����� ) 
+ ��   ��  �� : ������
+ �� �� �� �� : 2011.07.11
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090029_s1,A090029_s2, A090029_s3
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�Ǽ������ڻ�</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
  
	//�Ҽ��ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//�����׸�(�Ǽ������ڻ�)
	gcds_astrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1009";
	gcds_astrefcd.Reset();

  //�׸����
	gcds_astrefcd_g.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1009";
	gcds_astrefcd_g.Reset();

	//�����׸�(�Ǽ����ڻ��)
	gcds_astcipcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2180";
	gcds_astcipcd.Reset();

	gcds_astcipcd_g.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2180";
	gcds_astcipcd_g.Reset();
	
	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_aststat.index=0;

 }

/******************************************************************************
	Description : ��ȸ
	Parameter   : p - 01 : �ű������ ,  02 : ��ü���
******************************************************************************/
function ln_Query(p){

	if(p=="01"){
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_s1"
											 + "?v_str1="+gclx_fdcode.bindcolval
											 + "&v_str2="+gclx_astrefcd.bindcolval
											 + "&v_str3="+gclx_astcipcd.bindcolval
											 + "&v_str4="+gclx_aststat.bindcolval;
		//prompt('',gcds_data01.DataID);
		gcds_data01.Reset();
	}else{
		gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_s2"
											 + "?v_str1="+gclx_fdcode.bindcolval
											 + "&v_str2="+gclx_astrefcd.bindcolval
											 + "&v_str3="+gclx_astcipcd.bindcolval
											 + "&v_str4="+gclx_aststat.bindcolval;
		//prompt('',gcds_data02.DataID);
		gcds_data02.Reset();
	}
}

/******************************************************************************
	Description : �߰�
	Parameter   : p - 01 : �ű������,  02 : ��ü���
******************************************************************************/
function ln_Add(p){
	if(p=="01"){
		gcds_data01.Addrow();
	}else{
		gcds_data02.Addrow();
	}
}

/******************************************************************************
	Description : ����
	Parameter   : p - 01 : �ű������,  02 : ��ü���
******************************************************************************/
function ln_Save(p){
	if(p=="01"){
		if(!ln_Chk_Save(p)) return; 
		if(gcds_data01.IsUpdated){
			if(confirm("�Ǽ������ڻ� �ű������ �Ͻðڽ��ϱ�?")){
					gctr_code01.KeyValue   =  "Account.a090029_t1(I:USER=gcds_data01)";
					gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t1?";
					gctr_code01.Parameters =  "v_str1="+gusrid;
					//prompt('',gcds_data01.text);
					gctr_code01.post();
			}
		}
	}else{
		if(!ln_Chk_Save(p)) return; 
		if(gcds_data02.IsUpdated){
			if(confirm("�Ǽ������ڻ� ��ü����� �Ͻðڽ��ϱ�?")){
					gctr_code01.KeyValue   =  "Account.a090029_t2(I:USER=gcds_data02)";
					gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t2?";
					gctr_code01.Parameters =  "v_str1="+gusrid;
					//prompt('',gcds_data02.text);
					gctr_code01.post();
			}
		}
	}
}

/******************************************************************************
	Description : �߰�
	Parameter   : p - 01 : �ű������,  02 : ��ü���
******************************************************************************/
function ln_Chk_Save(p){
	return true;
}


/******************************************************************************
	Description : ����
	Parameter   : p - 01 : �ű������,  02 : ��ü���
******************************************************************************/
function ln_Delete(p){
  if(p=="01"){
		if (confirm("�����Ͻ� �ű������ ���� �����Ͻðڽ��ϱ�?")){
				gcds_data01.deleterow(gcds_data01.rowposition);
				gctr_code01.KeyValue = "a090029_t1(I:USER=gcds_data01)";
				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t1";
				//prompt('',gcds_code02.text);
				gctr_code01.post();
		}
  }else{
		if (confirm("�����Ͻ� ��ü��� ���� �����Ͻðڽ��ϱ�?")){
				gcds_data02.deleterow(gcds_data02.rowposition);
				gctr_code01.KeyValue = "a090029_t2(I:USER=gcds_data02)";
				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090029_t2";
				//prompt('',gcds_code02.text);
				gctr_code01.post();
		}
	}
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- �����׸� -->
<object  id=gcds_astrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_astrefcd_g classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- �Ǽ������ڻ�� -->
<object  id=gcds_astcipcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_astcipcd_g classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- ���� -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090008_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>


<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ft_cnt02.innerText="����Ÿ ��ȸ���Դϴ�.";
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)"> 
  ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.index=0;
</script>


<!-- �����׸� (�˻�)-->
<script language="javascript" for="gcds_astrefcd" event="onloadCompleted(row,colid)">
	gcds_astrefcd.InsertRow(1);
	gcds_astrefcd.NameValue(1,"CDCODE")="";
	gcds_astrefcd.NameValue(1,"CDNAM")="��ü";
	gclx_astrefcd.index=0;
</script>

<!-- �Ǽ������ڻ��-->
<script language="javascript" for="gcds_astcipcd" event="onloadCompleted(row,colid)">
	gcds_astcipcd.InsertRow(1);
	gcds_astcipcd.NameValue(1,"CDCODE")="";
	gcds_astcipcd.NameValue(1,"CDNAM")="��ü";
	gclx_astcipcd.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
	ln_Ast3rd();
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>  
	
</script>


<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = gcds_data01.namevalue(row,"FDCODE");

	strURL = "./hcdept_popup4.jsp";
	strPos = "dialogWidth:500px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		arrParam = arrResult.split(";"); 
		//alert("arrParam[0]::"+arrParam[0]+"::arrParam[1]"+arrParam[1]);
		gcds_data01.namevalue(row,"USEDPT")= ln_Trim(arrParam[0]);
		gcds_data01.namevalue(row,"DEPTNM")= ln_Trim(arrParam[1]);
	} else {
		gcds_data01.namevalue(row,"USEDPT")= "";
		gcds_data01.namevalue(row,"DEPTNM")= "";
	}

</script>


<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if(colid=="ASTNM"){

		strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			gcds_data02.namevalue(row,"ASTNM")  = arrParam[1];  //�ڻ��
			gcds_data02.namevalue(row,"ASTNAME")= arrParam[0];  //�ڻ��ڵ�
		} else {
			gcds_data02.namevalue(row,"ASTNM")  = "";
			gcds_data02.namevalue(row,"ASTNAME")= "";
		}
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090029_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>����</td>
		<td width="100px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:80px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat	value="FDNAME^0^100">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 

    <td width="80px"   class="tab24"  bgcolor="#eeeeee" align=center>�����׸�</td>  
	  <td class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_astrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
				<param name=ComboDataID     value="gcds_astrefcd">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
				<param name=XPStyle         value=true>
			</object></comment><script>__ws__(__NSID__);</script> 			
		</td>
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>�Ǽ����ڻ��</td>  
	  <td width="180px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_astcipcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:160px;">
				<param name=ComboDataID     value="gcds_astcipcd">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="CDNAM^0^170">
				<param name=BindColumn			value="CDCODE">
				<param name=XPStyle         value=true>
       </object>
			 </comment><script>__ws__(__NSID__);</script>
		</td>

		<td width="80px"   class="tab24"  bgcolor="#eeeeee" align=center>����</td>  
	  <td class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_aststat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:90px;">
				<param name=CBData					value="''^��ü,0^������,1^�Ϸ�">
				<param name=CBDataColumns		value="Code, Parm">
				<param name=SearchColumn		value="Parm">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="Parm^0^100">
				<param name=BindColumn			value="Code">
				<param name=XPStyle         value=true>
			</OBJECT></comment><script>__ws__(__NSID__);</script> 			
		</td>
	</tr>
</table>
<table><tr><td height="1px;"> </td></tr></table>


<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr>
		<td width="680px" > <font size="2" color="blue"> <b> [�ű������] </b> </font></td>
		<td align="right" >
			<img src="../../Common/img/btn/com_b_delete.gif"	  style="cursor:hand" onClick="ln_Delete('01')">
			<img src="../../Common/img/btn/com_b_insert.gif"	  style="cursor:hand" onClick="ln_Add('01')">
			<img src="../../Common/img/btn/com_b_save.gif"	    style="cursor:hand" onClick="ln_Save('01')">
			<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onClick="ln_Query('01')">
		</td>
	</tr>
	<tr> 
		<td colspan =2>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:200px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_data01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name=ViewSummary   value="1">
					<param name="Format"		value=" 
					<C> Name='����'		         ID=FDCODE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=left   SumBgColor=#C3D0DB sumtext='' EditStyle=Combo Data='02:����,03:�ݰ���,04:����' </C>
					<C> Name='�Ǽ����ڻ��'		 ID=ASTCIPCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left	 SumBgColor=#C3D0DB sumtext='' EditStyle=Lookup Data='gcds_astcipcd_g:CDCODE:CDNAM'</C>
					<C> Name='������'   		 ID=ASTYYMM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  	align=center SumBgColor=#C3D0DB sumtext='' Mask='XXXX/XX' </C>
					<C> Name='�������'   		 ID=ASAQSDAT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  	align=center SumBgColor=#C3D0DB sumtext='' Mask='XXXX/XX/XX' </C>
					<C> Name='�����׸�'        ID=ASTREFCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=left   SumBgColor=#C3D0DB sumtext='' EditStyle=Lookup Data='gcds_astrefcd_g:CDCODE:CDNAM'</C>
					<C> Name='���μ�'		     ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 	align=left	 SumBgColor=#C3D0DB sumtext='��' EditStyle=Popup </C>
					<C> Name='��ȭ'   			   ID=ASTAQAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right  SumBgColor=#C3D0DB sumtext='@sum' </C>
					<C> Name='��ȭ'     		   ID=ASTAQAMTY	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right  SumBgColor=#C3D0DB sumtext='@sum' </C>
					<C> Name='����'		         ID=REMARK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=130  align=left   SumBgColor=#C3D0DB sumtext='' </C>
					<C> Name='����'   		     ID=STATUS  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45   align=left   SumBgColor=#C3D0DB sumtext='' EditStyle=Combo Data='0:������,1:�Ϸ�'</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td colspan=2><BR></td>
  </tr>
</table>

<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr>
		<td width="680px" > <font size="2" color="blue"> <b> [��ü���] </b> </font></td>
		<td align="right" >
			<img src="../../Common/img/btn/com_b_delete.gif"	  style="cursor:hand" onClick="ln_Delete('02')">
			<img src="../../Common/img/btn/com_b_insert.gif"	  style="cursor:hand" onClick="ln_Add('02')">
			<img src="../../Common/img/btn/com_b_save.gif"	    style="cursor:hand" onClick="ln_Save('02')">
			<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onClick="ln_Query('02')">
		</td>
	</tr>
	<tr> 
		<td colspan =2>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			style="position:relative;left:0px;width:858px; height:200px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_data02">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name="Format"		  value=" 
					<C> Name='����'			       ID=FDCODE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=left    EditStyle=Combo Data='02:����,03:�ݰ���,04:����'</C>
					<C> Name='�Ǽ����ڻ��'		 ID=ASTCIPCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left	  EditStyle=Lookup Data='gcds_astcipcd_g:CDCODE:CDNAM'</C>
					<C> Name='�Ϸ���'		     ID=ASTYYMM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  	align=center  Mask='XXXX/XX'</C>
					<G> Name='��ü����'        HeadBgColor=#B9D4DC
						<C> Name='�ڻ��ȣ'			 ID=ASTNBR   	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left	  </C>         
						<C> Name='�ڻ��'        ID=ASTNM 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left    EditStyle=Popup </C>
						<C> Name='������' 			 ID=ATCODE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	  EditStyle=Combo Data='1220200:�ǹ�,1220700:���ⱸ��ǰ,1220300:���๰,1220400:�����ġ,1222100:��Ÿ�����ڻ�,1220600:������ݱ�,1220100:����'</C>
						<C> Name='�������'			 ID=ASAQSDAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=left	  Mask='XXXX/XX/XX' </C>
						<C> Name='��ü��ȭ'			 ID=ASTRAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right   </C>
						<C> Name='��ü��ȭ'	     ID=ASTRAMTY  HeadAlign=Center HeadBgColor=#B9D4DC Width=90  	align=right   </C>
					</G>
					<C> Name='���' 		       ID=REMARK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=left    </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td colspan =2 ><BR></td>
  </tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 