<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	����ī��UPLOAD
+ ���α׷� ID	: P050010.HTML
+ �� �� �� ��	: ��ȸ,����
+ �� �� �� ��	: 
+ �� �� �� ��	: P030013_s1, P030013_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>����ī��UPLOAD</title>
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
//get_cookdata();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2);
var gs_userid = gusrid;
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


  gcem_settdt.text = gs_date;
	ln_SetHeader();
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_End(){
	if (!ln_Chk()) return;
	if (confirm("�ش� ��������� �����Ͻðڽ��ϱ�?")) {	
					gcds_data.UseChangeInfo = false;
					gctr_data.KeyValue = "Payroll.P050010_t3(I:USER=gcds_data)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P050010_t3";
					gctr_data.Parameters = "v_str1=" + gs_userid;
					gctr_data.post();
					gcds_data.UseChangeInfo = true;
				} else gcds_data.UseChangeInfo = true;
			}

/******************************************************************************
	Description : �ݿ�
******************************************************************************/
function ln_Apply(){
	if (!ln_Chk()) return;
				if (confirm("�����͸� �ݿ��Ͻðڽ��ϱ�?")) {
					gcds_data.UseChangeInfo = false;
					gctr_data.KeyValue = "Payroll.P050010_t1(I:USER=gcds_data)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P050010_t1";
					gctr_data.Parameters = "v_str1=" + gs_userid;
					gctr_data.post();

					ln_Query();
			}	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (!ln_Chk()) return;
	else if(gcds_data.UseChangeInfo==false){
				if (confirm("�����͸� �����Ͻðڽ��ϱ�?")) {			
					gctr_data.KeyValue = "Payroll.P050010_t2(I:USER=gcds_data)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P050010_t2";
					gctr_data.Parameters = "v_str1=" + gs_userid;
					gctr_data.post();
				}
		}
}

/******************************************************************************
	Description : UPLOAD
******************************************************************************/
function ln_Upload() {
				if (!ln_Chk()) return;
				ln_SetHeader();
				gcds_data.UseChangeInfo = "false"; 
				tb_InputFile.Open();	  
				gcds_data.DataId = tb_InputFile.Value;
			  gcds_data.Reset();				
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
		var date = fn_trim(gcem_settdt.text);
		var nmk = fn_trim(txt_nmk.value);
		var resino = fn_trim(txt_resino.value);

		gcds_data.UseChangeInfo = "true"; 
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P050010_s1?"																	+"v_str1="+date
		+"&v_str2="+nmk
		+"&v_str3="+resino;
		gcds_data.Reset();

}
/******************************************************************************
	Description : ���� üũ
******************************************************************************/
function ln_Chk(){
	
	  var s = gcds_data.namevalue(1,"SETTDT")
		gcds_enddata.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P050010_s3?v_str1="+s;
		gcds_enddata.Reset();

		if(gcds_enddata.namevalue(1,"CLOSEYN") == 'C'){
			alert("���� �Ǿ����ϴ�");
			return false;
		}

		return true;
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
	Description : �����ȸ 
******************************************************************************/
function ln_FindEmp(e){

	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	arrSend[0]="H050005";
	strURL = "./H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		txt_hdid.value = arrParam[1];
	} else {
		eval(e).value = "";
		txt_hdid.value = "";
	}
}


/******************************************************************************
	Description : ����ȸ����
******************************************************************************/
function ln_Before(){

}

/******************************************************************************
	Description : �������
******************************************************************************/
function ln_SetHeader(){

if (gcds_data.countrow<1){  
		  var s_temp = "SEQID:DECIMAL(5.0),RESINO:STRING(13),EMPNMK:STRING(20),CARDNO:STRING(16),DIVNM:STRING(60),APPNO:STRING(8),APPDT:STRING(8),"
									+"SALEDT:STRING(8),SETTDT:STRING(8),SALAMT:DECIMAL(7.0),CANAMT:DECIMAL(7.0),REQAMT:DECIMAL(7.0),MBERNO:STRING(9),MEMBER:STRING(100),"
									+"MBERRESINO:STRING(10),MBERCD:STRING(4),MBERNM:STRING(100),I_EMPNO:STRING(7),U_EMPNO:STRING(7)";
			gcds_data.SetDataHeader(s_temp);
		}
}

</script>



<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="UseChangeInfo"    value="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_enddata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	////document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
		 
</script>





<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("��û�Ͻ� �۾��� ���������� ������� ���߽��ϴ�.");

	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

	ln_Query();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/P050010_head.jpg"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_end.gif" style="cursor:hand" onclick="ln_End()">
			<img src="../../Common/img/btn/com_b_reflect.gif" style="cursor:hand" onclick="ln_Apply()">
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
      <object id=tb_InputFile classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:absolute;left:305;top=20; width=0; height=0;">
			<param name="Text"		value='ln_Upload'>
			</object>
			&nbsp; <img src="../../Common/img/btn/com_b_upload.gif" style="cursor:hand" onclick="ln_Upload()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
	<tr> 
    <td colspan=2>
			<table width="876" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan=8 align=center>
						<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;border:0 solid #708090;border-top-width:1px;border-left-width:1px'>
							<tr>
								<td class="tab11" width="80px" bgcolor="#eeeeee">�������</td>
								<td width="0" width="100px" class="tab21" align=LEFT onkeydown="if(event.keyCode==13) ln_Query();"><nobr>&nbsp;
									<comment id="__NSID__">
									<object  id=gcem_settdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
									 <param name=Text					value="">
									 <param name=Alignment     value=0>
									 <param name=Border        value=true>
									 <param name=Format        value="YYYY/MM">
									 <param name=PromptChar    value="_">
									 <param name=BackColor     value="#CCCCCC">
									 <param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_settdt', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
										&nbsp;</td>
										<td class="tab11" width="80px" bgcolor="#eeeeee">����</td>
										<td class="tab22" width="80px;"><input type="text" style="width:70px" class="txt11" id=txt_nmk></td>
										<td width="0" class="tab21" align=LEFT ><td class="tab21" width="50px"><input type="hidden" width="0" id="txt_hdid" name="txt_hdid"><nobr><img src="../../Common/img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;cursor:hand;" onclick="ln_FindEmp('txt_nmk')" ></td>
										<td class="tab11" width="80px" bgcolor="#eeeeee">�ֹι�ȣ</td>
											<td width="350" class="tab21" align=LEFT ><nobr><input type="text" style="width:130px" class="txt21" id=txt_resino></td>

							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr> 
    <td colspan="2" align=center valign=center> 
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:100%;" align=center>
						<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;top:2px;">
							<tr> 
								<td style="width:876" align=center>
									<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp  
										style="width:876px;height:437px;border:1 solid #777777;z-index:2;">
										<PARAM NAME="DataID"				VALUE="gcds_data">
			              <PARAM NAME="Editable"			VALUE="True">
						        <PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="Indwidth"			VALUE="0">
										<param name="Fillarea"			VALUE="true">
										<PARAM NAME="SortView"			VALUE="left">
										<PARAM NAME="ColSizing"			VALUE="true">
									  <PARAM NAME="Format"				VALUE="  
	<C> Name='��ȣ'						ID=SEQID		HeadAlign=Center HeadBgColor=#B9D4DC width=50 align=center, bgcolor=#f5f5f5,  Edit=none ,sort=true</C>
	<C> Name='�ֹι�ȣ'				ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=center,	bgcolor=#f5f5f5, Edit=none, Mask=XXXXXX-XXXXXXX, sort=true  </C> 
	<C> Name='����'						ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=left,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
	<C> Name='ī���ȣ'				ID=CARDNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=center,		bgcolor=#f5f5f5, Edit=none, Mask=XXXX-XXXX-XXXX-XXXX, sort=true </C>
  <C> Name='�μ���'					ID=DIVNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left, bgcolor=#f5f5f5, edit=none,sort=true </C>
	<C> Name='���ι�ȣ'				ID=APPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
	<C> Name='��������'				ID=APPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,		bgcolor=#f5f5f5, Edit=none, Mask=XXXX-XX-XX ,sort=true </C>
	<C> Name='����Ȯ������'		ID=SALEDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center,		bgcolor=#f5f5f5, Edit=none, Mask=XXXX-XX-XX ,sort=true </C>
	<C> Name='��������'				ID=SETTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,		bgcolor=#f5f5f5, Edit=none, Mask=XXXX-XX-XX, sort=true </C>
	<C> Name='����ݾ�'				ID=SALAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=right,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
	<C> Name='��ұݾ�'				ID=CANAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=right,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
	<C> Name='û���ݾ�'				ID=REQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=right,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
<G> Name='������'  HeadAlign=Center HeadBgColor=#B9D4DC
	<C> Name='��ȣ'			ID=MBERNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
	<C> Name='��ȣ��'				ID=MEMBER		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
	<C> Name='�����ȣ'	ID=MBERRESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,		bgcolor=#f5f5f5, Edit=none, Mask=XXX-XX-XXXXX , sort=true </C>
	<C> Name='�ڵ�'			ID=MBERCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
	<C> Name='������'		ID=MBERNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left,		bgcolor=#f5f5f5, Edit=none,sort=true </C>
</G>
										">
									</OBJECT></comment><script>__ws__(__NSID__);</script>

									<fieldset style="width:876px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
									</fieldset>
                </td>
       					<td style="padding-left:3px;">

								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
		</td>
	</tr>
</table>



<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	