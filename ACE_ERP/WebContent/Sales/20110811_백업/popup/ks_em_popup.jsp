<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<%	String dirPath = request.getContextPath(); %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �λ���� - ��������
+ ���α׷�ID : ks_em_popup.jsp
+ ������� : �λ� �⺻����ȭ���� ������ư�� �̿��Ͽ� �ű��߰��� �ϴ� �˾�â
+ �� �� �� : �� �� ��
+ �ۼ����� : 2008.07. 29
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : KS_Em010_Cmcode
----------------------------------------------------------------------------------*/
%>
<head>
<title>[���� �ڵ� ����]</title>
<jsp:include page="/Sales/common/include/head.jsp"/>

<script language="javascript">

	/* �������ε� */
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			//fnInit(); //�ʱ�ȭ �Լ�
		}

var parentGubun="";

get_cookdata();

var strParam = new Array();
	
strParam=window.dialogArguments;

var gs_strGubun = strParam;


/*----------------------------------------------------------------------------
 Description : ������ �ε�
----------------------------------------------------------------------------*/

function ln_Start(){

	
	if(gs_strGubun == "01" || gs_strGubun == "11" ){	
			txt_code.value = "�Ҽ�";
	}else if(gs_strGubun == "02"){	
			txt_code.value = "���屸��";
	}else if(gs_strGubun == "03"){	
			txt_code.value = "���δ��ü";
	}else if(gs_strGubun == "04" || gs_strGubun == "14"  ){	
			txt_code.value = "�ٹ�����";
	}else if(gs_strGubun == "05"){	
			txt_code.value = "��������";
	}else if(gs_strGubun == "06"){	
			txt_code.value = "����";
	}else if(gs_strGubun == "07"){	
			txt_code.value = "��������";
	}else if(gs_strGubun == "08"){	
			txt_code.value = "�ڰݱ���";
	}

			txt_codenm.focus();
			
}
/*----------------------------------------------------------------------------
 Description : ��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){


	if(txt_code.value == "�Ҽ�"){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.ks_em.KS_Em010_Cmcode?v_str1=KS007&v_str2=" + txt_codenm.value;
	gcds_data.Reset();}
	else if(txt_code.value == "���屸��"){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.ks_em.KS_Em010_Cmcode?v_str1=KS006&v_str2=" + txt_codenm.value;
	gcds_data.Reset();}
	else if(txt_code.value == "����"){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.ks_em.KS_Em010_Cmcode?v_str1=KS002&v_str2=" + txt_codenm.value;
	gcds_data.Reset();}
	else if(txt_code.value == "�ٹ�����"){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.ks_em.KS_Em010_Cmcode?v_str1=KS001&v_str2=" + txt_codenm.value;
	gcds_data.Reset();}
	else if(txt_code.value == "���δ��ü"){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.ks_em.KS_Em010_Cmcode?v_str1=KS008&v_str2=" + txt_codenm.value;
	gcds_data.Reset();}
	else if(txt_code.value == "�ڰݱ���"){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.ks_em.KS_Em010_Cmcode?v_str1=KS009&v_str2=" + txt_codenm.value;
	gcds_data.Reset();}
	else if(txt_code.value == "��������"){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.ks_em.KS_Em010_Cmcode?v_str1=KS014&v_str2=" + txt_codenm.value;
	gcds_data.Reset();}	
	
}


/*----------------------------------------------------------------------------
 Description : ����
----------------------------------------------------------------------------*/

function ln_select() {

 if (gcds_data.countrow>=1) {
 
  var row = gcds_data.rowposition;
  
	   window.returnValue =  gs_strGubun
	   								+ ";"+ gcds_data.namevalue(row,"COM_CODE")
									+ ";"+ gcds_data.namevalue(row,"COM_SNAME")		
		window.close();  
		
 } 
 	else {
  window.close();
  
 }
 
}

</script>

<!-----------------------------------------------------------------------------
  DataSet Components(DS) ���� ����
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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

<script language=JavaScript for=gcgd_disp event=OnDblClick(row,colid)>

	if (gcds_data.countrow>=1) {
		 var row = gcds_data.rowposition;
	   window.returnValue =  gs_strGubun
	   								+ ";"+ gcds_data.namevalue(row,"COM_CODE")
									+ ";"+ gcds_data.namevalue(row,"COM_SNAME")	
		window.close();

 }
</script>


<!-----------------------------------------------------------------------------
      B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
 
<table cellpadding="0" cellspacing="0" border="0" width="250" height="390">
	<tr height="15"><td>&nbsp;</td></tr>
	<tr height="35">
		<td><b>&nbsp;[���� �ڵ� ����]</b></td>
			<td align="right">
			<img src="<%=dirPath%>/Sales/images/p_find.gif"    		style="cursor:hand" onclick="ln_Query()">
			<img src="<%=dirPath%>/Sales/images/p_select.gif"   	style="cursor:hand" onclick="ln_select()">  
		</td>
	</tr>
	<tr height="25">
		<td colspan="2" >
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:350px;height:25px;font-size:12px;" bgcolor="#708090">
				<tr>
          			<td align="center" bgcolor="#eeeeee" width="20px" align="center">&nbsp;HEAD</td>
					<td  bgcolor="#FFFFFF" width="120px;"><input type="text" id="txt_code" name="txt_code" style="position:relative;left:5px;width:100px;" readonly>
					</td>
          			<td align="center" bgcolor="#eeeeee" width="20px" align="center">&nbsp;DETAIL</td>
					<td  bgcolor="#FFFFFF" width="120px;"><input type="text" id="txt_codenm" name="txt_codenm" style="position:relative;left:5px;width:100px;" onkeydown="if(event.keyCode==13)ln_Query();">
					</td>					
				</tr>
			</table>
		</td>
	</tr>
	<tr height="100%">
		<td colspan="2" valign="top"><br>
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:350px;height:260px;" bgcolor="#708090">
				<tr >
					<td valign="top" bgcolor="#FFFFFF" width="300px" >
							<comment id="__NSID__">
							<OBJECT id=gcgd_disp  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="position:relative;left:0px;width:340px; height:240px;font-size:12px;">
							<param name=DataID					value=gcds_data>
							<param Name=BorderStyle			value=0> 
							<param name=indwidth				value=0>
							<param name=Editable				value=false>
							<param name=fillarea				value=true>
							<param name=colsizing				value=true>
							<param name=UsingOneClick		value=true>
							<param name=TitleHeight			value=30>
							<param name=format					value='
							<F> Name=NO				ID={CurRow}	HeadAlign=Center HeadBgColor=#B9D4DC Width=50,	align=center </F> 
							<FC>ID=COM_CODE					,	Name="��  ��",  		width=110,	 HeadBgColor=#B9D4DC,	HeadAlign=center align=center</FC>
							<FC>ID=COM_SNAME				,	Name="�� �� ��",  width=155,	 HeadBgColor=#B9D4DC,	HeadAlign=center </FC>
							'>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="width:350;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
							</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
<!-- </body>
</html> -->
