<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<%	String dirPath = request.getContextPath(); %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �λ���� - ��������
+ ���α׷�ID : em_nation.jsp
+ ������� : ���� ������ �����ִ� �˾�â
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.10.31
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em010_S1,Em010_S2
----------------------------------------------------------------------------------*/
%>
<head>
<jsp:include page="/Sales/common/include/head.jsp"/>
<title>[���� ����]</title>
<script language="javascript">


	/* �������ε� */
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
		}


var parentGubun="";
get_cookdata();
var opener = window.dialogArguments;
/*----------------------------------------------------------------------------
 Description : ������ �ε�
----------------------------------------------------------------------------*/

function ln_Start(){

}
/*----------------------------------------------------------------------------
 Description : ��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%>/servlet/sales.em.Em_Nation_PopS?v_str1="+ txt_nation.value;
	gcds_data.Reset();
}
/*----------------------------------------------------------------------------
 Description : ���� �� â�ݱ�
----------------------------------------------------------------------------*/
	function ln_select() {
		 if (gcds_data.countrow>1) {
			var row = gcds_data.rowposition;
			window.returnValue =  gcds_data.namevalue(row,"COM_CODE") + ";"+ gcds_data.namevalue(row,"COM_SNAME");
			window.close();
		 } else {
			window.close();
		 }
	}
/*----------------------------------------------------------------------------
 Description : â�ݱ�
----------------------------------------------------------------------------*/
	function ln_Close() {
		window.close();
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
	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.CHK="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
	alert("�˻��� �����Ͱ� �����ϴ�.");
	}
</script>

<script language=JavaScript for=gcgd_disp event=OnDblClick(row,colid)>

		if(gcds_data.countrow>0){
				window.returnValue =  gcds_data.namevalue(row,"COM_CODE") + ";"+ gcds_data.namevalue(row,"COM_SNAME");
				window.close();
		}else{
			alert("�˻��� �����Ͱ� �����ϴ�.");
		}
</script>


<!-----------------------------------------------------------------------------
      B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
 
<table cellpadding="0" cellspacing="0" border="0" width="370" height="370"><br>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:360px;font-size:12px;" bgcolor="#708090">
				<tr>
					<td align="center" bgcolor="#eeeeee" width="50px">������</td>
					<td  bgcolor="#FFFFFF" width="300px;">
						<input type="text" id="txt_nation" name="txt_nation" style="position:relative;top:-2px;left:5px;width:100px;" onkeydown="if(event.keyCode==13)ln_Query();">&nbsp;&nbsp;
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="position:relative;top:2px;cursor:hand;" onclick="ln_Query()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top"><br>
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:360px;height:250px;" bgcolor="#708090">
				<tr>
					<td valign="top" bgcolor="#FFFFFF" >
						<comment id="__NSID__">
						<OBJECT id=gcgd_disp  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="position:relative;left:0px;width:360px;height:230px;font-size:12px;">
						<param name=DataID					value=gcds_data>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth				value=0>
						<param name=Editable				value=false>
						<param name=fillarea				value=true>
						<param name=colsizing				value=true>
						<param name=UsingOneClick		value=true>
						<param name=TitleHeight			value=30>
						<param name=format					value='
						<F> Name=NO				ID={CurRow}	HeadAlign=Center HeadBgColor=#B9D4DC Width=26,	align=right </F> 
						<FC>ID=COM_CODE					,	Name="�����ڵ�	",  width=100,	 HeadBgColor=#B9D4DC,	HeadAlign=center </FC>
						<FC>ID=COM_SNAME				,	Name="������",  width=215,	 HeadBgColor=#B9D4DC,	HeadAlign=center </FC>
						'>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:360;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr><br>
	<tr height="100%">
		<td bgcolor="#FFFFFF" align="center" colspan="2" valign="top">
			<img src="<%=dirPath%>/Sales/images/p_select.gif"   	style="position:relative;top:3px;cursor:hand" onclick="ln_select()">
			<img src="<%=dirPath%>/Sales/images/p_exit.gif"   	style="position:relative;top:3px;cursor:hand" onclick="ln_Close()">
		</td>
	</tr>
</table>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
<!-- </body>
</html> -->
