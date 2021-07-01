<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�/���ο��ݰ���
+ ���α׷� ID	: p050005.HTML
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: 
+ �� �� �� ��	: �̼��� - 2005.08.05 - �ҽ� ����
+ �� �� �� ��	: p050005_s1, p050005_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>���ο��ݰ���</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
get_cookdata();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+ "/" + gcurdate.substr(5,2)+ "/" + gcurdate.substr(8,2);
var gs_date3= gcurdate.substr(0,4) + gcurdate.substr(5,2);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	gcem_LASTMON2.Text = gs_date3;
  
	//�Ҽ�����
	gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1="; 
	gcds_dept.Reset();

	//���ο�������
	gcds_select_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1170"; 
	gcds_select_ec03az.Reset();
	
	//���ݱ������
	gcds_select_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1171"; 
	gcds_select_ec04az.Reset();

	gcem_emo_1.Enable=false;
	txt_empnmk_1.disabled=true;
	img_1.disabled=true;
	gcem_FRDT.Enable=false;
	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	var str1 = fn_trim(gclx_select_ec02az.BindColVal);        //���豸��
	var str2 = fn_trim(txt_empnmk_search.value);							//���س��
	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050005_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str4=" + gcem_LASTMON2.Text;				//�������Կ�
	gcds_grid_ec01az.Reset(); //�׸���
	gcds_grid_ec01az.rowposition=1;
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Insert(){   //���ο���
   if(gcds_grid_ec01az.countRow==0)  {
		var THeader =   "DEPTNM:String(50),"	   /* �Ҽ� */      
						+"EMPNO:String(7),"   	  /*���*/        
						+"EMPNMK:String(20),"     /*����*/         
						+"FRDT:String(8),"				/*������*/       
						+"TODT:String(8),"				/*������*/ 
						
						+"DIV:String(4),"					/*�����ڵ�*/  
						+"DIVNM:String(30),"			/*��������*/     
						+"INSUR:String(4),"   	  /*�������*/      
						+"INSURNM:String(30),"	  /*��������̸�*/ 
						+"TOTDAY:String(10),"	    /*�Ѻ��ԱⰣ*/ 

						+"TOTCNT:Decimal(5),"	    /*����Ƚ��*/   
						+"PERAMT:Decimal(9),"			/*ȸ��δ�*/     
						+"SUPAMT:Decimal(9),"	    /*����*/   
						+"TOTAMT:Decimal(12),"	  /*�����*/      
						+"LASTMON:String(6),"			/*�������Կ�*/  

						+"RESINO:String(13)";			/*�ֹι�ȣ*/  

		gcds_grid_ec01az.DataID = "";
		gcds_grid_ec01az.SetDataHeader(THeader);
	}
	gcds_grid_ec01az.addRow();

	gcem_emo_1.Enable=true;
	txt_empnmk_1.disabled=false;
	img_1.disabled=false;
	gcem_FRDT.Enable=true;

	gcem_emo_1.Focus();
	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (gcds_grid_ec01az.IsUpdated) {
		if (confirm("����� ������ �����Ͻðڽ��ϱ�?")) {
			gctr_grade1.KeyValue = "p050005_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050005_t1";
			gctr_grade1.post();
			ln_Query();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Del(){
	if (gcds_grid_ec01az.countrow >0) {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
			gcds_grid_ec01az.deleterow(gcds_grid_ec01az.rowposition);
			gctr_grade1.KeyValue = "p050005_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050005_t1";
			gctr_grade1.post();
			ln_Query();
		}
	}
}

/******************************************************************************
	Description : �����ȸ
******************************************************************************/
function ln_FindEmp(e,e2){
	if(e2=='2')	{   
		var str1=fn_trim(gcem_emo.Text);
		gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s1?"+ "v_str1=" + str1;
		gcds_select_ec01az.Reset();
	}	else	{
		var arrResult	= new Array();
		var arrSend	= new Array();
        arrSend[0]='P040001';
		window.dialogArguments=arrSend[0];
		var strURL;	
		var strPos;
		strURL = "./H030003_popup.jsp"
		//strURL = "P040001_popup.html"
		strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_emo_1.Text = arrParam[0];				// ���
			txt_empnmk_1.value = arrParam[1];			//����
			hid_deptnm_1.value = arrParam[3];			//�ҼӸ�
			hid_resino_1.value = arrParam[9];			// �ֹι�ȣ
			gcem_emo_1.Focus();		
		} else {
			gcem_emo_1.Text = "";     // ���
			txt_empnmk_1.value = "";  //����
			hid_deptnm_1.value = "";  //�ҼӸ�
			hid_resino_1.value = "";  // �ֹι�ȣ
		}
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(Obj){
	if(Obj=="gcgd_create")	{
		document.all.gcgd_create.style.display="block";
		document.all.div_create.style.display="block";
		document.all.gcgd_select.style.display="none";
		document.all.div_select.style.display="none";
	}	else	{
    document.all.gcgd_create.style.display="none";
		document.all.div_create.style.display="none";
		document.all.gcgd_select.style.display="block";
		document.all.div_select.style.display="block";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_ec03az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_ec04az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_pyo" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
</object></comment><script>__ws__(__NSID__);</script>

<!------------------------------------------------------------------------------

	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
---------------------------------------------------------------------------- -->
<comment id="__NSID__"><OBJECT id="gctr_grade1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
    gcds_dept.NameValue(1,"DEPTCD")="";
    gcds_dept.NameValue(1,"DEPTNM")="��ü";
    gclx_select_ec02az.index=0;
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_select_ec03az" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec03az" event="onloadCompleted(row,colid)">
	gcds_select_ec03az.InsertRow(1);
	gcds_select_ec03az.NameValue(1,"MINORCD")="";
	gcds_select_ec03az.NameValue(1,"MINORNM")="";
	gclx_select_ec03az.index=0;
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_select_ec04az" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec04az" event="onloadCompleted(row,colid)">
	gcds_select_ec04az.InsertRow(1);
	gcds_select_ec04az.NameValue(1,"MINORCD")="";
	gcds_select_ec04az.NameValue(1,"MINORNM")="";
	gclx_select_ec04az.index=0;
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="����Ÿ ��ȸ�� �Ϸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_grid_ec01az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnRowPosChanged(row)">
	if(gcds_grid_ec01az.rowStatus(row) ==1)	{
		gcem_emo_1.Enable=true;
		txt_empnmk_1.disabled=false;
		img_1.disabled=false;
		gcem_FRDT.Enable=true;
	}	else	{
		gcem_emo_1.Enable=false;
		txt_empnmk_1.disabled=true;
		img_1.disabled=true;
		gcem_FRDT.Enable=false;
	}
</script>

<script language=JavaScript for= gclx_select_ec03az event=OnSelChange()>
	gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"DIVNM")=gclx_select_ec03az.Text;
</script>

<script language=JavaScript for= gclx_select_ec04az event=OnSelChange()>
	gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"INSURNM")=gclx_select_ec04az.Text;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_grade1" event="OnSuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	//ln_Query();
</script>

<script language="javascript" for="gctr_grade1" event="OnFail()">
	alert("�ߺ��� ����Ÿ �Է����� ������ �߻��߽��ϴ�.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/p050005_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del()">
			<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Insert()" >
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" style="width:70px;border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee" align=center><nobr>&nbsp;�Ҽ�&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM">
					<param name=BindColumn			value="DEPTCD">
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>  
      <td width="10" style="width:70px;border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee" align=center><nobr>&nbsp;����&nbsp;</nobr></td>
			<td><nobr><INPUT id="txt_empnmk_search" class="txt21" TYPE=TEXT STYLE="width:80px;" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td>
			<td width="10" style="border:0 solid #708090;border-right-width:1px;">&nbsp;</td>
			<td style="width:100px;height:22px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align=center>�������Կ�</td>
			<td><nobr>
				<comment id="__NSID__"><object id=gcem_LASTMON2  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:50px; height:18px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</td>
			<td width="45%" style="border:0 solid #708090;border-right-width:0px;"><nobr></nobr></td>
		</tr>
	</table>		
		</td>
	</tr>
  <tr> 
  <td height=3></td>
  </tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create style="WIDTH: 608px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
							<PARAM NAME="Editable"		VALUE="False">
							<PARAM NAME="ColSizing"		VALUE="True">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�Ҽ�'				ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=LEFT		</C> 
								<C> Name='���'				ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	</C> 
								<C> Name='����'				ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center	</C> 
								<C> Name='���ݸ�'			ID=DIVNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		</C> 
								<C> Name='�������'		ID=INSURNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=103  align=LEFT		</C> 
								<C> Name='�Ѻ��ԱⰣ' ID=TOTDAY  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=RIGHT		</C> 
								<C> Name='����Ƚ��'		ID=TOTCNT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		</C> 
								<C> Name='ȸ��δ�'		ID=PERAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		</C> 
								<C> Name='����'				ID=SUPAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		</C> 
								<C> Name='�����'			ID=TOTAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		</C> 
								<C> Name='�������Կ�' ID=LASTMON  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=CENTER  Mask='XXXX/XX' </C> 
								<C> Name='�ֹι�ȣ'		ID=RESINO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  Mask='XXXXXX-XXXXXXX'	align=CENTER  </C> 
								<C> Name='������'			ID=FRDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		Mask='XXXX/XX/XX' 		align=CENTER  </C> 
								<C> Name='������'			ID=TODT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		Mask='XXXX/XX/XX' 		align=CENTER  </C> 
       					">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width: 610px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
					</td>
					<td width=3></td>
					<td>
            <table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:259px;height:442px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
                <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;���&nbsp;</nobr></td>
                <td  Style="height:23px;border:0 solid #708090;border-bottom-width:1px"><nobr>
									<comment id="__NSID__"><object id=gcem_emo_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="0000000">
										<param name=MaxLength     value=13>
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=Readonly  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
								<td style="padding-top:0px;padding-left:0px; border:0 solid #708090;border-bottom-width:1px;"><nobr><img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand" onclick="ln_FindEmp('1','1')" ></nobr></td>
								<td width="100%" Style="border:0 solid #708090;border-bottom-width:1px;padding-top:1px;"><nobr><input id="txt_empnmk_1" name="txt_empnmk_1" type="text" class="txt21" style="width:75px;" maxlength=7 readonly>&nbsp;&nbsp;</nobr></td>						
              </tr>
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;������&nbsp;</nobr></td>
								<td colspan=3 style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>
									<comment id="__NSID__"><object id=gcem_FRDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=MaxLength     value=8>
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
              </tr>
							<tr>
                <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;������&nbsp;</nobr></td>
								<td colspan=3 style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
									<comment id="__NSID__"><object id=gcem_TODT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=MaxLength     value=8>
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
              </tr>
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;���ݸ�&nbsp;</nobr></td>
                <td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
									<comment id="__NSID__"><object id=gclx_select_ec03az  name="gclx_select_ec03az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:70px;height:200px;">
										<param name=ComboDataID			value=gcds_select_ec03az>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
								</td> 
              </tr>
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�������&nbsp;</nobr></td>
								<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
									<comment id="__NSID__"><object id=gclx_select_ec04az  name="gclx_select_ec04az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:70px;height:200px;">
										<param name=ComboDataID			value=gcds_select_ec04az>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
								</td> 
              </tr>
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�Ѻ��ԱⰣ&nbsp;</nobr></td>
								<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
									<comment id="__NSID__"><object id=gcem_TOTDAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=True>
										<param name=MaxLength     value=5>
										<param name=GeneralEdit	value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
              </tr>
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����Ƚ��&nbsp;</nobr></td>
								<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
									<comment id="__NSID__"><object id=gcem_TOTCNT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value="4">
										<param name=PromptChar	  value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
              </tr>
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;ȸ��δ�&nbsp;</nobr></td>
								<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
									<comment id="__NSID__"><object id=gcem_PERAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="9,999,999">
										<param name=MaxLength     value=7>
										<param name=PromptChar	  value="">
										<param name=IsComma	      value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
              </tr>
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;</nobr></td>
								<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
									<comment id="__NSID__"><object id=gcem_SUPAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="9,999,999">
										<param name=MaxLength     value=7>
										<param name=PromptChar	  value="">
										<param name=IsComma	      value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
              </tr>					
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�����&nbsp;</nobr></td>
								<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
									<comment id="__NSID__"><object id=gcem_TOTAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="9,999,999">
										<param name=MaxLength     value=7>
										<param name=PromptChar	  value="">
										<param name=IsComma	      value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
              </tr>					
							<tr>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;�������Կ�&nbsp;</nobr></td>
								<td colspan=3 style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
									<comment id="__NSID__"><object id=gcem_LASTMON classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	  value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
							</tr>
							<tr>
                <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
              </tr>
              <tr>
                <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
							</tr>
							<tr>
                <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
              </tr>
              <tr>
                <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
              </tr>
              <tr>
                <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
              </tr>
						</table>
  				</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<input type=hidden id=hid_deptnm_1 name=hid_deptnm_1>
<input type=hidden id=hid_resino_1 name=hid_resino_1>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_grid_ec01az classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_grid_ec01az>
	<param name=BindInfo  value='
		<C>Col=DEPTNM			Ctrl=hid_deptnm_1							Param=value</C>
		<C>Col=EMPNO			Ctrl=gcem_emo_1								Param=Text</C>
		<C>Col=EMPNMK			Ctrl=txt_empnmk_1							Param=value</C>
		<C>Col=DIV				Ctrl=gclx_select_ec03az       Param=BindColVal</C>
		<C>Col=DIVNM			Ctrl=gclx_select_ec03az       Param=Value</C>
		<C>Col=INSUR			Ctrl=gclx_select_ec04az       Param=BindColVal</C>
		<C>Col=INSURNM		Ctrl=gclx_select_ec04az       Param=Value</C>
		<C>Col=FRDT				Ctrl=gcem_FRDT								Param=Text</C>
		<C>Col=TODT				Ctrl=gcem_TODT								Param=Text</C>
		<C>Col=PERAMT			Ctrl=gcem_PERAMT							Param=Text</C>
		<C>Col=SUPAMT			Ctrl=gcem_SUPAMT							Param=Text</C>
		<C>Col=TOTDAY			Ctrl=gcem_TOTDAY							Param=Text</C>
		<C>Col=TOTCNT			Ctrl=gcem_TOTCNT							Param=Text</C>
		<C>Col=TOTAMT			Ctrl=gcem_TOTAMT							Param=Text</C>
		<C>Col=LASTMON		Ctrl=gcem_LASTMON							Param=Text</C>
		<C>Col=RESINO			Ctrl=hid_resino_1							Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	