<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ���ݰ�꼭��� ( ����  ) 	
+ ���α׷� ID	:  com_tax_list1_A.jsp
+ �� �� �� ��	:  (����)��꼭��� �˾�
+ ��   ��  �� :  ������
+ �� �� �� �� :  2017.10.26
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<title>����(����)��꼭���</title>

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
var parentGubun="";
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
	//�Ķ���� �Ѱܹ���.
	var strParam = new Array();
	strParam=window.dialogArguments;

	ln_Before();
	gclx_taxiodiv.bindcolval="A";
	gclx_documcd.bindcolval = strParam[0]; //��������

	ln_Query();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
    var strGubun="";
	var strSabun="";

	//������� ��ü��ȸ
	//������ �����θ� ��ȸ����
    if(gs_userid=="2050053"||gs_userid=="6070001" ){
		strSabun="A";
	}else{
    	strSabun=gs_userid;
	}
	
	if(strSabun=="null"||strSabun==""){
		alert("��� ������ �������� �ʽ��ϴ�. �α����� �ٽ� �Ͻʽÿ�");
		return false;
	}
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>com_tax_list1_s1_a?v_str1="+gcem_vendnm.text
	                                                                              +"&v_str2="+gcem_taxdat_fr.text
																				  +"&v_str3="+gcem_taxdat_to.text
																				  +"&v_str4="+gcem_remark.text
																				  +"&v_str5="+gclx_taxiodiv.bindcolval
																				  +"&v_str6="+gclx_documcd.bindcolval
																				  +"&v_str7="+strGubun
																				  +"&v_str8="+strSabun;
    //prompt("",gcds_code01.DataID);
	gcds_code01.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����ä�
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : ������
******************************************************************************/
function ln_Before(){ 
    gcem_taxdat_fr.text = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";				//��꼭�Ⱓ �� ��
	gcem_taxdat_to.text = gs_date;	 //��꼭�Ⱓ �� ��
	gcds_documcd.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0052&v_str2=01";
	gcds_documcd.Reset();

}

/***********************************************************************************************
	Description : �ŷ�ó ã��
	parameter   :
**********************************************************************************************/
function ln_Popup(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_vendnm.text = arrParam[1];
		gcem_vendcd.text = arrParam[0];
	} else {
		gcem_vendnm.text = "";
		gcem_vendcd.text = "";
	}
}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		if(gcds_code01.countrow<1) {
			alert("�����Ͻ� �ŷ�ó�� �����ϴ�.");
		}else{

			var row = gcds_code01.rowposition;
			var strTemp="";
			var strDouc=gclx_documcd.bindcolval;
			var strDouc_blank="000";
			
			if(gcds_code01.namevalue(row,"FSNBR")!=""){
				alert("��ǥ�� �̹� ����� ��꼭�� ������ �� �����ϴ�.");
				return;
			}
			
			
			strTemp += gcds_code01.namevalue(row,"TAXNBR")+";"
			strTemp += gcds_code01.namevalue(row,"TAXSUM")+";"
			strTemp += gcds_code01.namevalue(row,"TAXVATAMT")+";"
			strTemp += gcds_code01.namevalue(row,"VEND_CD")+";"
			strTemp += gcds_code01.namevalue(row,"VEND_ID")+";"
			strTemp += gcds_code01.namevalue(row,"VENDNM")+";"
			strTemp += gcds_code01.namevalue(row,"VEND_ID_LEN");
			

			
			/**
			ln_Query2(gcds_code01.namevalue(row,"TAXNBR"));
		
			//�����ڵ�, ������, �ŷ�ó�ڵ�, �ŷ�ó��, �μ��ڵ�, �μ���,
            //���� , �����ݾ�, �뺯�ݾ�(�ݺ�), ��꼭��ȣ, �����ڵ�
			//�����ڵ�, ��꼭����
			for(i=1;i<=gcds_data.countrow;i++){
			  if(i>1)strTemp+=";"
				strTemp += gcds_data.namevalue(i,"ATCODE")+";"
				strTemp += gcds_data.namevalue(i,"ATKORNAM")+";"
				strTemp += gcds_data.namevalue(i,"VEND_CD")+";"
				strTemp += gcds_data.namevalue(i,"VEND_NM")+";"
				strTemp += gcds_data.namevalue(i,"DEPTCD")+";"
				strTemp += gcds_data.namevalue(i,"DEPTNM")+";"
				strTemp += gcds_data.namevalue(i,"REMARK")+";"
				strTemp += gcds_data.namevalue(i,"CHAAMT")+";"
				strTemp += gcds_data.namevalue(i,"DAEAMT")+";"
				strTemp += gcds_data.namevalue(i,"TAXNBR")+";"
				
				if(i==1){
					strTemp += strDouc_blank+";"
				}else{
					strTemp += strDouc+";"
				}
				
				strTemp += gcds_data.namevalue(i,"DIVCD")+";"
				strTemp += gcds_data.namevalue(i,"TAXDAT")
				//alert("TAXDAT"+gcds_data.namevalue(i,"TAXDAT"));
			}

			///prompt("strTemp",strTemp);
            */
			
            //��꼭��ȣ, ���ް���, �ΰ�����, ��ü�ݾ�, �ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó ����ڹ�ȣ /////////���¹�ȣ�� ������ ��������....
            
            //prompt("strTemp",strTemp);
			
			window.returnValue = strTemp;
			window.close();
		}
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_documcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �α��� �μ� üũ -->
<comment id="__NSID__"><object  id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
	<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:870px;border:1 solid #708090">
			<tr>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center">���Ը��ⱸ��</td>
					<td class="tab21" style="width:230px"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gclx_taxiodiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:3px;font-size:12px;width:100px;">
							<param name=CBData				value="^��ü,A^����,B^����">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
							<param name=Enable              value=false>
 						</object></comment><script>__ws__(__NSID__);</script> &nbsp;
					</td>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center" width="110">��������</td>
					<td class="tab22"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gclx_documcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:3px;font-size:12px;width:120px;">
						    <param name=ComboDataID      value="gcds_documcd">
							<param name=CBDataColumns	 value="CDCODE,CDNAM">
							<param name=SearchColumn	 value=CDNAM>
							<param name=Sort			 value=false>
							<param name=ListExprFormat   value="CDNAM^0^120">								
							<param name=BindColumn		 value="CDCODE">
							<param name=index			 value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
						&nbsp;&nbsp;&nbsp;&nbsp;
						<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;left:120px;top:2px;cursor:hand" onclick="ln_Query()"></nobr>
						</td>
				</tr>
				
				<tr>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center">�ŷ�ó</td>
					<td class="tab21" style="width:230px"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:-3px;top:0px" align=center onclick="ln_Popup();">&nbsp;
						<comment id="__NSID__"><object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:0px;top:3px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td width="90" class="tab11" bgcolor="#eeeeee" align="center" width="110">��������</td>
					<td class="tab22"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_taxdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox" onkeydown="if(event.keyCode==13) ln_Query();">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM/DD">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxdat_fr', 'Text')" style="position:relative;width:20px;left:3px;top:0px;cursor:hand;">
            			&nbsp;~&nbsp;&nbsp;
						<comment id="__NSID__"><object  id=gcem_taxdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox" onkeydown="if(event.keyCode==13) ln_Query();">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM/DD">
							<param name=PromptChar		    value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxdat_to', 'Text')" style="position:relative;width:20px;left:3px;top:0px;cursor:hand;">
						
						</td>
				</tr>
				<tr>
					<td width="90" class="tab12" bgcolor="#eeeeee" align="center">����</td>
					<td class="tab23" style="width:650px" colspan=3>&nbsp;
						<comment id="__NSID__"><object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:650px;height:20px;position:relative;left:0px;top:3px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
			<tr>
			<td  class="tab21" colspan="3">
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:868;height:300px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
					<PARAM NAME="DataID"		VALUE="gcds_code01">
					<PARAM NAME="BorderStyle"   VALUE="0">
					<PARAM NAME="Indwidth"		VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<param name="ColSizing"     value="true">
					<param name="sortview"      value=left>
					<PARAM NAME="Format"		VALUE="  
					    <C>ID=GUBUN,		 Name=����,	       width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false, show=false</C>
						<C>ID=CDNAM,		 Name=����,	       width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false</C>
						<C>ID=TAXNBR,	     Name=��꼭��ȣ,	   width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true, mask='XXXXXXX-XXXX'</C>
						<C>ID=TAXDAT,		 Name=��꼭����,	   width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true, mask='XXXX/XX/XX'</C>
						<C>ID=VEND_ID,		 Name=����ڹ�ȣ,	   width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   sort = true  mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</C>
						<C>ID=VENDNM,		 Name=�ŷ�ó��,	   width=140,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true </C>
						<C>ID=REMARK,		 Name=����,	       width=180,   HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left              </C>
						<C>ID=TAXSUM,	     Name=���ް���,	   width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sort = true</C>
						<C>ID=TAXVATAMT,     Name=�ΰ���,	       width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sort = true</C>
						<C>ID=SUMS,	         Name=�հ�,	       width=82,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sort = true</C>
					">

				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
			<td>
				<fieldset id=ft_div1 style="width:870;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 