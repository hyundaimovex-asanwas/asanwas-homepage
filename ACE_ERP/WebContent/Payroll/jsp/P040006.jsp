<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�/�����ݳ�������
+ ���α׷� ID	: p040006.HTML
+ �� �� �� ��	: ��ȸ
+ �� �� �� ��	: 
+ �� �� �� ��	: �̼��� - 2005.08.03 - �ҽ� ����
+ �� �� �� ��	: p040006_s1
------------------------------------------------------------------------------>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>  
<title>�����ݳ�������</title>
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

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	
	gcem_jigub11.Text=gs_date;
	gcem_jigub12.Text=gs_date;

  gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1="; //�Ҽ�����
	gcds_dept.Reset();

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	var str1=fn_trim(nwgubn.value);				//�����,1- �Ի���,2
	var str2=fn_trim(gcem_jigub11.Text);	//�������ں���
	var str3=fn_trim(gcem_jigub12.Text);	//�������ڱ���
	var str4=fn_trim(gclx_select_ec02az.BindColVal); //�ҼӸ�
	var str5=fn_trim(gcem_emo.Text);			//���

	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040006_s1?"
												 + "v_str1=" + str1
												 + "&v_str2=" + str2
												 + "&v_str3=" + str3
												 + "&v_str4=" + str4
												 + "&v_str5=" + str5;
	gcds_grid_ec01az.Reset();

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	
	gcds_pyo.addrow();
	//ln_format('B');
	//txt_usrid.focus();
	gcds_pyo.namevalue(gcds_pyo.rowposition,"WRID") = gusrid;
	gcds_pyo.namevalue(gcds_pyo.rowposition,"WRDT") = gs_date;
	
}

/******************************************************************************
	Description : �����ȸ
******************************************************************************/
function ln_FindEmp(e,e2){
  if(e2=='2') {   
		var str1=fn_trim(gcem_emo.Text);
		
		gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s1?"+ "v_str1=" + str1;
		gcds_select_ec01az.Reset();
	}else	{
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
			gcem_emo.Text = arrParam[0];     // ���
			txt_name.value = arrParam[1];    //����
		} else {
			gcem_emo.Text ="";     // ���
			txt_name.value = "";    //����
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
<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �Ҽӱ��� DataSet-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���� ��� DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="��ü";
	gclx_select_ec02az.index=0; //�Ҽӱ���
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	window.status="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	//window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)	{
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}	else 	{
    //gcem_payavg.Text=(gcds_grid_ec01az.Sum(6,0,0)/3)+"";  //�޿����
		//ln_Sang();
	}
</script>

<script language=JavaScript for=gcem_emo event=OnKeyDown(kcode,scode)>
 if(kcode==13)  {
	if(gcem_emo.Text== "")	{
		alert("����� ��Ȯ�� �Է����ּ���");
		gcem_emo.Focus();
	}else	{
		ln_FindEmp('gcem_emo','2')
	}
}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" >

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/p040006_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			 <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
		  <td width="10" style="border:0 solid #708090;border-right-width:1px; "  bgcolor="#eeeeee">
				<nobr>&nbsp;����&nbsp;</nobr></td>
      <td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<SELECT id="nwgubn" name="nwgubn" STYLE="WIDTH:70;">
    			<OPTION  Value="1">�����</OPTION>
	    		<OPTION  Value="2">������</OPTION>
	      </SELECT>&nbsp;</nobr>
			</td>  
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
				<nobr>&nbsp;��������&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_jigub11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				style="position:relative; left:2px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
				validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
			  </object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub11', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr></td> 
			<td><nobr>&#45;</nobr></td> 
			<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_jigub12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				style="position:relative; left:2px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1
				validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
			  </object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub12', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr></td> 
      <td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:1px;><nobr>&nbsp;<INPUT TYPE=TEXT STYLE="width:60px; " readonly>&nbsp;</nobr></td> 
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM^0^130">
					<param name=BindColumn			value="DEPTCD">
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>   
			<td width="10" style="border:0 solid #708090;border-right-width:1px; "  bgcolor="#eeeeee"><nobr>&nbsp;���&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:0px; "><nobr>
				<comment id="__NSID__"><object id=gcem_emo  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
			style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
			validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="0000000">
					<param name=MaxLength     value=13>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Readonly  value=false>
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td> 
			<td  Style="height:23px;  border:0 solid #708090;border-right-width:0px;border-bottom-width:0px"><nobr><IMG SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�˾�â���� ������ �˻��մϴ�" onclick="ln_FindEmp('gcem_emo','gcem_taeyeil')" style="cursor:hand;" align=center >&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:0px; "><nobr>&nbsp;<input id=txt_name name=txt_name type=text class="txt21" size=10 READONLY>&nbsp;</nobr></td> 					
				<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
		</tr>
	</table>		
		</td>
	</tr>
	<tr><td height=3></td></tr>  
	<tr><td COLSPAN=2></td></tr>
  <tr> 
    <td colspan=2> 
      <table width="870" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="border-bottom-width:0px;" >
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec01az  style="WIDTH: 875px; HEIGHT: 428px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"					VALUE="gcds_grid_ec01az">
							<PARAM NAME="Editable"        VALUE="false">
							<PARAM NAME="BorderStyle"     VALUE="0">
							<param name="Fillarea"				VALUE="true">
							<param name="viewSummary"			VALUE="1">
							<PARAM NAME="Format"					VALUE="  
								<FC>Name='���'					ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 BgColor='#f5f5f5' SumText='�հ�' SumBgColor=#C3D0DB align=center  </FC> 
								<FC>Name='����'					ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 BgColor='#f5f5f5' SumText='' SumBgColor=#C3D0DB  </FC> 
								<F> Name='�Ҽ�'					ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=110 BgColor='#f5f5f5'  SumText='' SumBgColor=#C3D0DB       </F> 
								<C> Name='�Ի���'				ID=STRTDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 Mask='XXXX/XX/XX' SumText='' align=center SumBgColor=#C3D0DB </c>
								<C> Name='�����'				ID=ENDDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 Mask='XXXX/XX/XX' align=center SumText='' SumBgColor=#C3D0DB </C> 
								<C> Name='�����޿���'		ID=PAYDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90 Mask='XXXX/XX/XX'  align=center SumText='' SumBgColor=#C3D0DB </C> 
								<C> Name='������������' ID=RETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=85 Mask='XXXX/XX/XX' align=RIGHT   SumText='' SumBgColor=#C3D0DB </C> 
								<C> Name='��ձ޿�'			ID=AVGAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 SumText=@sum SumBgColor=#C3D0DB </C>
								<C> Name='�������'			ID=AVGETC  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 align=RIGHT Edit=Numeric  SumText=@sum SumBgColor=#C3D0DB</C> 
								<C> Name='�������'			ID=AVGYER  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 SumText=@sum SumBgColor=#C3D0DB</C>
								<C> Name='�����'			ID=AVGBOS  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 align=RIGHT Edit=Numeric   SumText=@sum SumBgColor=#C3D0DB</C> 
								<C> Name='������'				ID=JUSRET  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 SumText=@sum SumBgColor=#C3D0DB </C>
								<C> Name='�����հ�'			ID=S93000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 align=RIGHT Edit=Numeric SumText=@sum SumBgColor=#C3D0DB </C> 
								<C> Name='�����ҵ漼'		ID=T23000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 SumText=@sum SumBgColor=#C3D0DB </C>
								<C> Name='�����ֹμ�'		ID=T24000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 align=RIGHT Edit=Numeric  SumText=@sum SumBgColor=#C3D0DB </C> 
								<C> Name='�������޾�'		ID=S94000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85 SumText=@sum SumBgColor=#C3D0DB    </C> 
								">
             </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
					</td>
					<td width=3></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>