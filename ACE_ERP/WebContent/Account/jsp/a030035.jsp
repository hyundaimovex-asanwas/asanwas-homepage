<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ���� ������ ��ȸ  - ����Ȯ��
+ ���α׷� ID	: 
+ �� �� �� ��	: ��ȸ
+ �� �� �� ��	: ������
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
+ �� �� �� �� :	 
+ ��   ��  �� :
+ �� �� �� �� :
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>����Ȯ��</title>
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

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_atdecr=""; //�������� 

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
		
	gcem_actdat_fr.text = gs_date2+"01";
	gcem_actdat_to.text = gs_date;
	
}

<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){ 
	//gcem_actyymm.text  = gs_date2;	//ȸ����	
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset(); //�����ڵ�
}

<%
/******************************************************************************
	Description : ��ȸ
	----------------------------------------------------------------------------
    1.�����߻��� ���� �� ( BANJAEMST vs GENENLED )
    2.����MST�� ����ݾװ� ����REL�� �ݾ� �� ��  BANJAEMST vs SUM(BANJAEREL) 
    3.��������� ���� �� ( BANJAEMST vs GENENLED )
******************************************************************************/
%>

function ln_Query(){ 

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030035_s1?v_str1="+gclx_fdcode.bindcolval
													                    +"&v_str2="+gcem_actdat_fr.text
													                    +"&v_str3="+gcem_actdat_to.text
													                    +"&v_str4="+gcem_atcode.text
													                    +"&v_str5="+gs_atdecr;
	gcds_data1.Reset(); 
	
	
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030035_s2?v_str1="+gclx_fdcode.bindcolval
													                    +"&v_str2="+gcem_actdat_fr.text
													                    +"&v_str3="+gcem_actdat_to.text
													                    +"&v_str4="+gcem_atcode.text
													                    +"&v_str5="+gs_atdecr;
	gcds_data2.Reset(); 
	
	
	gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030035_s3?v_str1="+gclx_fdcode.bindcolval
													                    +"&v_str2="+gcem_actdat_fr.text
													                    +"&v_str3="+gcem_actdat_to.text
													                    +"&v_str4="+gcem_atcode.text
													                    +"&v_str5="+gs_atdecr;
	
	prompt('',gcds_data3.DataID);
	gcds_data3.Reset();
	
	
	gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030035_s4?v_str1="+gclx_fdcode.bindcolval
													                    +"&v_str2="+gcem_actdat_fr.text
													                    +"&v_str3="+gcem_actdat_to.text
													                    +"&v_str4="+gcem_atcode.text
													                    +"&v_str5="+gs_atdecr;
	gcds_data4.Reset();
	
}

<%
/******************************************************************************
	Description : �����ٿ�ε�
******************************************************************************/
%>
function ln_Excel(){ 
	//gcgd_data2.GridToExcel("��������","",2);
	gcgd_data3.GridToExcel("����MSTVs����REL","",2);
}

<%
/***********************************************************************************************
	Description : �����ڵ� ã��
	parameter   : p2===> fr, to- �����ڵ� : apr- ���� : up - �������� : down - �����ڵ�
**********************************************************************************************/
%>
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
    arrParam[0]='ATUSEYN';
    arrParam[1]="";
    arrParam[2]="ATDEBTYN";
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode.text = arrResult[0];
		gcem_atkornam.text = arrResult[1];
		gs_atdecr = arrResult[2];
	} else {		
		gcem_atcode.text = "";
		gcem_atkornam.text ="";
		gs_atdecr ="";
	}
	
	//alert("gs_atdecr::"+gs_atdecr);
}

<%
/******************************************************************************
	Description :  ���� ã��
	parameter   : 
******************************************************************************/
%>
function ln_Onblur(){
    var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	//alert("event.keyCode::"+event.keyCode);
  
	if(event.keyCode!=13) return;
    arrParam[0]='ATUSEYN';
	arrParam[1]=gcem_atkornam.text;
	arrParam[2]="ATDEBTYN";
	
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode.text = arrResult[0];
		gcem_atkornam.text = arrResult[1];
		gs_atdecr = arrResult[2];
	} else {
		gcem_atcode.text = "";
		gcem_atkornam.text ="";
		gs_atdecr ="";
	}
	
	//alert("222gs_atdecr::"+gs_atdecr);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ� -->
 </object>

 <object  id="gcds_data1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
 </object>

 <object  id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
 </object>
 
 <object  id="gcds_data3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
 </object>
 
  <object  id="gcds_data4" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
 </object>
 
 </comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="A";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
</script>


<script language="javascript" for="gcds_data1" event=OnLoadStarted()>
    ft_cnt1.innerText = "��ȸ��.... ";
</script>


<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
    ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_data2" event=OnLoadStarted()>
    ft_cnt2.innerText = "��ȸ��.... ";
</script>


<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
    ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_data3" event=OnLoadStarted()>
    ft_cnt3.innerText = "��ȸ��.... ";
</script>


<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
    ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_data4" event=OnLoadStarted()>
    ft_cnt4.innerText = "��ȸ��.... ";
</script>


<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
    ft_cnt4.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030035_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" height="47">&nbsp;
		  <img name="btn_query" src="../../Common/img/btn/com_b_excel.gif"  style="cursor:hand;" onclick="ln_Excel()">&nbsp;
		  <img name="btn_query" src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand;" onclick="ln_Query()">&nbsp;
	</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td width="70px"  class="tab12" bgcolor="#eeeeee"><nobr>�����ڵ�</nobr></td>
					<td width="150px;" class="tab23"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat		value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
					<td width="70px"  class="tab12" bgcolor="#eeeeee"><nobr>ȸ������</nobr></td>
					<td width="200px"  class="tab23"><nobr>&nbsp;<comment id="__NSID__">
					    <object id=gcem_actdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment		  value=0>
							<param name=Border	          value=true>
							<param name=Format	          value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_fr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~					
					<comment id="__NSID__"><object id=gcem_actdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment		 value=0>
							<param name=Border	         value=true>
							<param name=Format	         value="YYYY/MM/DD">
							<param name=PromptChar	 value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_to', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>        
					</td>

					<td width="70px"  class="tab12" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td width="250px;"   ><nobr>&nbsp;<comment id="__NSID__">
						<object id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:5px;" onkeydown="ln_Onblur();">
				            <param name=Text			   value="">
							<param name=Alignment     value=0>
							<param name=Border         value=true>
							<param name=Numeric       value=false>
							<param name=PromptChar  value="">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=false>
							<param name=GeneralEdit   value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:0px" align=center onclick="ln_Popup();">
						<comment id="__NSID__"><object id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px;">
				            <param name=Text			   value="">
							<param name=Alignment     value=0>
							<param name=Border         value=true>
							<param name=Numeric       value=false>
							<param name=Format          value="#######">
							<param name=PromptChar  value="">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>  	     
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="4">

		<!--���հ�-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">
			    <tr><td height=10></td></tr>  
			    <tr>
				    <td height=10>
						<font size="3" color="blue"><b>[����ݾ� Vs ����MST �߻��ݾ�]</b></font>
					</td>
				</tr>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:100;width:875" >
							<PARAM NAME="DataID"		    VALUE="gcds_data1">
							<PARAM NAME="Editable"		    VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		    VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="false"> 
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		    VALUE=" 
							    <C>ID=FDCODE,	Name='����',        width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
							    <C>ID=FSDAT,	    Name='��������', width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
							    <C>ID=FSNBR,	    Name='������ȣ', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
							    <C>ID=FSSEQ,	    Name='����',        width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<C>ID=ATCODE,	Name='�����ڵ�', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<G>Name='��������', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DEAMT,	    Name='����',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#0000FF  sumcolor =#0000FF </C>
								<C>ID=CRAMT,	    Name='�뺯',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#FF0000  sumcolor =#FF0000 </C>
								</G>
								<G>Name='��������', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=M_DEAMT,	Name='����',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#0000FF  sumcolor =#0000FF</C>
								<C>ID=M_CRAMT, Name='�뺯',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#FF0000  sumcolor =#FF0000</C>
								</G>			
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;"></font><font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
				<tr><td height=10></td></tr>
			</table>
			
			<!--������ ��-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">
			  <tr>
					<td height=10>
						<font size="3" color="blue"><b>[����ݾ� Vs ����REL ����ݾ�]</b></font>
					</td>
				</tr>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data2"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:100;width:875" >
							<PARAM NAME="DataID"		    VALUE="gcds_data2">
							<PARAM NAME="Editable"		    VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		    VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		    VALUE=" 
							    <C>ID=FDCODE,	Name='����',        width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
							    <C>ID=FSDAT,	    Name='��������', width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
							    <C>ID=FSNBR,	    Name='������ȣ', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
							    <C>ID=FSSEQ,	    Name='����',        width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<C>ID=ATCODE,	Name='�����ڵ�', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<G>Name='��������', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DEAMT,	    Name='�����հ�',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#0000FF  sumcolor =#0000FF</C>
								<C>ID=CRAMT,	    Name='�뺯�հ�' ,width=120,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#FF0000  sumcolor =#FF0000 </C>
								</G>
								<G>Name='����REL���� ', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=M_DEAMT,	   Name='�����հ�',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#0000FF  sumcolor =#0000FF</C>
								<C>ID=M_CRAMT,    Name='�뺯�հ�',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#FF0000  sumcolor =#FF0000 </C>
								</G>			
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;"></font><font id=ft_cnt2 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
				<tr><td height=10></td></tr>
			</table>
			
			<!--������ ��-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">
			  <tr>
					<td height=10>
						<font size="3" color="blue"><b>[����MST ����ݾ� Vs ����REL ����ݾ�]</b></font>
					</td>
				</tr>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data3"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:100;width:875" >
							<PARAM NAME="DataID"		VALUE="gcds_data3">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
							    <C>ID=FDCODE,	Name='����',        width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
							    <C>ID=FSDAT,	    Name='��������', width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
							    <C>ID=FSNBR,	    Name='������ȣ', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
							    <C>ID=FSSEQ,	    Name='����',        width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<C>ID=ATCODE,	Name='�����ڵ�', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<G>Name='����MST', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DEAMT,	    Name='�����հ�',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#0000FF  sumcolor =#0000FF</C>
								<C>ID=CRAMT,	    Name='�뺯�հ�' ,width=120,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#FF0000  sumcolor =#FF0000</C>
								</G>
								<G>Name='����REL', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=M_DEAMT,	 Name='�����հ�',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#0000FF  sumcolor =#0000FF</C>
								<C>ID=M_CRAMT,  Name='�뺯�հ�',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#FF0000  sumcolor =#FF0000</C>
								</G>			
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;"></font><font id=ft_cnt3 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
				<tr><td height=10></td></tr>
			</table>
			
			<!--������ ��-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">
			  <tr>
					<td height=10>
						<font size="3" color="blue"><b>[ �������� Vs ����REL ������ ]</b></font>
					</td>
				</tr>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data4"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:100;width:875" >
							<PARAM NAME="DataID"		VALUE="gcds_data4">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
							    <C>ID=FDCODE,	Name='����',        width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
							    <C>ID=FSDAT,	    Name='��������', width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
							    <C>ID=FSNBR,	    Name='������ȣ', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
							    <C>ID=FSSEQ,	    Name='����',        width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<C>ID=ATCODE,	Name='�����ڵ�', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB </C>
								<C>ID=SSDAT,	    Name='��ǥ����', width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
							    <C>ID=SSNBR,	    Name='��ǥ��ȣ', width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<G>Name='����ݾ�', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DEAMT,	    Name='�����հ�',width=120, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#0000FF  sumcolor =#0000FF</C>
								<C>ID=CRAMT,	    Name='�뺯�հ�' ,width=120,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB  color =#FF0000  sumcolor =#FF0000</C>
								</G>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;"></font><font id=ft_cnt4 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
				<tr><td height=10></td></tr>
			</table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 