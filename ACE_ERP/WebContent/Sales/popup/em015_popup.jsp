<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �λ���� - �ް����� - �ް������ ��ȸ
+ ���α׷�ID : em014_popup.jsp
+ ������� : �ް�����ڸ� ��ȸ�Ͽ� �����Ѵ�.
+ �� �� �� : ������ 
+ �ۼ����� : 2008.01.02
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em014_S1_Pop
----------------------------------------------------------------------------------*/
%>

<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());			
%>

<!-- HTML ����-->
<html>
<head>
<title>[�ް������ ��ȸ]</title>
<jsp:include page="/Sales/common/include/head.jsp"/>

<script language="javascript">

get_cookdata();

//���ÿ��� ����ϱ� ���� ���Ƿ� ����.
/*
	var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7);
	var gs_date2 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
*/
    var gs_date2 ='<%=firstday%>';
    var gs_date1 =gs_date2.substring(0,6);
    
    var opener = window.dialogArguments;

/*----------------------------------------------------------------------------
 Description : ������ �ε�
----------------------------------------------------------------------------*/

function ln_Start(){
	ln_before();
}
/*----------------------------------------------------------------------------
 Description : ��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

	if(!ln_Query_Chk()) return;

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em015_S1_Pop?"
											+"v_str1=" + txt_empno.value
											+"&v_str2="+ txt_empnmk.value
											+"&v_str3="+ gs_date1
											+"&v_str4="+ chk_s.value;
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


/*----------------------------------------------------------------------------
 Description : ��ȸ�� �ʼ��׸�üũ (�ް��������)
----------------------------------------------------------------------------*/
function ln_Query_Chk(){

  /*
	if(fn_trim(gcem_start_dt.text)==""||fn_trim(gcem_end_dt.text)==""){
		alert("�ް�������ڴ� �ʼ��׸��Դϴ�.");
		return false;
	}

  if(fn_trim(gcem_start_dt.text).length!=8||fn_trim(gcem_end_dt.text).length!=8){
		alert("�ް�������ڸ� ��Ȯ�ϰ� �Է��Ͻʽÿ�.");
		return false;
	}
	*/

	return true;
}
/*----------------------------------------------------------------------------
 Description : ��ȸ
----------------------------------------------------------------------------*/
function ln_before(){
	 //gcem_start_dt.text = gs_date1;
   //gcem_end_dt.text = gs_date2;
	 //�ټӳ���  
	 gcds_cm017.DataID="<%=dirPath%>/servlet/sales.em.Em_com_s1?v_str1=CM017";
	 gcds_cm017.Reset();
}

/*----------------------------------------------------------------------------
	Description : ���ã��
----------------------------------------------------------------------------*/
function ln_Find(){//������ȸ

  var arrParam	= new Array();
	var strURL   = "../em/Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_empno.value = arrParam[0];
		txt_empnmk.value = arrParam[1];
	} else {
		txt_empno.value = "";
		txt_empnmk.value = "";
	}
}


/*----------------------------------------------------------------------------
 Description : â�ݱ�
----------------------------------------------------------------------------*/
function ln_Close() {
  var strRow="";
	var cnt=0;

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(cnt==0){ //���ʰ�
				strRow = gcds_data.namevalue(i,"EMPNO")+":"+gcds_data.namevalue(i,"EMPNMK")+":"+gcds_data.namevalue(i,"DEPT_CD")+":"+gcds_data.namevalue(i,"DEPTNMK")+":"+gcds_data.namevalue(i,"TEAM_CD")+":"+gcds_data.namevalue(i,"TEAMNMK")+":"+gcds_data.namevalue(i,"VEND_CD")+":"+gcds_data.namevalue(i,"WORK_CD")+":"+gcds_data.namevalue(i,"SEQ")+":"+gcds_data.namevalue(i,"CUST_SID")+":"+gcds_data.namevalue(i,"REWARD_YM");
				cnt+=1;
			}else{
        strRow = strRow+";"+gcds_data.namevalue(i,"EMPNO")+":"+gcds_data.namevalue(i,"EMPNMK")+":"+gcds_data.namevalue(i,"DEPT_CD")+":"+gcds_data.namevalue(i,"DEPTNMK")+":"+gcds_data.namevalue(i,"TEAM_CD")+":"+gcds_data.namevalue(i,"TEAMNMK")+":"+gcds_data.namevalue(i,"VEND_CD")+":"+gcds_data.namevalue(i,"WORK_CD")+":"+gcds_data.namevalue(i,"SEQ")+":"+gcds_data.namevalue(i,"CUST_SID")+":"+gcds_data.namevalue(i,"REWARD_YM");
			}
		}
	}
	
  window.returnValue = strRow
  window.close();

 /*
 if (e=="A") {
  var row = gcds_data.rowposition;
  window.returnValue =  gcds_data.namevalue(row,"CUST_NM") + ";"+ gcds_data.namevalue(row,"CUST_SID");
  window.close();
 } else {
  window.close();
 }
 */

}
/*----------------------------------------------------------------------------
 Description : â�ݱ�
----------------------------------------------------------------------------*/
function ln_Select() {
 /*
 if (gcds_data.countrow>1) {
  var row = gcds_data.rowposition;
   window.returnValue =  gcds_data.namevalue(row,"CUST_NM")
									+ ";"+ gcds_data.namevalue(row,"CUST_SID")
									+ ";"+ gcds_data.namevalue(row,"BIRTHDAY")
									+ ";"+ gcds_data.namevalue(row,"SEX")
									+ ";"+ gcds_data.namevalue(row,"PASS_NO")
									+ ";"+ gcds_data.namevalue(row,"PASS_EXPIRE_DATE")
									+ ";"+ gcds_data.namevalue(row,"N_CARD_NO")
									+ ";"+ gcds_data.namevalue(row,"COUNTRY_CD")
									+ ";"+ gcds_data.namevalue(row,"TEL_NO")
									+ ";"+ gcds_data.namevalue(row,"MOBILE_NO")
									+ ";"+ gcds_data.namevalue(row,"ZIP_CD")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS1")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS2")
									+ ";"+ gcds_data.namevalue(row,"USTS")
									+ ";"+ gcds_data.namevalue(row,"ENG_NM");
  window.close();
 } else {
  window.close();
 }
 */
}


function ln_ChkBox_Chk(){
	if(chk_s.checked) {
		chk_s.value = '1';  //üũ
	}else {
		chk_s.value = ''   //��üũ
	}
}
</script>
<!-----------------------------------------------------------------------------
  DataSet Components(DS) ���� ����
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-- ���� -->
<comment id="__NSID__"><OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" value="+COM_SNAME">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
     D A T A S E T   C O M P O N E N T' S
  M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.CHK="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.CHK="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
	alert("�˻��� �����Ͱ� �����ϴ�.");
	}
</script>


<script language=JavaScript for=gcgd_disp event=OnClick(row,colid)>
	if(row<1&&colid=="CHK"){
		if(gcds_data.namevalue(1,colid)=="T"){
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="F";
			}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="T";
			}
		}
	}
</script>

<script language=JavaScript for=gcgd_disp event=OnDblClick(row,colid)>
  /*
	if (gcds_data.countrow>1) {
  var row = gcds_data.rowposition;
   window.returnValue =  gcds_data.namevalue(row,"CUST_NM") 
									+ ";"+ gcds_data.namevalue(row,"CUST_SID")
									+ ";"+ gcds_data.namevalue(row,"BIRTHDAY")
									+ ";"+ gcds_data.namevalue(row,"SEX")
									+ ";"+ gcds_data.namevalue(row,"PASS_NO")
									+ ";"+ gcds_data.namevalue(row,"PASS_EXPIRE_DATE")
									+ ";"+ gcds_data.namevalue(row,"N_CARD_NO")
									+ ";"+ gcds_data.namevalue(row,"COUNTRY_CD")
									+ ";"+ gcds_data.namevalue(row,"TEL_NO")
									+ ";"+ gcds_data.namevalue(row,"MOBILE_NO")
									+ ";"+ gcds_data.namevalue(row,"ZIP_CD")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS1")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS2")
									+ ";"+ gcds_data.namevalue(row,"USTS")
									+ ";"+ gcds_data.namevalue(row,"ENG_NM");
  window.close();
 }
 */
</script>


<!-----------------------------------------------------------------------------
      B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
 
<table cellpadding="0" cellspacing="0" border="0" width="620" height="390">
	<tr height="5"><td>&nbsp;</td></tr>
	<tr height="25">
		<td>
			<td align="right">
			<img src="<%=dirPath%>/Sales/images/p_find.gif"    style="cursor:hand" onclick="ln_Query()">
			<!-- <img src="<%=dirPath%>/Sales/images/p_select.gif"  style="cursor:hand" onclick="ln_Select()">&nbsp; -->
			<img src="<%=dirPath%>/Sales/images/p_exit.gif"   	style="cursor:hand" onclick="ln_Close()">
		</td>
	</tr>
	<tr height="25">
		<td colspan="2" >
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:610px;height:25px;font-size:12px;" bgcolor="#708090">
				<tr>
					<!-- <td align="center" bgcolor="#eeeeee" width="80px">�ް��������</td>
					<td  bgcolor="#FFFFFF">
						<comment id="__NSID__">
              <OBJECT id=gcem_start_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_start_dt','Text');">
						  <span style="position:relative;left:0px;top:-4px;">&nbsp;&nbsp;&nbsp;~</span> 
							<comment id="__NSID__">
							<OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_end_dt','Text');">
					</td> -->
					<td align="center" bgcolor="#eeeeee" width="80px">����</td>
					<td  bgcolor="#FFFFFF" width="400;">
						<input type="text" id="txt_empnmk" style="position:relative;;left:8px;width:70px;top:-1px;">&nbsp;
						<img src="<%=dirPath%>/Sales/images/help.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find()">
						<input type="text" id="txt_empno" style="position:relative;;left:8px;width:60px;top:-1px;">&nbsp;
					</td>
					<td align="center" width="70" bgcolor="#eeeeee">�����ް���</td>
					<td bgcolor="#FFFFFF" width="70">
						<input type="checkbox" id=chk_s   value=""    style="position:relative;left:5px;top:0px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk()" >
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="100%">
		<td colspan="2" valign="top"><br>
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:610px;height:260px;" bgcolor="#708090">
				<tr >
					<td valign="top" bgcolor="#FFFFFF" width="610px" >
							<comment id="__NSID__">
							<OBJECT id=gcgd_disp  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="position:relative;left:0px;width:612px;height:240px;font-size:12px;">
							<param name=DataID					value=gcds_data>
							<param Name=BorderStyle			value=0> 
							<param name=indwidth				value=0>
							<param name=Editable				value=true>
							<param name=fillarea				value=true>
							<param name=colsizing				value=true>
							<param name=UsingOneClick		value=true>
							<param name=TitleHeight			value=30>
							<param name=SortView        value="Left">
							<param name=format					value='
							<C>ID={CurRow} ,	Name="No",     Width=26,	 HeadBgColor=#B9D4DC  HeadAlign=Center  align=center edit=none</C> 
							<C>ID=CHK			 ,  Name="����",   width=28,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center EditStyle=CheckBox </C>
							<C>ID=DEPTNMK	 ,  Name="�μ�",   width=80,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left   edit=none  sort = true</C>
							<C>ID=TEAMNMK	 ,  Name="�Ҽ�",   width=80,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left   edit=none  sort = true</C>
							<C>ID=EMPNO	   ,  Name="���",   width=55,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center edit=none  sort = true</C>
							<C>ID=EMPNMK   ,  Name="����",   width=50,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left   edit=none  sort = true</C>
							<G> Name="���" HeadBgColor=#B9D4DC
								<C>ID=START_DT ,  Name="������", width=65,	 HeadBgColor=#B9D4DC,	HeadAlign=center align=center edit=none mask="XXXX/XX/XX"  sort = true</C>
								<C>ID=END_DT   ,  Name="������", width=65,	 HeadBgColor=#B9D4DC,	HeadAlign=center align=center edit=none mask="XXXX/XX/XX"  sort = true</C>
								<C>ID=CONT_GBNM , Name="����",   width=55,	 HeadBgColor=#B9D4DC,	HeadAlign=center align=left   edit=none sort = true </C>
								<C>ID=CON_YEAR  , Name="����",   width=40,	 HeadBgColor=#B9D4DC,	HeadAlign=center align=left   edit=none EditStyle=Lookup Data="gcds_cm017:COM_CODE:COM_SNAME" </C>
							</G>
							<C>ID=REWARD_YM , Name="�ް�\\�̽ǽ�\\������",   width=50,	 HeadBgColor=#B9D4DC,	HeadAlign=center align=left   edit=none mask="XXXX/XX" </C>

							'>
							</OBJECT></comment><script>__ws__(__NSID__);</script>	
							<fieldset style="width:612;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
							</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
</body>
</html>